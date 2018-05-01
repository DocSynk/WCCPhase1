using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public class PatientService:IPatientService
    {
        private string connString = string.Empty;

        public PatientService()
        {
            connString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;
        }

        public List<Patient> GetPatients()
        {
            List<Patient> result = new List<Patient>();
            DataSet dataset = new DataSet();
            DataTable dtAccounts;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_patients", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtAccounts = dataset.Tables[0];

                foreach (DataRow row in dtAccounts.Rows)
                {
                    result.Add(new Patient
                    {
                        MRN = Convert.ToString(row["vcMRN"]),
                        AccountId = Convert.ToInt32(row["intAccountId"]),
                        PatientId = Convert.ToInt32(row["intPatientID"]),
                        FirstName = row["vcFirstName"].ToString(),
                        LastName = row["vcLastName"].ToString(),
                        //CellPhone = row["vcCellPhone"].ToString(),
                        //DOB = Convert.ToDateTime(row["dtDOB"]),
                        //Gender = row["vcGender"].ToString(),
                        //InsuranceProvider = row["vcInsuranceProvider"].ToString(),
                        //LastLoggedInOn = Convert.ToDateTime(row["dtLastLoggedInOn"])
                    });
                }   
            }

            return result;
        }
    }
}