using System;
using System.Collections.Generic;
using System.Web.Mvc;
using WccDashboard.Entities;
using WccDashboard.Services;

namespace WccDashboard.Web.Controllers
{
    public class ClinicController : Controller
    {
        private IPatientService accountService;
        private IClinicService clinicService;

        public ClinicController(IPatientService accountService, IClinicService clinicService)
        {
            this.accountService = accountService;
            this.clinicService = clinicService;
        }

        [Authorize]
        public JsonResult Patients()
        {
            List<Patient> patients = accountService.GetPatients();

            return Json(patients, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public JsonResult CabRequests(int? patientId)
        {
            CabRequestCurrData cabRequests = null;

            try
            {
                cabRequests = clinicService.GetCurrCabRequests(patientId);
            }
            catch (Exception ex)
            {
                //TODO: Handle exception
            }

            return Json(cabRequests, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public JsonResult ActivityHistory(int? patientId)
        {
            ActivityHistoryCurrData actHistory = null;
            
            try
            {
                actHistory = clinicService.GetCurrActivityHistory(patientId);
            } catch(Exception ex){
                //TODO: Handle exception
            }

            return Json(actHistory, JsonRequestBehavior.AllowGet);
        }
    }
}