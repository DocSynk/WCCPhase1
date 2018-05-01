using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public class UserService:IUserService
    {
        string connString = string.Empty;
        ISecurityService securitySvc;

        public UserService(ISecurityService securityService)
        {
            connString = ConfigurationManager.ConnectionStrings["dbConn"].ConnectionString;
            securitySvc = securityService;
        }

        public User GetUserDetails(string email, string password)
        {
            DataSet dataset = new DataSet();
            DataTable dtUser;
            DataRow row;
            User user = null;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("dashboard_get_user_details", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = securitySvc.Encrypt(password);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                cmd.Connection = conn;
                adapter.Fill(dataset);

                dtUser = dataset.Tables[0];

                if (dtUser != null && dtUser.Rows != null & dtUser.Rows.Count > 0)
                {
                    row = dtUser.Rows[0];
                    user = new User();
                    user.UserId = Convert.ToInt32(row["intDashboardLoginID"]);
                    user.FirstName = Convert.ToString(row["vcFirstName"]);
                    user.LastName = Convert.ToString(row["vcLastName"]);
                    user.Email = Convert.ToString(row["vcEmail"]);
                }
            }

            return user;
        }

        public int Register(User usr)
        {
            DataSet dataset = new DataSet();
          
            int result;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand("dashboard_add_user", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@firstName", SqlDbType.VarChar).Value = usr.FirstName;
                cmd.Parameters.Add("@lastName", SqlDbType.VarChar).Value = usr.LastName;
                cmd.Parameters.Add("@emailId", SqlDbType.VarChar, 50).Value = usr.Email;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = securitySvc.Encrypt(usr.Password);
          
                result = Convert.ToInt32(cmd.ExecuteScalar());
            }

            return result;
        }
    }
}