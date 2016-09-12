<cfparam name="resetCode" default="">

<cfoutput>
	<form role="form" action="#buildUrl("security.dopasswordreset")#" method="post" autocomplete="off">
		<ul>
			<cfif NOT len(trim(resetCode))>
				<li>
					<input type="text" name="resetCode" class="form-control" placeholder="Reset Code" required autofocus>
				</li>
				<li>
					<input type="password" name="password" class="form-control" placeholder="New Password" required>
				</li>
			<cfelse>
				<li>
					<input type="hidden" value="#resetCode#" name="resetcode">
					<input type="password" name="password" class="form-control" placeholder="New Password" required autofocus>
				</li>
			</cfif>
			<li>
				<input type="password" name="confirmpassword" class="form-control" placeholder="Confirm Password" required>
			</li>
		</ul>

		<button class="largeButton" type="submit" name="loginBtn">Set Password</button>

		<a href = "#buildUrl(":security.default")#" >Return To Login</a>
	</form>
</cfoutput>