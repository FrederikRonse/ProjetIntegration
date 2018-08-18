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
        /// ou de l'ensemble de la flotte.
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Fleet(string officeName = "")
        {
            VMvehicleFilters _filters = new VMvehicleFilters();
            BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();
            
            //Récupération des options.
            if (Session["filters"] != null) _filters = (VMvehicleFilters)(Session["filters"]);
            else
            {// Génère la liste des options de filtre en session (toutes).
                BO.FilterOptions _filterOptions = BL.BLVehicle.GetFilterOptions();
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
               (string.IsNullOrEmpty(_selectList.SelectedValue.ToString()) == false) ? _selectList.SelectedValue.ToString() :  // Si une agence a déjà été sélectionnée (via Session["slctdOffice").
                                                                                       _selectList.ElementAt(0).Value.ToString();  // sinon (en cas de session expirée) 0 = toute la flotte (Aircar Bel.)
            _selectList.Select(x => x.Value == _slctdOffice);
            ViewBag["selectList"] = _selectList;
            // Sauvegarde de l'éventuelle modif d'agence en session.
            _filters.LstOffices = _selectList;
            Session["filters"] = _filters;


            // Récup des véhicules à afficher.
            _vehiclefilter.OfficeName = officeName;
            TempData["vehiclefilter"] = _vehiclefilter;
            return View(GetVehiclesByFilter());
        }

        /// <summary>
        /// Affiche les véhicules coréspondants aux critères choisis.
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
                    VMvehicle _vMvehicle = new VMvehicle();
                    //   _vMvehicle.Id = item.VehicleId;
                    _vMvehicle.MakeName = item.VehicleType.MakeName;
                    _vMvehicle.ModelName = item.VehicleType.ModelName;
                    _vMvehicle.PicPath = item.Pictures[0].Path;
                    _vMvehicle.PicLabel = item.Pictures[0].Label;
                    _vMvehicle.DailyPrice = (int)item.DailyPrice;
                    _vMvehicle.Ndays = ((byte)(_slctdFilter.EndDate - _slctdFilter.StartDate).Days) > 0 ?
                                        (byte)(_slctdFilter.EndDate - _slctdFilter.StartDate).Days : (byte)1; // un jour minimum.
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
            return _vMvehicles;
        }

    }

}
