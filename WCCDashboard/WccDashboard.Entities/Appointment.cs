using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WccDashboard.Entities
{
    public class Appointment
    {
        public int AppointmentId { get; set; }
        public int AccountId { get; set; }
        public int PracticeId { get; set; }
        public int PatientId { get; set; }
        public DateTime AppointmentDate { get; set; }
        public DateTime AppointmentTime { get; set; }
        public bool IsAvailable { get; set; }
        public string DoctorFirstName { get; set; }
        public string DoctorLastName { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }
    }
}