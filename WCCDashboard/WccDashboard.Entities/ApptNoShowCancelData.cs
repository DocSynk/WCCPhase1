using System;
using System.Collections.Generic;

namespace WccDashboard.Entities
{
    public class ApptNoShowCancelItem
    {
        public DateTime Date { get; set; }
        public int TotalNoShows { get; set; }
        public int TotalCancelled { get; set; }
    }

    public class ApptNoShowCancelData
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<ApptNoShowCancelItem> Data { get; set; }
    }

    public class ApptNoShowCancelCurrData
    {
        public ApptNoShowCancelData CurrentWeekData { get; set; }
        public ApptNoShowCancelData CurrentMonthData { get; set; }
    }
}