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
    public class VMvehicle
    {
        [Key]
        [ScaffoldColumn(false)]
        [Range(0, int.MaxValue)]
        public int Id { get; set; }
        public string MakeName { get; set; }
        public string ModelName { get; set; }
        public int DailyPrice { get; set; }
        public byte Ndays { get; set; }
        public int Promo { get; set; }
        public byte DoorsCount { get; set; }
        public string FuelName { get; set; }
        public string CCName { get; set; }
        public string PicPath { get; set; }
        public string PicLabel { get; set; }
    }
}