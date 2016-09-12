<cfparam name="errorMsg" default="">

<cfoutput>
	<form role="form" action="#buildUrl("security.sendpasswordreset")#" method="post" autocomplete="off">
		<input type="hidden" name="resetAction" value="sendEmail">

		<p>
			Enter your email here to request a temporary login code.
		</p>
		<br/>

		<input type="text" name="email" class="form-control" placeholder="Email" required autofocus>

		<button class="largeButton" type="submit" name="forgotloginBtn">Reset My Password</button>

		<a href="#buildUrl("security")#" class="button">Return to Login</a>
	</form>
</cfoutput>