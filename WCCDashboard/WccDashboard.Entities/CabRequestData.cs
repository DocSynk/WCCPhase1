using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WccDashboard.Entities
{
    public class CabRequestDataItem
    {
        public DateTime Date { get; set; }
        public int TotalRequests { get; set; }
    }

    public class CabRequestData
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<CabRequestDataItem> Data { get; set; }
    }

    public class CabRequestCurrData
    {
        public CabRequestData CurrentWeekData { get; set; }
        public CabRequestData CurrentMonthData { get; set; }
    }
}
