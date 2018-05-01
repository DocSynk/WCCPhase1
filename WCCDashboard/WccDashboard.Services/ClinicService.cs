using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public class ClinicService:IClinicService
    {
        private string connString = string.Empty;

        public ClinicService()
        {
            connString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;
        }

        public ApptNoShowCancelCurrData GetCurrAppointmentNoShowsAndCancels(int? patientId)
        {
            List<ApptNoShowCancelItem> currMonthData = new List<ApptNoShowCancelItem>();
            List<ApptNoShowCancelItem> currWeekData = null;
            DataSet dataset = new DataSet();
            DataTable dtApptCancelNoShows;
            DateTime monthStartDate, monthEndDate, weekStartDate, weekEndDate, currDate;
            ApptNoShowCancelCurrData response = null;

            currDate = DateTime.Now;

            weekStartDate = currDate.AddDays(-(int)currDate.DayOfWeek).Date;
            weekEndDate = weekStartDate.AddDays(7).AddSeconds(-1);
            monthStartDate = new DateTime(currDate.Year, currDate.Month, 1);
            monthEndDate = monthStartDate.AddMonths(1).AddDays(-1);

            monthEndDate = (currDate.Day <= monthEndDate.Day) ? currDate : monthEndDate;
            weekEndDate = (currDate.Day <= weekEndDate.Day) ? currDate : weekEndDate;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_appt_cancel_and_noshows", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fromDate", SqlDbType.DateTime).Value = monthStartDate;
                cmd.Parameters.Add("@toDate", SqlDbType.DateTime).Value = monthEndDate;
                if (patientId != null)
                {
                    cmd.Parameters.Add("@patientId", SqlDbType.NVarChar).Value = patientId.Value;
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtApptCancelNoShows = dataset.Tables[0];

                foreach (DataRow row in dtApptCancelNoShows.Rows)
                {
                    currMonthData.Add(new ApptNoShowCancelItem
                    {
                        TotalCancelled = Convert.ToInt32(row["Cancelled"]),
                        TotalNoShows = Convert.ToInt32(row["NoShows"]),
                        Date = Convert.ToDateTime(row["CreatedOn"])
                    });
                }
            }

            if (currMonthData != null)
            {
                currWeekData = currMonthData.FindAll(a => a.Date >= weekStartDate && a.Date <= weekEndDate);
            }

            response = new ApptNoShowCancelCurrData();
            response.CurrentWeekData = new ApptNoShowCancelData { Data = currWeekData , StartDate=weekStartDate, EndDate=weekEndDate};
            response.CurrentMonthData = new ApptNoShowCancelData { Data = currMonthData, StartDate = monthStartDate, EndDate = monthEndDate };

            return response;
        }

        public ApptDelayCurrData GetCurrAppointmentDelays(string delayType, int? patientId)
        {
            List<ApptDelayItem> currMonthData = new List<ApptDelayItem>();
            List<ApptDelayItem> currWeekData = null;
            DataSet dataset = new DataSet();
            DataTable dtApptDelays;
            DateTime monthStartDate, monthEndDate, weekStartDate, weekEndDate, currDate;
            ApptDelayCurrData response = null;

            currDate = DateTime.Now;

            weekStartDate = currDate.AddDays(-(int)currDate.DayOfWeek).Date;
            weekEndDate = weekStartDate.AddDays(7).AddSeconds(-1);
            monthStartDate = new DateTime(currDate.Year, currDate.Month, 1);
            monthEndDate = monthStartDate.AddMonths(1).AddDays(-1);

            monthEndDate = (currDate.Day <= monthEndDate.Day) ? currDate : monthEndDate;
            weekEndDate = (currDate.Day <= weekEndDate.Day) ? currDate : weekEndDate;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_appointment_delays", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fromDate", SqlDbType.DateTime).Value = monthStartDate;
                cmd.Parameters.Add("@toDate", SqlDbType.DateTime).Value = monthEndDate;
                if (!string.IsNullOrEmpty(delayType))
                {
                    cmd.Parameters.Add("@delayType", SqlDbType.NVarChar).Value = delayType;
                }
                if (patientId != null)
                {
                    cmd.Parameters.Add("@patientId", SqlDbType.NVarChar).Value = patientId.Value;
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtApptDelays = dataset.Tables[0];

                foreach (DataRow row in dtApptDelays.Rows)
                {
                    currMonthData.Add(new ApptDelayItem
                    {
                        TotalDelays = Convert.ToInt32(row["TotalDelays"]),
                        Date = Convert.ToDateTime(row["CreatedOn"])
                    });
                }
            }

            if (currMonthData != null)
            {
                currWeekData = currMonthData.FindAll(a => a.Date >= weekStartDate && a.Date <= weekEndDate);
            }

            response = new ApptDelayCurrData();
            response.CurrentWeekData = new ApptDelayData { Data = currWeekData, StartDate = weekStartDate, EndDate = weekEndDate };
            response.CurrentMonthData = new ApptDelayData { Data = currMonthData, StartDate = monthStartDate, EndDate = monthEndDate };

            return response;
        }

        public CabRequestCurrData GetCurrCabRequests(int? patientId)
        {
            List<CabRequestDataItem> currMonthData = new List<CabRequestDataItem>();
            List<CabRequestDataItem> currWeekData = null;
            DataSet dataset = new DataSet();
            DataTable dtCabRequests;
            DateTime monthStartDate, monthEndDate, weekStartDate, weekEndDate, currDate;
            CabRequestCurrData response = null;

            currDate = DateTime.Now;

            weekStartDate = currDate.AddDays(-(int)currDate.DayOfWeek).Date;
            weekEndDate = weekStartDate.AddDays(7).AddSeconds(-1);
            monthStartDate = new DateTime(currDate.Year, currDate.Month, 1);
            monthEndDate = monthStartDate.AddMonths(1).AddDays(-1);

            monthEndDate = (currDate.Day <= monthEndDate.Day) ? currDate : monthEndDate;
            weekEndDate = (currDate.Day <= weekEndDate.Day) ? currDate : weekEndDate;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_cab_requests", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fromDate", SqlDbType.DateTime).Value = monthStartDate;
                cmd.Parameters.Add("@toDate", SqlDbType.DateTime).Value = monthEndDate;
                if (patientId != null)
                {
                    cmd.Parameters.Add("@patientId", SqlDbType.NVarChar).Value = patientId.Value;
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtCabRequests = dataset.Tables[0];

                foreach (DataRow row in dtCabRequests.Rows)
                {
                    currMonthData.Add(new CabRequestDataItem
                    {
                        TotalRequests = Convert.ToInt32(row["TotalRequests"]),
                        Date = Convert.ToDateTime(row["CreatedOn"])
                    });
                }
            }

            if (currMonthData != null)
            {
                currWeekData = currMonthData.FindAll(a => a.Date >= weekStartDate && a.Date <= weekEndDate);
            }

            response = new CabRequestCurrData();
            response.CurrentWeekData = new CabRequestData { Data = currWeekData, StartDate = weekStartDate, EndDate = weekEndDate };
            response.CurrentMonthData = new CabRequestData { Data = currMonthData, StartDate = monthStartDate, EndDate = monthEndDate };

            return response;
        }

        public ActivityHistoryCurrData GetCurrActivityHistory(int? patientId)
        {
            List<ActivityHistoryItem> currMonthData = new List<ActivityHistoryItem>();
            List<ActivityHistoryItem> currWeekData = null;
            DataSet dataset = new DataSet();
            DataTable dtActHistory;
            DateTime monthStartDate, monthEndDate, weekStartDate, weekEndDate, currDate;
            ActivityHistoryCurrData response = null;

            currDate = DateTime.Now;

            weekStartDate = currDate.AddDays(-(int)currDate.DayOfWeek).Date;
            weekEndDate = weekStartDate.AddDays(7).AddSeconds(-1);
            monthStartDate = new DateTime(currDate.Year, currDate.Month, 1);
            monthEndDate = monthStartDate.AddMonths(1).AddDays(-1);

            monthEndDate = (currDate.Day <= monthEndDate.Day) ? currDate : monthEndDate;
            weekEndDate = (currDate.Day <= weekEndDate.Day) ? currDate : weekEndDate;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_activity_history", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fromDate", SqlDbType.DateTime).Value = monthStartDate;
                cmd.Parameters.Add("@toDate", SqlDbType.DateTime).Value = monthEndDate;
                if (patientId != null)
                {
                    cmd.Parameters.Add("@patientId", SqlDbType.NVarChar).Value = patientId.Value;
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtActHistory = dataset.Tables[0];

                foreach (DataRow row in dtActHistory.Rows)
                {
                    currMonthData.Add(new ActivityHistoryItem
                    {
                        TotalOpens = Convert.ToInt32(row["TotalOpen"]),
                        TotalSent = Convert.ToInt32(row["TotalSent"]),
                        Date = Convert.ToDateTime(row["CreatedOn"])
                    });
                }
            }

            if (currMonthData != null)
            {
                currWeekData = currMonthData.FindAll(a => a.Date >= weekStartDate && a.Date <= weekEndDate);
            }

            response = new ActivityHistoryCurrData();
            response.CurrentWeekData = new ActivityHistoryData { Data = currWeekData, StartDate = weekStartDate, EndDate = weekEndDate };
            response.CurrentMonthData = new ActivityHistoryData { Data = currMonthData, StartDate = monthStartDate, EndDate = monthEndDate };

            return response;
        }

        public List<LocationHistoryItem> GetCurrLocationHistory(int? patientId)
        {
            List<LocationHistoryItem> locationHistory = new List<LocationHistoryItem>();
            DataSet dataset = new DataSet();
            DataTable dtLocHistory;
            
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_location_history", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (patientId != null)
                {
                    cmd.Parameters.Add("@patientId", SqlDbType.NVarChar).Value = patientId.Value;
                }
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtLocHistory = dataset.Tables[0];

                foreach (DataRow row in dtLocHistory.Rows)
                {
                    locationHistory.Add(new LocationHistoryItem
                    {
                        TotalOpens = Convert.ToInt32(row["TotalOpen"]),
                        TotalSent = Convert.ToInt32(row["TotalSent"]),
                        LocationType = Convert.ToString(row["LocationType"])
                    });
                }
            }

            return locationHistory;
        }
    }
}
