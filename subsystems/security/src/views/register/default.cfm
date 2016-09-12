<cfoutput>
	<form action="#buildUrl(rc.action)#" method="post" name="registrationForm" id="registrationForm" autocomplete="off" novalidate>
		<input type="hidden" value="1" name="planId">

		<fieldset class="section" id="tenantSection">
			<ul>
				<li>
					<label for="firstName">First Name</label>
					<input type="text" name="firstName" id="firstName" value="" required="true" maxlength="50" placeholder="First Name">
				</li>
				<li>
					<label for="lastName">Last Name</label>
					<input type="text" name="lastName" id="lastName" value="" required="true" maxlength="50" placeholder="Last Name">
				</li>
				<li>
					<label for="email">Email</label>
					<input type="email" name="email" id="email" value="" required="true" maxlength="50" placeholder="Email">
				</li>
			</ul>
		</fieldset>

		<div style="text-align:center;padding-top:10px;clear:left;margin-left:10px;margin-right: 10px;">
			<input type="submit" value="Register &raquo;" id="registerButton" class="largeButton" name="registerButton"><br/>
			<p>
				Already have an account? <a href="#buildUrl("main.default")#" class="button">Login Here</a>
			</p>
		</div>
	</form>

	<script>
		var emailunique = '#buildUrl("register.uniqueemail")#';
	</script>
	<script src="/subsystems/#getsubsystem()#/assets/js/views/register_default.js"></script>
</cfoutput>