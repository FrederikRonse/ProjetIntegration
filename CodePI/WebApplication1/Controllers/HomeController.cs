using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Helpers;
using WebApplication1.Models.View_Models;


namespace WebApplication1.Controllers
{
   // [Authorize]
    public class HomeController : BaseController
    {
        BO.FilterOptions _filterOptions;
       

        public ActionResult SetCulture(string culture)
        {             // Validate input
            culture = CultureHelper.GetImplementedCulture(culture);
            // Save culture in a cookie   
            HttpCookie cookie = Request.Cookies["_culture"];
            if (cookie != null)
                cookie.Value = culture;
            // update cookie value      
            else
            {
                cookie = new HttpCookie("_culture");
                cookie.Value = culture;
                cookie.Expires = DateTime.Now.AddYears(1);
            }
            Response.Cookies.Add(cookie); 

            return Redirect(Request.UrlReferrer.AbsoluteUri);
        }

        /// <summary>
        /// Retourne la vue principale,
        /// filtre de sélection des véhicules et
        /// carousel.
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            if (Session["filters"] == null)
            {
                SetFilterOptions();
            }
            List<string> _pics = new List<string>() { @" ~\Content\Images\Beetle.png", @" ~\Content\Images\Mustang.png", @" ~\Content\Images\Passat.png" };
            Session["pics"] = _pics;
            return View(Session["filters"] as VMvehicleFilters);

        }

        /// <summary>
        /// Mets à jour la liste des filtres.
        /// Appelle la fonction d'update si nécessaire.
        /// </summary>
        public void SetFilterOptions(BO.FilterOptions selectedOptions = null)
        {
            VMvehicleFilters _filters = new VMvehicleFilters();

            if (Session["filters"] == null)
            {
                _filterOptions = BL.BLVehicle.GetFilterOptions();
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
        /// <param name="filterOptions"></param>
        public BO.SlctdFilters UpdateFilterOptions(BO.FilterOptions filterOptions)
        {
            VMvehicleFilters _session = (VMvehicleFilters)Session["filters"];
            BO.SlctdFilters _slctdfilters = new BO.SlctdFilters();

            if (filterOptions.lstOffices != null && filterOptions.lstOffices[0] != "")
            {
               // Session["slctdOffice"] = filterOptions.lstOffices[0];     Pas utilisé pour éviter possible confusion/oubli.
                SelectList UpdatedLstOffices = new SelectList(_session.LstOffices.Items, filterOptions.lstOffices[0]);
                ((VMvehicleFilters)Session["filters"]).LstOffices = UpdatedLstOffices;
                _slctdfilters.OfficeName = filterOptions.lstOffices[0];
            }
            else if (_session.LstOffices.SelectedValue != null) _slctdfilters.OfficeName = _session.LstOffices.SelectedValue.ToString();

            if (filterOptions.lstMakes != null && filterOptions.lstMakes[0] != "")
            {
                SelectList UpdatedlstMakes = new SelectList(_session.LstMakes.Items, filterOptions.lstMakes[0]);
                ((VMvehicleFilters)Session["filters"]).LstMakes = UpdatedlstMakes;
                _slctdfilters.MakeName = filterOptions.lstMakes[0];
            }
            else if (_session.LstMakes.SelectedValue != null) _slctdfilters.MakeName = _session.LstMakes.SelectedValue.ToString();

            if (filterOptions.lstFuels != null && filterOptions.lstFuels[0] != "")
            {
                SelectList UpdatedlstFuels = new SelectList(_session.LstFuels.Items, filterOptions.lstFuels[0]);
                ((VMvehicleFilters)Session["filters"]).LstFuels = UpdatedlstFuels;
                _slctdfilters.FuelName = filterOptions.lstFuels[0];
            }
            else if (_session.LstFuels.SelectedValue != null) _slctdfilters.FuelName = _session.LstFuels.SelectedValue.ToString();
            
            if (filterOptions.lstDoors != null && filterOptions.lstDoors[0] != 0)
            {
                SelectList UpdatedlstDoors = new SelectList(_session.LstDoors.Items, filterOptions.lstDoors[0]);
                ((VMvehicleFilters)Session["filters"]).LstDoors = UpdatedlstDoors;
                _slctdfilters.DoorsCount = filterOptions.lstDoors[0];
            }
            else if (_session.LstDoors.SelectedValue != null) _slctdfilters.DoorsCount = (byte)_session.LstDoors.SelectedValue;

            return _slctdfilters;

        }



        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
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
            TempData["vehiclefilter"] = UpdateFilterOptions(filterOptions); ; // ou (pour non objets) utiliser RouteValueDictionary {{vf = _vehiclefilter},{withPics = true}};
            return RedirectToAction("GetSelection", "Vehicles");
        }

    }
}