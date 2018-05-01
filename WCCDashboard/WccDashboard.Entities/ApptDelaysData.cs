using System;
using System.Collections.Generic;

namespace WccDashboard.Entities
{
    public class ApptDelayItem
    {
        public DateTime Date { get; set; }
        public int TotalDelays { get; set; }
    }

    public class ApptDelayData
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<ApptDelayItem> Data { get; set; }
    }

    public class ApptDelayCurrData
    {
        public ApptDelayData CurrentWeekData { get; set; }
        public ApptDelayData CurrentMonthData { get; set; }
    }

}
