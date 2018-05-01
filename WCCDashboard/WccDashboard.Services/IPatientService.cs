using System.Collections.Generic;

using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public interface IPatientService
    {
        List<Patient> GetPatients();
    }
}
