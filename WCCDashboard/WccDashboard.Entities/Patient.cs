using System;

namespace WccDashboard.Entities
{
    public class Patient
    {
        public string MRN { get; set; }
        public int AccountId { get; set; }
        public int PatientId { get; set; }
        public int PracticeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string CellPhone { get; set; }
        public DateTime DOB { get; set; }
        public string Gender { get; set; }
        public string InsuranceProvider { get; set; }
        public DateTime LastLoggedInOn { get; set; }
    }
}
