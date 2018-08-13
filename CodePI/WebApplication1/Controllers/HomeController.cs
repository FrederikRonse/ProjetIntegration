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
        VMvehicleFilters _filters;

        public ActionResult Index()
        {
            if (_filters == null)
            {
                SetFilters();
            }
            return View(_filters);
        }

        /// <summary>
        /// Mets à jour la liste des filtres.
        /// Appelle la fonction d'update si nécessaire.
        /// </summary>
        public void SetFilters(BO.FilterOptions selectedOptions = null)
        {
            _filters = new VMvehicleFilters();

            if (Session["filters"] == null)
            {
                BL.BLVehicle _bLVehicle = new BL.BLVehicle();
                _filterOptions = _bLVehicle.GetFilterOptions(); // = new SelectList(_officeList, "Name", "Name", _officeList[0].Name);
                if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");


                _filters.LstOffices = new SelectList(_filterOptions.lstOffices);
                _filters.LstMakes = new SelectList(_filterOptions.lstMakes);
                _filters.LstFuels = new SelectList(_filterOptions.lstFuels);
                _filters.LstDoors = new SelectList(_filterOptions.lstDoors);

                Session["filters"] = _filters;
            }
            else _filters = Session["filters"] as VMvehicleFilters;
            if (selectedOptions != null) UpdateFilters(selectedOptions);
        }

        /// <summary>
        /// Mets à jour les filtres pour dropdowns selection dans Session["filters"].
        /// Les objets "slctdXXXX" en session ne sont pas utilisés pour le moment.
        /// </summary>
        /// <param name="selectedOptions"></param>
        public void UpdateFilters(BO.FilterOptions selectedOptions)
        {
            if (selectedOptions.lstOffices != null)
            {
                Session["slctdOffice"] = selectedOptions.lstOffices[0];
                SelectList UpdatedLstOffices = new SelectList(((VMvehicleFilters)Session["filters"]).LstOffices, selectedOptions.lstOffices[0]);
                ((VMvehicleFilters)Session["filters"]).LstOffices = UpdatedLstOffices;
                _filters.LstOffices = UpdatedLstOffices;
            }
            if (selectedOptions.lstMakes != null)
            {
                Session["slctdMake"] = selectedOptions.lstMakes[0];
                SelectList UpdatedlstMakes = new SelectList(((VMvehicleFilters)Session["filters"]).LstMakes, selectedOptions.lstMakes[0]);
                ((VMvehicleFilters)Session["filters"]).LstMakes = UpdatedlstMakes;
                _filters.LstMakes = UpdatedlstMakes;
            }
            if (selectedOptions.lstFuels != null)
            {
                Session["slctdFuel"] = selectedOptions.lstFuels[0];
                SelectList UpdatedlstFuels = new SelectList(((VMvehicleFilters)Session["filters"]).LstFuels, selectedOptions.lstFuels[0]);
                ((VMvehicleFilters)Session["filters"]).LstFuels = UpdatedlstFuels;
                _filters.LstFuels = UpdatedlstFuels;
            }
            if (selectedOptions.lstDoors != null)
            {
                Session["slctdDoors"] = selectedOptions.lstDoors[0];
                SelectList UpdatedlstDoors = new SelectList(((VMvehicleFilters)Session["filters"]).LstDoors, selectedOptions.lstDoors[0]);
                ((VMvehicleFilters)Session["filters"]).LstDoors = UpdatedlstDoors;
                _filters.LstDoors = UpdatedlstDoors;
            }
        }

        /// <summary>
        /// Rafraîchi la liste d'options en session et 
        /// passe la main au VehicleController pour la 
        /// récupération et affichage des véhicules.
        /// </summary>
        /// <param name="filterOptions"></param>
        [HttpGet]
        public void SetVehicles(BO.FilterOptions filterOptions)
        {
            SetFilters(filterOptions);
            RedirectToAction("GetVehicles", "Vehicle", new { filterOptions });
        }

    }
}