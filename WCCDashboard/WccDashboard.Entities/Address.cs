using System;

namespace WccDashboard.Entities
{
    public class Address
    {
        public int AddressId { get; set; }
        public int AccountId { get; set; }
        public string AddressType { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
    }
}
