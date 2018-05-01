using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using WccDashboard.Entities;

namespace WccDashboard.Services
{
    public interface IUserService
    {
        User GetUserDetails(string email, string password);

        int Register(User usr);
    }
}