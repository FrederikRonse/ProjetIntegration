using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication1.Models.ViewModels
{
    public class FilterLists
    {
        public SelectList lstOffices { get; set; }
        public SelectList lstMakes { get; set; }
        public SelectList lstCC { get; set; }
        public SelectList lstFuels { get; set; }
        public SelectList lstDoors { get; set; }
    }
}