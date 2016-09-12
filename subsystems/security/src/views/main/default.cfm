<cfoutput>
	<form action="#buildURL(getSection() & '.doLogin')#" method="post" name="loginForm" id="loginForm" autocomplete="off">
		<ul>
			<li>
				<label for="Email">Email :</label>
				<input name="email" type="text" id="email" size="30" title="Enter your email" placeholder="Email" value="admin" required/>
			</li>
			<li>
				<label for="password">Password :</label>
				<input name="password" type="password" id="password" size="30" title="Enter your password" placeholder="Password" value="password" required/>
			</li>
			<cfif rc.rememberme>
				<label for="rememberme" style="display:inline-block;">Remember Me :</label>
				<input type="checkbox" name="rememberme" id="rememberme" value="1">
			</cfif>
			<li>
				<input type="submit" value="Login &raquo;" class="largeButton">
			</li>
			<li>
				<a href="#buildUrl("security.forgotpassword")#" style="float:right;">Forget your password?</a>
				<cfif rc.enableregister>
					<a href="#buildUrl("register")#" class="button">Register</a>
				</cfif>
			</li>
		</ul>
		<br/>
	</form>
</cfoutput>
<script>
	$("#loginForm").validate();
</script>