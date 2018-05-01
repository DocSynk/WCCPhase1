using System;
using System.Collections.Generic;

namespace WccDashboard.Entities
{
    public class LocationHistoryItem
    {
        public string LocationType { get; set; }
        public int TotalOpens { get; set; }
        public int TotalSent { get; set; }
    }

    public class LocationHistoryData
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<LocationHistoryItem> Data { get; set; }
    }

    public class LocationHistoryCurrData
    {
        public LocationHistoryData CurrentWeekData { get; set; }
        public LocationHistoryData CurrentMonthData { get; set; }
    }
}