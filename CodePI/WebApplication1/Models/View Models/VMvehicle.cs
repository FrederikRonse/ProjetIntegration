﻿using System;
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
    public class VMvehicle
    {
        [Key]
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int Id { get; set; }
        [Display(Name = "Make")]
        public string MakeName { get; set; }
        [Display(Name = "Model")]
        public string ModelName { get; set; }
        [Display(Name = "Daily Price")]
        public int DailyPrice { get; set; }
        [Display(Name = "Duration")]
        public byte Ndays { get; set; }
        [Display(Name = "Reduction")]
        public int PromoTotal { get; set; }
        [Display(Name = "Price")]
        public int PriceToPay { get; set; }
        [Display(Name = "Number of Doors")]
        public byte DoorsCount { get; set; }
        [Display(Name = "Type of Fuel")]
        public string FuelName { get; set; }
        [Display(Name = "Engine")]
        public string CCName { get; set; }
        [ScaffoldColumn(false)]
        public string PicPath { get; set; }
        [ScaffoldColumn(false)]
        public string PicLabel { get; set; }
    }
}