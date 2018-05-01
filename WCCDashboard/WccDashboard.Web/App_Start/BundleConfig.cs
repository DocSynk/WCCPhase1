using System.Web;
using System.Web.Optimization;

namespace WccDashboard.Web
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                       "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new ScriptBundle("~/bundles/angularApp").Include(
                    "~/Scripts/Angular1.6.2/angular.js",
                     "~/Scripts/Angular1.6.2/angular-route.js",
                     "~/Scripts/Angular1.6.2/angular-animate.js",
                     "~/Scripts/Angular1.6.2/angular-resource.js",
                     "~/Scripts/Angular1.6.2/angular-touch.js",
                     "~/Scripts/Angular1.6.2/angular-ui-router.js",
                     "~/Scripts/Angular1.6.2/ui-bootstrap-tpls-2.5.0.js",

                     "~/Scripts/Angular-nvd3/d3.min.js",
                     "~/Scripts/Angular-nvd3/nv.d3.min.js",
                     "~/Scripts/Angular-nvd3/angular-nvd3.min.js",

                     "~/Scripts/Angular-Loading/spin.min.js",
                     "~/Scripts/Angular-Loading/angular-loading.js",
                     
                     "~/AngularApp/app.js",
                     "~/AngularApp/route.js",
                     "~/AngularApp/common/services/servicesModule.js",
                     "~/AngularApp/common/services/appointmentService.js",
                     "~/AngularApp/common/services/clinicService.js",
                     "~/AngularApp/common/directives/directivesModule.js",
                     "~/AngularApp/common/directives/appointments/apptNoShowsCancels.js",
                     "~/AngularApp/common/directives/appointments/apptDelays.js",
                     "~/AngularApp/common/directives/cabRequests/cabRequests.js",
                     "~/AngularApp/common/directives/activityHistory/activityHistory.js",
                     "~/AngularApp/common/directives/appointments/apptLocationHistory.js",
                     "~/AngularApp/clinicDashboard/clinicDashboardModule.js",
                     "~/AngularApp/clinicDashboard/clinicDashboardController.js",
                      "~/AngularApp/patientDashboard/patientDashboardModule.js",
                     "~/AngularApp/patientDashboard/patientDashboardController.js"
                     ));


            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                       "~/Scripts/Angular-Loading/angular-loading.css",
                       "~/Scripts/Angular-nvd3/nv.d3.css",
                      "~/Content/site.css"));
        }
    }
}
