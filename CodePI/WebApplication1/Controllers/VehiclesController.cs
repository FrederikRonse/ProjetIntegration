using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.View_Models;
using EL;
using static EL.CstmEx;


namespace WebApplication1.Controllers
{
    public class VehiclesController : Controller
    {
        /// <summary>
        /// Affiche la flotte de l'agence en session
        /// ou de la première agence.
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        public ActionResult Fleet(string officeName = "")
        {
            BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();
            //Si pas de paramètres fournis, flotte de l'agence en session
            //ou de la première agence de la liste.
            // Charger directement la liste des options avec "AirCar Belgium"
            //si ensemble de la flotte souhaité.
            if (string.IsNullOrEmpty(officeName) == true)
            {
                // Si une agence a déjà été sélectionnée.
                if (string.IsNullOrEmpty(Session["slctdOffice"].ToString()) == false)
                {
                    _vehiclefilter.OfficeName = Session["slctdOffice"].ToString();
                }
                else
                // Récupère la liste des options (et retire airCarBelgium).
                {
                    BO.FilterOptions _filterOptions = BL.BLVehicle.GetFilterOptions();
                    if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");
                    _vehiclefilter.OfficeName = (_filterOptions.lstOffices[0]);
                }
            }
            else _vehiclefilter.OfficeName = officeName;
            TempData["vehiclefilter"] = _vehiclefilter;
            return View(GetVehiclesByFilter( ));
        }

        /// <summary>
        /// Retourne les véhicules correspondants aux paramètres
        /// contenus dans TempData["vehiclefilter"].
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetVehiclesByFilter()
        {
            BO.SlctdFilters _slctdFilter = TempData["vehiclefilter"] as BO.SlctdFilters;
            return View(BL.BLVehicle.GetVehicleByFilter(_slctdFilter));
        }

        // GET: Vehicle
        /// <summary>
        /// Retourne les véhicules correspondants aux paramètres fournis.
        /// </summary>
        /// <param name="slctdFilter"></param>
        /// <param name="withPics"></param>
        /// <returns></returns>
        //[HttpGet]
        //public ActionResult GetVehiclesByFilter(BO.SlctdFilters slctdFilter = null, bool withPics = true)
        //{
        //    if (slctdFilter == null)
        //    {
        //        BO.SlctdFilters _slctdFilter = TempData["vehiclefilter"] as BO.SlctdFilters;
        //        return View(BL.BLVehicle.GetVehicleByFilter(_slctdFilter));
        //    }
        //    else return View(BL.BLVehicle.GetVehicleByFilter(slctdFilter, withPics));
        //}
    }

}
