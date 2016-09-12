component accessors="true" {

	property name="beanfactory";
	property name="formatterLibrary";
	property name="fw";

	public any function init(fw){
		variables.fw = arguments.fw;
		return this;
	}

	// Hack to deal with issue: https://github.com/framework-one/di1/issues/53
	public any function onMissingMethod(missingMethodName,missingMethodArguments){
		if(left(arguments.missingMethodName,3) != "set"){
			var meta = getMetaData();
			throw(message="Method '#arguments.missingMethodName#' not defined in bean #listLast(meta.name,".")#");
		}
	}

	public any function getSubsystemBeanFactory( required string name){
		return getFW().getSubsystemBeanFactory( arguments.name );
	}


	private struct function createErrorStruct(propertyname,message){
		var returnStruct = {"propertyname":arguments.propertyname,"message":arguments.message};
		return returnStruct;
	}

	/**
	 * @hint Validates all required fields within an object
	 */
	private struct[] function validate() {
		var errors = [];

		for(var beanProperty in GetMetaData().properties ){
			var name = beanProperty.name;
			var message = "";

			// Skip over services and gateways
			if( name contains "service" || name contains "gateway" ){
				continue;
			}

			var validationRule = "any";
			if( structKeyExists(beanProperty,"validate") ){
				if( !listfindnocase("email,zip,zipcode,integer,float,numeric,string,boolean",beanProperty.validate) ){
					throw(
						  type = "custom"
						, message = "Invalid validation type specified"
						, detail = "Invalid validation type #beanProperty.validate# specified for property #name#"
					);
				} else {
					validationRule = beanProperty.validate; // email zip zipcode custom
				}
			}

			var customValidator = structKeyExists(beanProperty,"customValidator") ? beanProperty.customValidator : "";
			var displayname = structKeyExists(beanProperty,"displayname") ? beanProperty.displayname : name;
			var isRequired = structKeyExists(beanProperty,"required") ? beanProperty.required : false;
			var minlength = structKeyExists(beanProperty,"minlength") ? beanProperty.minvalue : "";
			var maxlength = structKeyExists(beanProperty,"maxlength") ? beanProperty.maxlength : "";
			var minvalue = structKeyExists(beanProperty,"minvalue") ? beanProperty.minvalue : "";
			var maxvalue = structKeyExists(beanProperty,"maxvalue") ? beanProperty.maxvalue : "";
			var regex = structKeyExists(beanProperty,"regex") ? beanProperty.regex : "";

			var value = this["get" & name]();
			if( isNull(value) ){
				value = "";
			}

			if( len(trim(customValidator)) ){
				var customValidationResult = this[customValidator]();
				if( !customValidationResult.success ){
					message = customValidationResult.error;
				}
			}

			if(
				isArray(value)
				|| isStruct(value)
				|| (
					!isRequired
					&& !len(trim(value))
				)
			){
				continue;
			}

			if( isRequired && !len(trim(value)) ){
				message = displayname & " is required.";
			} else {

				switch(validationRule){
					case "numeric":
						if( !isNumeric(value) ){
							message = displayname & " must be a numeric value.";
						}
					break;

					case "date":
					case "timestamp":
						if( !isDate(value) ){
							message = displayname & " must be a date/time value.";
						}
					break;

					case "email":
						if( !isValid("email",value) ){
							message = displayname & " must be a valid email address.";
						}
					break;

					case "zip":
					case "zipcode":
						if( !isValid("zipcode",value) ){
							message = "Invalid zipcode or postal code";
						}
					break;
				}

			}

			if( len(trim(message)) ){
				arrayAppend(errors, createErrorStruct(propertyname=name,message=message));
			}
		}

		return errors;
	}
}