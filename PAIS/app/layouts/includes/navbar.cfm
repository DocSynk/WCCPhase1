
<cfoutput>
	<nav class="navbar navbar-default navbar-static-top navbar-inverse" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<a class="navbar-brand" href="#buildURL("main.patientView")#">#getBeanFactory().getBean("applicationDisplayName")#</a>
				<!---<a class="navbar-brand pull-right" href="#buildURL("main.login")#"><i class="glyphicon glyphicon-log-out"></i></a>--->
			</div>
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<!---<ul class="nav navbar-nav navbar-left">
					<cfif session.user.isLoggedIn()>
						<cfif session.user.isUserInGroup("ADMIN")>
							<li <cfif rc.controllerName EQ "main">class="active"</cfif>><a href="#buildURL("main.index")#">Main Home</a></li>
						</cfif>
					</cfif>
				</ul>--->
			
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#buildURL('main.patientView')#">Home</a></li>
					<li><a href="#buildURL('main.logout')#">Logout&nbsp<i class="glyphicon glyphicon-log-out"></i></a></li>
					<cfif session.user.isLoggedIn()>
						<li class="dropdown">
							<ul id="actions-submenu" class="dropdown-menu">
								<li><a href="#buildURL(rc.xeh.logout)#">Logout</a></li>
							</ul>
						</li>
					</cfif>
				</ul>
			</div><!-- /.navbar-collapse -->
		</div>
	</nav>

</cfoutput>

