using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        BO.FilterOptions _filterOptions;

        public ActionResult Index()
        {
            if (_filterOptions == null)
            {
                SetFilters();
            }
            return View(_filterOptions);
        }

        /// <summary>
        /// Mets à jour la liste des filtres.
        /// </summary>
        public void SetFilters()
        {
            BL.BLVehicle _bLVehicle = new BL.BLVehicle();
            _filterOptions = _bLVehicle.GetFilterOptions(); // = new SelectList(_officeList, "Name", "Name", _officeList[0].Name);
            if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");

        }
    }
}