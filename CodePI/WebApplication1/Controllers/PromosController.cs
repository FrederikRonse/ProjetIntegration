using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using WebApplication1.Models.View_Models;
using EL;
using static EL.CstmEx;

namespace WebApplication1.Controllers
{
    public class PromosController : Controller
    {

        // GET: Promos
        public ActionResult Index(string officeName)
        {
            VMvehicleFilters _filters = new VMvehicleFilters();
            BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();

            //Récupération des options.
            if (Session["filters"] != null) _filters = (VMvehicleFilters)(Session["filters"]);
            else
            {// Génère les listes des options de filtre en session.
                BO.FilterOptions _filterOptions = BL.BLVehicle.GetFilterOptions();
                if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");
                _filters.LstOffices = new SelectList(_filterOptions.lstOffices);
                _filters.LstMakes = new SelectList(_filterOptions.lstMakes);
                _filters.LstFuels = new SelectList(_filterOptions.lstFuels);
                _filters.LstDoors = new SelectList(_filterOptions.lstDoors);
            }
            // Selection de l'agence (office) à utiliser.
            //Si pas de paramètres fournis, flotte de l'agence en session
            //ou de la première agence de la liste.
            SelectList _selectList = _filters.LstOffices;
            string _slctdOffice;
            
            _slctdOffice = (string.IsNullOrEmpty(officeName) != true) ? officeName :
                                  (_selectList.SelectedValue != null) ? _selectList.SelectedValue.ToString() :  // Si une agence a déjà été sélectionnée (via Session["slctdOffice").
                                                                         _selectList.ElementAt(1).Text;  // sinon (en cas de session expirée) 
            _selectList.Select(x => x.Value == _slctdOffice);
            ViewBag.selectList = _selectList;
            // Sauvegarde de l'éventuelle modif d'agence en session.
            _filters.LstOffices = _selectList;
            Session["filters"] = _filters;


            // Récup des véhicules à afficher.
            _vehiclefilter.OfficeName = _slctdOffice;
            TempData["vehiclefilter"] = _vehiclefilter;
            return View("Fleet" );
        }


        [HttpGet]
        //public ActionResult GetVehiclePromos(int? typeId, DateTime startDate, DateTime endDate)
        //{
        //    //VMvehicle _vMvehicle = new VMvehicle();
        //    //if (typeId == null)
        //    //{
        //    //    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    //}
        //    //BO.VehicleDetails _vehicleToConvert = BL.BLVehicle.GetVehicle((int)typeId);
        //    //if (_vehicleToConvert == null)
        //    //{
        //    //    return HttpNotFound();
        //    //}
        //    //_vMvehicle = ToVMvehicle(_vehicleToConvert, startDate, endDate);
        //    //return View("VehicleDetails", _vMvehicle);
        //}


        // GET: Promos/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }


    }
}
