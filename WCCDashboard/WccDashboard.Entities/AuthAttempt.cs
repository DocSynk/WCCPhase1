using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WccDashboard.Entities
{
    public class AuthAttempt
    {
        public int AttemptId { get; set; }
        public string HttpHost { get; set; }
        public int AccountId { get; set; }
        public bool WasSuccessful { get; set; }
        public DateTime AttemptedOn { get; set; }
        public string AttemptedIp { get; set; }
        public string UserAgent { get; set; }
    }
}
