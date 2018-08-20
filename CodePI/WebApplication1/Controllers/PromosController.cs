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
            BO.SlctdFilters _slctdFilters = new BO.SlctdFilters();

            //Récupération des options et sauvegarde en session.
            VMvehicleFilters _filters = (VMvehicleFilters)(Session["filters"]) ?? BLweb.BLweb.SetDefaultFilters(officeName);
            if (_filters.LstOffices.SelectedValue == null) _filters = BLweb.BLweb.SetDefaultFilters(officeName);
            Session["filters"] = _filters;
            ViewBag.selectList = _filters.LstOffices; //pour dropdown.
                                                      // Récup des véhicules à afficher.
            _slctdFilters.OfficeName = _filters.LstOffices.SelectedValue.ToString();
            TempData["slctdFilters"] = _slctdFilters; // pour passage à GetVehiclesByFilter()
            return View("Fleet", GetPromosByOffice( ));
        }

        [HttpGet]
        public List<BO.Promo> GetPromosByOffice()
        {
            List<VMPromo> _vMvehicles = new List<VMvehicle>();
            BO.SlctdFilters _slctdFilter = TempData["slctdFilters"] as BO.SlctdFilters;

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

        // GET: Promos/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }


    }
}
