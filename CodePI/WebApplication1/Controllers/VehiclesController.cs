using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.View_Models;
using EL;
using static EL.CstmEx;


namespace WebApplication1.Controllers
{
    public class VehiclesController : BaseController
    {

        /// <summary>
        /// Affiche la flotte de l'agence en session
        /// ou l'ensemble de la flotte (AirCar).
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Fleet(string officeName)
        {
            BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();

            //Récupération des options et sauvegarde en session.
            VMvehicleFilters _filters = (VMvehicleFilters)(Session["filters"]) ?? BLweb.BLweb.SetDefaultFilters(officeName);
            if (_filters.LstOffices.SelectedValue == null) _filters = BLweb.BLweb.SetDefaultFilters(officeName);
            Session["filters"] = _filters;
            ViewBag.selectList = _filters.LstOffices; //pour dropdown.
                                                      // Récup des véhicules à afficher.
            _vehiclefilter.OfficeName = _filters.LstOffices.SelectedValue.ToString();
            TempData["vehiclefilter"] = _vehiclefilter; // pour passage à GetVehiclesByFilter()
            return View("Fleet", GetVehiclesByFilter());
        }

        /// <summary>
        /// Affiche les véhicules corespondants aux critères choisis.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetSelection()
        {
            return View("VehicleSelection", GetVehiclesByFilter());
        }

        /// <summary>
        /// Retourne les véhicules corespondants aux paramètres
        /// contenus dans TempData["vehiclefilter"].
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public List<VMvehicle> GetVehiclesByFilter()
        {
            List<VMvehicle> _vMvehicles = new List<VMvehicle>();
            BO.SlctdFilters _slctdFilter = TempData["vehiclefilter"] as BO.SlctdFilters;

            List<BO.VehicleDetails> _result = BL.BLVehicle.GetVehicleByFilter(_slctdFilter);
            if (_result.Count != 0)
            {
                foreach (BO.VehicleDetails item in _result)
                {
                    _vMvehicles.Add(ToVMvehicle(item, _slctdFilter.StartDate, _slctdFilter.StartDate));
                }
            }
            return _vMvehicles;
        }

        /// <summary>
        /// Va chercher un véhicule en BDD.
        /// </summary>
        /// <param name="typeId"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetVehicleDetails(int? typeId, DateTime startDate, DateTime endDate)
        {
            VMvehicle _vMvehicle = new VMvehicle();
            if (typeId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BO.VehicleDetails _vehicleToConvert = BL.BLVehicle.GetVehicleTypeById((int)typeId);
            if (_vehicleToConvert == null)
            {
                return HttpNotFound();
            }
            _vMvehicle = ToVMvehicle(_vehicleToConvert, startDate, endDate);
            //if (Session["pics"]!=null)
            List<string> _pics = Session["pics"] != null ? (List<string>)Session["pics"] : new List<string>();
            if (_pics.Count > 5) _pics.RemoveAt(0);
            _pics.Add(_vMvehicle.PicPath);
            Session["pics"] = _pics;
            return View("VehicleDetails",_vMvehicle);
        }

        /// <summary>
        /// Convertit un VehicleDetails vers un VMvehicle.
        /// </summary>
        /// <param name="vehicleDetails"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public VMvehicle ToVMvehicle(BO.VehicleDetails vehicleDetails, DateTime startDate, DateTime endDate)
        {
            VMvehicle _vMvehicle = new VMvehicle();
            _vMvehicle.TypeId = vehicleDetails.VehicleType.Id;
            _vMvehicle.MakeName = vehicleDetails.VehicleType.MakeName;
            _vMvehicle.ModelName = vehicleDetails.VehicleType.ModelName;
            _vMvehicle.PicPath = vehicleDetails.Pictures[0].Path;
            _vMvehicle.PicLabel = vehicleDetails.Pictures[0].Label;
            _vMvehicle.DailyPrice = (int)vehicleDetails.DailyPrice;
            _vMvehicle.StartDate = startDate;
            _vMvehicle.EndDate = endDate;
            // _vMvehicle.NDays assigné par .EndDate au niveau du modèle.
            _vMvehicle.PromoTotal = GetTotalPromo();
            _vMvehicle.PriceToPay = _vMvehicle.DailyPrice * _vMvehicle.Ndays - _vMvehicle.PromoTotal >= 0 ?
                                    _vMvehicle.DailyPrice * _vMvehicle.Ndays - _vMvehicle.PromoTotal : 0; // Pas de prix négatif (0= gratuit).
            _vMvehicle.CCName = vehicleDetails.VehicleType.CCName;
            _vMvehicle.DoorsCount = vehicleDetails.VehicleType.DoorsCount;
            _vMvehicle.FuelName = vehicleDetails.VehicleType.FuelName;

            //calcul du total des promos pour chaque véhicule.
            int GetTotalPromo()
            {
                int _promoTotal = 0;
                List<BO.Promo> _promos = BL.BLPromo.GetPromosForVehicleType(vehicleDetails.VehicleType.Id, vehicleDetails.OfficeName);
                if (_promos.Count != 0)
                {
                    byte _totalPercentReduc = 0;
                    int _totalCashReduc = 0;
                    foreach (BO.Promo promo in _promos)
                    {
                        byte _currentPcReduc = _totalPercentReduc;
                        if (promo.PercentReduc != null) _currentPcReduc += (byte)promo.PercentReduc;
                        if (_currentPcReduc < 100) _totalPercentReduc = _currentPcReduc; // max 100% de réduction.
                        if (promo.FixedReduc != null) _totalCashReduc += (int)promo.FixedReduc;
                    }
                    _promoTotal = (_vMvehicle.DailyPrice * _vMvehicle.Ndays) * _totalPercentReduc / 100 + _totalCashReduc;
                }
                return _promoTotal;
            }
            return _vMvehicle;
        }

        [HttpGet]
        public ActionResult Rent( )
        {
           return RedirectToAction("Fleet");
            //throw new NotImplementedException();
        }

        [HttpPost]
        public ActionResult Rent(VMvehicle vMvehicle)
        {
            if (ModelState.IsValid)
            {//TODO _rent.CstmrId  & _employeeId
                int _cstmrId = new int();
                int _employeeId= new int();
                decimal _paid = 0;
                
                BO.Rent _rent = new BO.Rent() {VehicleTypeId=vMvehicle.TypeId, CstmrId= _cstmrId, EmployeeId= _employeeId, ReservationDate = DateTime.Now, StartDate =vMvehicle.StartDate, EndDate=vMvehicle.EndDate, ToPay=vMvehicle.PriceToPay, Paid= _paid };

                int _carNumber=BL.BLRent.CreateRent(_rent);

                VMRent _vmRent = new VMRent() {CarNumber= _carNumber, VehicleTypeId = _rent.VehicleTypeId, CstmrId = _rent.CstmrId, EmployeeId = _rent.EmployeeId, ReservationDate = _rent.ReservationDate, StartDate = _rent.StartDate, EndDate = _rent.EndDate, ToPay = _rent.ToPay, Paid = _rent.Paid };

                return View(_vmRent);    //rentConfirmation
            }
            return RedirectToAction("Index", "Home");
        }


        /// PAS UTILISE : Problème pour sérialiser etpasser une instance VMvehicle apd la vue.
        /// <summary>
        /// Affiche les détails d'un véhicule
        /// (de la liste déjà constituée).
        /// </summary>
        /// <param name="vMvehicle"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult VehicleDetails(VMvehicle vehicleToDisplay)
        {

            return View((VMvehicle)vehicleToDisplay);
        }
    }

}
