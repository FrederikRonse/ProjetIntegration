using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BO
{
    public class Office
    {
        public string Name { get; set; }
    }

    public class Employee
    {
        public int PersId { get; set; }
        public string OfficeName { get; set; }
    }
}
