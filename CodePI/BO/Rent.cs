using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BO
{
    public class Rent
    {
        public int Id { get; set; }
        public int VehicleTypeId { get; set; }
        public int CstmrId { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public decimal ToPay { get; set; }
        public DateTime? PickupDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public decimal Paid { get; set; }
        public int? EmployeeId { get; set; }
        public bool IsClosed { get; set; }
    }
}
