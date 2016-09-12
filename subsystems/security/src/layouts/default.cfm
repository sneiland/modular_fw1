<cfparam name="rc.shownav" default="true">


<cfoutput>
	<script>
		var ss_tenants = {};
	</script>

	<cfif rc.secUser.isSuperAdmin()>
		<div style="padding-bottom:10px;" class="roleswitcher">
			<div class="btn-group pull-right" role="group" aria-label="Basic example" style="margin-bottom:10px;">
				<a role="button" href="#buildUrl(action="main.setrole",querystring="role=superadmin&returnaction=#rc.action#")#" class="btn btn-primary <cfif session.currentViewRole EQ "superadmin">active</cfif>">Super Admin</a>
				<a role="button" href="#buildUrl(action="main.setrole",querystring="role=admin&returnaction=#rc.action#")#" class="btn btn-primary <cfif session.currentViewRole EQ "admin">active</cfif>">Admin</a>
			</div>
		</div>
	</cfif>

	<h1>Administration</h1>

	<cfif session.currentTenantId AND rc.secUser.isSuperAdmin()>
		<h2>
			Currently viewing tenant: #session.currentTenantName#
			<a href="#buildUrl(action="main.clearfilter")#"><em>Clear</em></a>
		</h2>
	</cfif>

	<cfif rc.shownav>
		<nav>
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a href="#buildUrl(action="main.default")#" class="nav-link <cfif getSection() EQ "main">active</cfif>">
						Overview
					</a>
				</li>
				<cfif rc.secUser.isSuperAdmin()>
					<li class="nav-item">
						<a href="#buildUrl("tenants.default")#" class="nav-link <cfif getSection() EQ "tenants">active</cfif>">
							Tenants
						</a>
					</li>
				</cfif>

				<li class="nav-item"><a href="#buildUrl("users.default")#" class="nav-link <cfif getSection() EQ "users">active</cfif>">Users</a></li>
				<cfif rc.secUser.isSuperAdmin()>
					<li class="nav-item"><a href="#buildUrl("groups.default")#" class="nav-link <cfif getSection() EQ "groups">active</cfif>">Groups</a></li>
					<li class="nav-item"><a href="#buildUrl("roles.default")#" class="nav-link <cfif getSection() EQ "roles">active</cfif>">Roles</a></li>
					<li class="nav-item"><a href="#buildUrl("permissions.default")#" class="nav-link <cfif getSection() EQ "permissions">active</cfif>">Permissions</a></li>
					<li class="nav-item">
						<a href="#buildUrl("plans.default")#" class="nav-link <cfif getSection() EQ "plans">active</cfif>">Plans</a>
					</li>
				</cfif>
			</ul>
		</nav>
	</cfif>
	<div class="tab-content" style="background-color: ##fff; padding: 10px; border-bottom-left-radius:5px; border-bottom-right-radius:5px;">
		<div role="tabpanel" class="tab-pane active" id="home">
			<div class="row">
				<div class="col-xs-12">
					#body#
				</div>
			</div>
		</div>
	</div>
</cfoutput>