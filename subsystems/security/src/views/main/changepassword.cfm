<cfoutput>
	<cfloop array="#rc.errors#" index="i" item="error">
		<p>#error#</p>
	</cfloop>

	<form role="form" action="#buildUrl(rc.action)#"id="changePasswordForm"  method="post" autocomplete="off">
		<input type="hidden" name="returnaction" value=":main">

		<p>You are required to change your password to continue.</p>
		<ul>
			<li>
				<input type="password" name="newpassword" id="newpassword" class="form-control" placeholder="New Password" required autofocus>
			</li>
			<li>
				<input type="password" name="confirmpassword" class="form-control" placeholder="Confirm Password" required>
			</li>
		</ul>

		<input class="largeButton" type="submit" name="loginBtn" value="Set Password">
	</form>

	<script src="/subsystems/#getsubsystem()#/assets/js/views/security_changepassword.js"></script>
</cfoutput>