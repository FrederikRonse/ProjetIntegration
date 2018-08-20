using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models.View_Models
{
    public class VMRent
    {
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int CarNumber { get; set; }

        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int VehicleTypeId { get; set; }

        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int CstmrId { get; set; }

        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int? EmployeeId { get; set; }

        [Display(Name = "Office_Name", ResourceType = typeof(Resource))]
        public string Office_Name { get; set; }

        [Display(Name = "PromoName", ResourceType = typeof(Resource))]
        public string Name { get; set; }

        [Display(Name = "ReservationDate", ResourceType = typeof(Resource))]
        public DateTime ReservationDate { get; set; }

        [Display(Name = "StartDate", ResourceType = typeof(Resource))]
        public DateTime StartDate { get; set; }

        [Display(Name = "EndDate", ResourceType = typeof(Resource))]
        public DateTime EndDate { get; set; }

        [Display(Name = "PriceToPay", ResourceType = typeof(Resource))]
        [DataType(DataType.Currency)]
        public decimal ToPay { get; set; }

        [Display(Name = "PickupDate", ResourceType = typeof(Resource))]
        public DateTime? PickupDate { get; set; }

        [Display(Name = "ReturnDate", ResourceType = typeof(Resource))]
        public DateTime? ReturnDate { get; set; }

        [Display(Name = "Paid", ResourceType = typeof(Resource))]
        [DataType(DataType.Currency)]
        public decimal Paid { get; set; }

        [Display(Name = "IsClosed", ResourceType = typeof(Resource))]
        public bool IsClosed { get; set; }

    }
}