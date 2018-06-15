using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BO
{
    public class Promo
    {
        public int PromotionModel_Id { get; set; }
        public int VehicleType_Id { get; set; }
        public string Office_Name { get; set; }
        public string Name { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public byte? PercentReduc { get; set; }
        public int? FixedReduc { get; set; }
    }
}
