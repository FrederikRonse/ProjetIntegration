using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models.View_Models
{
    public class VMvehicleFilters
    {
        [Required(ErrorMessage = "No Office Selected!")]
        [StringLength(30, ErrorMessage = "Please choose an office.")]
        public SelectList LstOffices { get; set; }
        public SelectList LstMakes { get; set; }
        public SelectList LstFuels { get; set; }
        public SelectList LstDoors { get; set; }
    }
}