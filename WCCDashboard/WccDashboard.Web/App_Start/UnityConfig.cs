using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;
using System.Web.Mvc;
using Unity.Mvc5;


namespace WccDashboard.Web
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
            var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();

            //container.RegisterType<ICourseService, CourseService>();
            //container.RegisterType<IInstitutionService, InstitutionService>();

            container.LoadConfiguration();

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}