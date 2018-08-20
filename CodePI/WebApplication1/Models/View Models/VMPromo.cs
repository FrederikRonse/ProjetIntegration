using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models.View_Models
{
    public class VMPromo
    {
        [Key]
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int PromotionModel_Id { get; set; }
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int VehicleType_Id { get; set; }
        [Display(Name = "Office_Name", ResourceType = typeof(Resource))]
        public string Office_Name { get; set; }
        [Display(Name = "PromoName", ResourceType = typeof(Resource))]
        public string Name { get; set; }
        [Display(Name = "StartDate", ResourceType = typeof(Resource))]
        public DateTime StartDate { get; set; }
        [Display(Name = "EndDate", ResourceType = typeof(Resource))]
        public DateTime EndDate { get; set; }
        [Display(Name = "PercentReduc", ResourceType = typeof(Resource))]
        public byte? PercentReduc { get; set; }
        [Display(Name = "FixedReduc", ResourceType = typeof(Resource))]
        public decimal? FixedReduc { get; set; }
    }
}