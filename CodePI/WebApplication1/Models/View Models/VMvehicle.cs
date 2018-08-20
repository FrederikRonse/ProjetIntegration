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
    /// StartDate et EndDate doivent être renseignées pour 
    /// avoir le N de jours (set mis en privé).
    /// </summary>
    public class VMvehicle
    {
        private DateTime _endDate;

        [Key]
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int TypeId { get; set; }
        [Display(Name = "MakeName", ResourceType = typeof(Resource))]
        public string MakeName { get; set; }

        [Display(Name = "ModelName", ResourceType = typeof(Resource))]
        public string ModelName { get; set; }

        [Display(Name = "DailyPrice", ResourceType = typeof(Resource))]
        [DataType(DataType.Currency)]
        public int DailyPrice { get; set; }

        [Display(Name = "StartDate", ResourceType = typeof(Resource))]
        public DateTime StartDate { get; set; }

        [Display(Name = "EndDate", ResourceType = typeof(Resource))]
        public DateTime EndDate
        {
            get { return this._endDate; }
            set
            {
                this._endDate = ((value - StartDate).Days) > 0 ?
                _endDate = value : StartDate.AddDays(1);

                this.Ndays = ((byte)(EndDate - StartDate).Days) > 0 ?
                (byte)(EndDate - StartDate).Days : (byte)1;
            } // un jour minimum. 
        }
        [Display(Name = "Ndays", ResourceType = typeof(Resource))]
        [Range(1, 31)]
        public byte Ndays { get; set; }

        [Display(Name = "PromoTotal", ResourceType = typeof(Resource))]
        [DataType(DataType.Currency)]
        public int PromoTotal { get; set; }

        [Display(Name = "PriceToPay", ResourceType = typeof(Resource))]
        [DataType(DataType.Currency)]
        public int PriceToPay { get; set; }

        [Display(Name = "DoorsCount", ResourceType = typeof(Resource))]
        public byte DoorsCount { get; set; }

        [Display(Name = "FuelName", ResourceType = typeof(Resource))]
        public string FuelName { get; set; }

        [Display(Name = "CCName", ResourceType = typeof(Resource))]
        public string CCName { get; set; }

        [ScaffoldColumn(false)]
        public string PicPath { get; set; }

        [ScaffoldColumn(false)]
        public string PicLabel { get; set; }
    }
}