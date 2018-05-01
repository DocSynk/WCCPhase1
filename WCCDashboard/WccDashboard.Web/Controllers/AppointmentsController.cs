using System;
using System.Collections.Generic;
using System.Web.Mvc;

using WccDashboard.Entities;
using WccDashboard.Services;

namespace WccDashboard.Web.Controllers
{
    public class AppointmentsController : Controller
    {
        private IClinicService clinicService;

        public AppointmentsController(IClinicService clinicService)
        {
            this.clinicService = clinicService;
        }

        [Authorize]
        public JsonResult NoShowsAndCancels(int? patientId)
        {
            ApptNoShowCancelCurrData appointments = null;

            try
            {
                appointments = clinicService.GetCurrAppointmentNoShowsAndCancels(patientId);

            } catch(Exception ex){
               //TODO: Handle exception
            }

            return Json(appointments, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public JsonResult Delays(string delayType, int? patientId)
        {
            ApptDelayCurrData apptsData = null;

            try
            {
                apptsData = clinicService.GetCurrAppointmentDelays(delayType, patientId);
            }
            catch (Exception ex)
            {
               //TODO: Handle exception
            }

            return Json(apptsData, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public JsonResult LocationHistory(int? patientId)
        {
            List<LocationHistoryItem> locationHistory = null;

            try
            {
                locationHistory = clinicService.GetCurrLocationHistory(patientId);
            }
            catch (Exception ex)
            {
                //TODO: Handle exception
            }

            return Json(locationHistory, JsonRequestBehavior.AllowGet);
        }
    }
}