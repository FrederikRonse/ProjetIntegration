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
    //[Authorize]
    public class PromosController : Controller
    {
        /// <summary>
        /// Affiche les promos de l'agence en session
        /// ou par défaut.
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        // GET: Promos
        public ActionResult Index(string officeName)
        {
            BO.SlctdFilters _slctdFilters = new BO.SlctdFilters();

            //Récupération des options et sauvegarde en session.
            VMvehicleFilters _filters = (VMvehicleFilters)(Session["filters"]) ?? BLweb.BLweb.SetDefaultFilters(officeName);
            if (_filters.LstOffices.SelectedValue == null) _filters = BLweb.BLweb.SetDefaultFilters(officeName);
            if (_filters == null)
            {
                return HttpNotFound();
            }
            Session["filters"] = _filters;
            return View(GetPromosByOffice(_filters.LstOffices.SelectedValue.ToString()));
        }

        /// <summary>
        /// Récupère toutes les promos d'une agence.
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        public List<VMPromo> GetPromosByOffice(string officeName)
        {
            List<VMPromo> _vMPromos = new List<VMPromo>();
            // BO.SlctdFilters _slctdFilter = TempData["officeName"] as BO.SlctdFilters;

            List<BO.Promo> _result = BL.BLPromo.GetPromosByOffice(officeName);
            if (_result.Count != 0)
            {
                foreach (BO.Promo item in _result)
                {
                    _vMPromos.Add(ToVmPromo(item));
                }
            }
            return _vMPromos;
        }

        /// <summary>
        /// Récupère les promos liées à un véhicules.
        /// </summary>
        /// <param name="typeId"></param>
        /// <param name="VehicleType"></param>
        /// <param name="officeName"></param>
        /// <returns></returns>
        public List<VMPromo> GetVehiclePromos(int VehicleType, string officeName)
        {
            List<VMPromo> _vMpromo = new List<VMPromo>();
            List<BO.Promo> _promos = BL.BLPromo.GetPromosForVehicleType(VehicleType, officeName);
            if (_promos.Count != 0)
            {
                foreach (BO.Promo promo in _promos)
                {
                    _vMpromo.Add(ToVmPromo(promo));
                }
            }
            return _vMpromo;
        }

        /// <summary>
        /// Converti un promo vers un VMvehicle.
        /// </summary>
        /// <param name="promo"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public VMPromo ToVmPromo(BO.Promo promo)
        {
            VMPromo _vMPromo = new VMPromo();
            _vMPromo.PromotionModel_Id = promo.PromotionModel_Id;
            _vMPromo.VehicleType_Id = promo.VehicleType_Id;
            _vMPromo.Office_Name = promo.Office_Name;
            _vMPromo.Name = promo.Name;
            _vMPromo.StartDate = promo.StartDate;
            _vMPromo.EndDate = promo.EndDate;
            _vMPromo.PercentReduc = promo.PercentReduc;
            _vMPromo.FixedReduc = promo.FixedReduc;
            return _vMPromo;
        }

        /// <summary>
        /// calcul du total des promos pour un véhicule.
        /// </summary>
        /// <param name="promo"></param>
        /// <param name="vMvehicle"></param>
        /// <returns></returns>
        public decimal GetTotalPromo(VMPromo promo, VMvehicle vMvehicle)
        {
            decimal _promoTotal = 0;
            List<BO.Promo> _promos = BL.BLPromo.GetPromosForVehicleType(promo.VehicleType_Id, promo.Office_Name);
            if (_promos.Count != 0)
            {
                byte _totalPercentReduc = 0;
                int _totalCashReduc = 0;
                foreach (BO.Promo item in _promos)
                {
                    byte _currentPcReduc = _totalPercentReduc;
                    if (item.PercentReduc != null) _currentPcReduc += (byte)item.PercentReduc;
                    if (_currentPcReduc < 100) _totalPercentReduc = _currentPcReduc; // max 100% de réduction.
                    if (item.FixedReduc != null) _totalCashReduc += (int)item.FixedReduc;
                }
                _promoTotal = (vMvehicle.DailyPrice * vMvehicle.Ndays) * _totalPercentReduc / 100 + _totalCashReduc;
            }
            return _promoTotal;
        }

    }
}