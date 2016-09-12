<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Demo 1</title>

	<!-- Bootstrap css -->
	<link rel="stylesheet" href="/common/assets/libs/bootstrap_4_0_0_alpha_2/css/bootstrap.min.css" />
    <link href="/common/assets/libs/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="/assets/libs/bootstrap/css/styles.css">

	<!-- Datatables CSS-->
	<link rel="stylesheet" type="text/css" href="/common/assets/libs/datatables/media/css/jquery.dataTables.css"/>

	<!-- JQueryUI CSS -->
	<link rel="stylesheet" type="text/css" href="/assets/libs/jquery-ui-1.11.2.custom/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/assets/libs/jquery-ui-1.11.2.custom/jquery-ui.structure.css">
	<link rel="stylesheet" type="text/css" href="/assets/libs/jquery-ui-1.11.2.custom/jquery-ui.theme.css">

	<link rel="stylesheet" type="text/css" href="/common/assets/libs/datetimepicker/jquery.datetimepicker.css" />
	<link rel="stylesheet" type="text/css" href="/common/assets/libs/clockpicker/bootstrap-clockpicker.min.css" />

	<!-- Our core css file -->
	<link rel="stylesheet" href="assets/css/main.css">

	<cfloop array="#rc.css#" index="local.i" item="local.cssfilepath">
		<cfoutput><link rel="stylesheet" type="text/css" href="#local.cssfilepath#" /></cfoutput>
	</cfloop>

	<script src="/common/assets/libs/jquery/jquery-2.1.4.min.js"></script>
	<script src="/common/assets/libs/modernizr.js" charset="utf-8"></script>
	<script src="/common/assets/libs/ckeditor/ckeditor.js"></script>
	<script src="/common/assets/libs/ckeditor/adapters/jquery.js"></script>
	<script src="/common/assets/libs/datetimepicker/jquery.datetimepicker.js" charset="utf-8"></script>
	<script src="/common/assets/libs/clockpicker/jquery-clockpicker.min.js" charset="utf-8"></script>
	<script src="/common/assets/libs/moment.min.js"></script>

	<!-- Datatables JS-->
	<script type="text/javascript" src="/common/assets/libs/datatables/media/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="/common/assets/libs/datatables/extensions/TableTools/js/dataTables.tableTools.js"></script>

	<!-- Common javascript functions -->
    <script src="assets/js/main.js"></script>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="libs/respondjs/dest/respond.src.js"></script>
    <![endif]-->
</head>
<body>
	<nav class="navbar navbar-fixed-top navbar-dark bg-primary">
	    <button class="navbar-toggler hidden-sm-up pull-right" type="button" data-toggle="collapse" data-target="#collapsingNavbar">
	        ☰
	    </button>
	    <a class="navbar-brand" href="/">Modular Subsystems FW/1</a>
	    <div class="collapse navbar-toggleable-xs" id="collapsingNavbar">
	        <ul class="nav navbar-nav pull-right">
	        </ul>
	    </div>
	</nav>


	<div class="container-fluid" id="main">
	    <div class="row row-offcanvas row-offcanvas-left">
	        <div class="col-md-3 col-lg-2 sidebar-offcanvas" id="sidebar" role="navigation">
	            <ul class="nav nav-pills nav-stacked">
		            <cfoutput>
			            <li class="nav-item"><a class="nav-link" href="#buildUrl(':main.default')#">Server List</a></li>
						<li class="nav-item"><a class="nav-link" href="#buildUrl(':main.breakit')#">Breakit</a></li>
					</cfoutput>
	            </ul>
	        </div>
	        <!--/col-->

	        <div class="col-md-9 col-lg-10 main">
	            <!--toggle sidebar button-->
	            <p class="hidden-md-up">
	                <button type="button" class="btn btn-primary-outline btn-sm" data-toggle="offcanvas"><i class="fa fa-chevron-left"></i> Menu</button>
	            </p>

	            <!--- <h1 class="display-4 hidden-xs-down">Modular Subsystems FW/1</h1> --->
	            <cfoutput>#body#</cfoutput>
	        </div>
	        <!--/main col-->
	    </div>
	</div>

	 <!--scripts loaded here-->
    <script src="/common/assets/libs/tether.min.js"></script>
	<script src="/common/assets/libs/bootstrap_4_0_0_alpha_2/js/bootstrap.min.js"></script>
    <script src="/assets/libs/bootstrap/js/scripts.js"></script>
	<script src="/assets/libs/jquery-ui-1.11.2.custom/jquery-ui.js"></script>
</body>
</html>