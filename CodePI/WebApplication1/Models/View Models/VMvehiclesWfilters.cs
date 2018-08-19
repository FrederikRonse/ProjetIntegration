using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;


namespace WebApplication1.Models.View_Models
{
    /// <summary>
    /// ! DailyPrice en int
    /// </summary>
    public class VMvehiclesWfilters
    {
        public List<VMvehicle> VMvehicles { get; set; }

        public VMvehicleFilters Filters { get; set; }
    }
}