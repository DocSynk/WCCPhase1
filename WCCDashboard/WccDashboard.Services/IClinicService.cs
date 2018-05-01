using System;
using System.Collections.Generic;

using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public interface IClinicService
    {
        ApptNoShowCancelCurrData GetCurrAppointmentNoShowsAndCancels(int? patientId);
        ApptDelayCurrData GetCurrAppointmentDelays(string delayType, int? patientId);
        CabRequestCurrData GetCurrCabRequests(int? patientId);
        ActivityHistoryCurrData GetCurrActivityHistory(int? patientId);
        List<LocationHistoryItem> GetCurrLocationHistory(int? patientId);
    }
}