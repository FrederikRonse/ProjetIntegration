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
            return View(GetVehiclesByFilter());
        }

        /// <summary>
        /// Retourne les véhicules correspondants aux paramètres
        /// contenus dans TempData["vehiclefilter"].
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult GetVehiclesByFilter()
        {
            List<VMvehicle> _vMvehicles = new List<VMvehicle>();

            BO.SlctdFilters _slctdFilter = TempData["vehiclefilter"] as BO.SlctdFilters;
            List<BO.VehicleDetails> _result = BL.BLVehicle.GetVehicleByFilter(_slctdFilter);

            if (_result.Count != 0)
            {
                foreach (BO.VehicleDetails item in _result)
                {
                    VMvehicle _vMvehicle = new VMvehicle();
                 //   _vMvehicle.Id = item.VehicleId;
                    _vMvehicle.MakeName = item.VehicleType.MakeName;
                    _vMvehicle.ModelName = item.VehicleType.ModelName;
                    _vMvehicle.PicPath = item.Pictures[0].Path;
                    _vMvehicle.PicLabel = item.Pictures[0].Label;
                    _vMvehicle.DailyPrice = (int)item.DailyPrice;
                    _vMvehicle.Ndays = ((byte)(_slctdFilter.EndDate - _slctdFilter.StartDate).Days) > 0 ?
                                        (byte)(_slctdFilter.EndDate - _slctdFilter.StartDate).Days : (byte)1 ; // un jour minimum.
                    _vMvehicle.PromoTotal = GetTotalPromo();
                    _vMvehicle.PriceToPay = _vMvehicle.DailyPrice * _vMvehicle.Ndays - _vMvehicle.PromoTotal >= 0 ?
                                            _vMvehicle.DailyPrice * _vMvehicle.Ndays - _vMvehicle.PromoTotal : 0; // Pas de prix négatif (0= gratuit).
                    _vMvehicle.CCName = item.VehicleType.CCName;
                    _vMvehicle.DoorsCount = item.VehicleType.DoorsCount;
                    _vMvehicle.FuelName = item.VehicleType.FuelName;


                    _vMvehicles.Add(_vMvehicle);

                    //calcul du total des promos pour chaque véhicule.
                    int GetTotalPromo()
                    {
                        int _promoTotal = 0;
                        List<BO.Promo> _promos = BL.BLPromo.GetPromosForVehicleType(item.VehicleType.Id, item.OfficeName);
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

                }
            }
            return View("VehicleSelection", _vMvehicles);
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
