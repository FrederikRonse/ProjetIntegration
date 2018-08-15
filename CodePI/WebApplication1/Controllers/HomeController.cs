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

        /// <summary>
        /// Retourne la vue principale,
        /// filtre de sélection des véhicules et
        /// carousel.
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            if (_filters == null)
            {
                SetFilterOptions();
            }
            return View(_filters);
        }

        /// <summary>
        /// Mets à jour la liste des filtres.
        /// Appelle la fonction d'update si nécessaire.
        /// </summary>
        public void SetFilterOptions(BO.FilterOptions selectedOptions = null)
        {
            _filters = new VMvehicleFilters();

            if (Session["filters"] == null)
            {
                // BL.BLVehicle _bLVehicle = new BL.BLVehicle();
                _filterOptions = BL.BLVehicle.GetFilterOptions(); // = new SelectList(_officeList, "Name", "Name", _officeList[0].Name);
                if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");


                _filters.LstOffices = new SelectList(_filterOptions.lstOffices);
                _filters.LstMakes = new SelectList(_filterOptions.lstMakes);
                _filters.LstFuels = new SelectList(_filterOptions.lstFuels);
                _filters.LstDoors = new SelectList(_filterOptions.lstDoors);

                Session["filters"] = _filters;
            }
            else _filters = Session["filters"] as VMvehicleFilters;
            if (selectedOptions != null) UpdateFilterOptions(selectedOptions);
        }

        /// <summary>
        /// Mets à jour les filtres pour dropdowns selection dans Session["filters"].
        /// </summary>
        /// <param name="selectedOptions"></param>
        public void UpdateFilterOptions(BO.FilterOptions selectedOptions)
        {
            if (selectedOptions.lstOffices != null && selectedOptions.lstOffices[0] != "")
            {
                Session["slctdOffice"] = selectedOptions.lstOffices[0];
                SelectList UpdatedLstOffices = new SelectList(((VMvehicleFilters)Session["filters"]).LstOffices, selectedOptions.lstOffices[0]);
                ((VMvehicleFilters)Session["filters"]).LstOffices = UpdatedLstOffices;
                _filters.LstOffices = UpdatedLstOffices;
            }
            if (selectedOptions.lstMakes != null && selectedOptions.lstMakes[0] != "")
            {
                Session["slctdMake"] = selectedOptions.lstMakes[0];
                SelectList UpdatedlstMakes = new SelectList(((VMvehicleFilters)Session["filters"]).LstMakes, selectedOptions.lstMakes[0]);
                ((VMvehicleFilters)Session["filters"]).LstMakes = UpdatedlstMakes;
                _filters.LstMakes = UpdatedlstMakes;
            }
            if (selectedOptions.lstFuels != null && selectedOptions.lstFuels[0] != "")
            {
                Session["slctdFuel"] = selectedOptions.lstFuels[0];
                SelectList UpdatedlstFuels = new SelectList(((VMvehicleFilters)Session["filters"]).LstFuels, selectedOptions.lstFuels[0]);
                ((VMvehicleFilters)Session["filters"]).LstFuels = UpdatedlstFuels;
                _filters.LstFuels = UpdatedlstFuels;
            }
            if (selectedOptions.lstCC != null && selectedOptions.lstCC[0] != "")
            {
                Session["slctdDoors"] = selectedOptions.lstDoors[0];
                SelectList UpdatedlstDoors = new SelectList(((VMvehicleFilters)Session["filters"]).LstDoors, selectedOptions.lstDoors[0]);
                ((VMvehicleFilters)Session["filters"]).LstDoors = UpdatedlstDoors;
                _filters.LstDoors = UpdatedlstDoors;
            }
        }

        /// <summary>
        /// Récupères les options choisies.
        /// </summary>
        /// <param name="filterOptions"></param>
        /// <returns></returns>
        static public BO.SlctdFilters GetSlctdFilters(BO.FilterOptions filterOptions)
        {
            BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();
            if (filterOptions.lstOffices != null && filterOptions.lstOffices[0] != "")
            {
                _vehiclefilter.OfficeName = filterOptions.lstOffices[0];
            }
            if (filterOptions.lstMakes != null && filterOptions.lstMakes[0] != "")
            {
                _vehiclefilter.MakeName = filterOptions.lstMakes[0];
            }
            if (filterOptions.lstFuels != null && filterOptions.lstFuels[0] != "")
            {
                _vehiclefilter.FuelName = filterOptions.lstFuels[0];
            }
            if (filterOptions.lstDoors != null && filterOptions.lstDoors[0] != 0)
            {
                _vehiclefilter.DoorsCount = filterOptions.lstDoors[0];
            }
            return _vehiclefilter;
        }

        /// <summary>
        /// Rafraîchi la liste d'options en session et 
        /// passe la main au VehicleController pour la 
        /// récupération et affichage des véhicules.
        /// </summary>
        /// <param name="filterOptions"></param>
      //  [HttpGet]
        public ActionResult SetVehicles(BO.FilterOptions filterOptions)
        {
            SetFilterOptions(filterOptions);

            BO.SlctdFilters _vehiclefilter = GetSlctdFilters(filterOptions);
            TempData["vehiclefilter"] = _vehiclefilter; // ou (pour non objets) utiliser RouteValueDictionary {{vf = _vehiclefilter},{withPics = true}};
            return RedirectToAction("GetVehiclesByFilter", "Vehicle"); //  , new { slctdFilter = }
        }

    }
}