using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

using WccDashboard.Web.Models;
using WccDashboard.Services;
using WccDashboard.Entities;

namespace WccDashboard.Web.Controllers
{
    public class AccountController : Controller
    {
        private IUserService userService;

        public AccountController(IUserService userService)
        {
            this.userService = userService;
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            User userDetails;

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            try
            {
                userDetails = userService.GetUserDetails(model.Email, model.Password);

                if (userDetails != null)
                {
                    FormsAuthentication.SetAuthCookie(model.Email, false);

                    var authTicket = new FormsAuthenticationTicket(1, userDetails.FirstName + ' ' + userDetails.LastName, DateTime.Now, DateTime.Now.AddMinutes(720), false, "");
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    HttpContext.Response.Cookies.Add(authCookie);
                    return RedirectToAction("Index", "Home");
                }

                else
                {
                    ModelState.AddModelError("", "Login Failed. Please check the credentials.");
                    return View(model);
                }
            }
            catch
            {
                ModelState.AddModelError("", "Login Failed. Please try again.");
                return View(model);
            }
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            //AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                int result = userService.Register(new User {  FirstName= model.FirstName, LastName= model.LastName, Password=model.Password, Email=model.Email});
                if (result == 0)
                {
                    ModelState.AddModelError("", "Registration Failed. User already exists.");
                }
                else {
                    return RedirectToAction("RegComplete");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/RegComplete
        [AllowAnonymous]
        public ActionResult RegComplete(string returnUrl)
        {
            return View("CompleteRegistration");
        }
    }
}