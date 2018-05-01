using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WccDashboard.Entities
{
    public class AuditLog
    {
        public int AuditLogId { get; set; }
        public DateTime Timestamp { get; set; }
        public string Action { get; set; }
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string Data { get; set; }
        public string IPAddress { get; set; }
        public string USerAgent { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public int AppointmentId { get; set; }
        public int AccountId { get; set; }
        public int AddressId { get; set; }
        public DateTime CreatedOn { get; set; }
        public bool ApptCancelled { get; set; }
        public bool ApptNoShow { get; set; }
        public bool TransportArranged { get; set; }
        public int PatientId { get; set; }
    }
}
