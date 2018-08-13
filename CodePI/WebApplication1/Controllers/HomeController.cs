using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.View_Models;


namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        BO.FilterOptions _filterOptions;
        VMvehicleFilters filters;

        public ActionResult Index()
        {
            if (filters == null)
            {
                SetFilters();
            }
            return View(filters);
        }

        /// <summary>
        /// Mets à jour la liste des filtres.
        /// </summary>
        public void SetFilters()
        {
            BL.BLVehicle _bLVehicle = new BL.BLVehicle();
            _filterOptions = _bLVehicle.GetFilterOptions(); // = new SelectList(_officeList, "Name", "Name", _officeList[0].Name);
            if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");

            filters = new VMvehicleFilters();
            filters.LstOffices = new SelectList(_filterOptions.lstOffices);
            filters.LstMakes = new SelectList(_filterOptions.lstMakes);
            filters.LstFuels = new SelectList(_filterOptions.lstFuels);
            filters.LstDoors = new SelectList(_filterOptions.lstDoors);

            Session["filters"] = filters;
        }
    }
}