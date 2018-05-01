using System;
using System.Collections.Generic;

namespace WccDashboard.Entities
{
    public class ActivityHistoryItem
    {
        public DateTime Date { get; set; }
        public int TotalOpens { get; set; }
        public int TotalSent { get; set; }
    }

    public class ActivityHistoryData
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<ActivityHistoryItem> Data { get; set; }
    }

    public class ActivityHistoryCurrData
    {
        public ActivityHistoryData CurrentWeekData { get; set; }
        public ActivityHistoryData CurrentMonthData { get; set; }
    }
}
