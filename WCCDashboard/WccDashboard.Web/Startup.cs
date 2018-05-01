using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WccDashboard.Web.Startup))]
namespace WccDashboard.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
