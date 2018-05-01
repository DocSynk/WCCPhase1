using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WccDashboard.Services
{
    public interface ISecurityService
    {
        string Encrypt(string clearText);
        string Decrypt(string cipherText);
    }
}