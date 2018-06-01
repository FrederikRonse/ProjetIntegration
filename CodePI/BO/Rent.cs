using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BO
{
    class Rent
    {
        public int Id { get; set; }
        public int VehicleId { get; set; }
        public int CstmrId { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Paid { get; set; }
        public int EmployeeId { get; set; }
    }
}
