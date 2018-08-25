using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using WebApplication1.Models.View_Models;
using EL;
using static EL.CstmEx;

namespace WebApplication1.BLweb
{
    public class BLweb
    {/// <summary>
     /// Créé les listes de sélection et assure qu'une agence
     /// soit sélectionnée.
     /// </summary>
     /// <param name="officeName"></param>
     /// <returns></returns>
        public static VMvehicleFilters SetDefaultFilters(string officeName)
        {
            VMvehicleFilters _filters = new VMvehicleFilters();

            //Récupération des options.

            {// Génère les listes des options de filtre en session.
                BO.FilterOptions _filterOptions = BL.BLVehicle.GetFilterOptions();
                if (_filterOptions.lstOffices.Contains("AirCar Belgium")) _filterOptions.lstOffices.Remove("AirCar Belgium");
                _filters.LstOffices = new SelectList(_filterOptions.lstOffices);
                _filters.LstMakes = new SelectList(_filterOptions.lstMakes);
                _filters.LstFuels = new SelectList(_filterOptions.lstFuels);
                _filters.LstDoors = new SelectList(_filterOptions.lstDoors);
            }
            // Selection de l'agence (office) à utiliser.
            //Si pas de paramètres fournis, agence par défaut.
            SelectList _selectList = _filters.LstOffices;
            string _slctdOffice;
            _slctdOffice = (string.IsNullOrEmpty(officeName) != true) ? officeName :
                                  (_selectList.SelectedValue != null) ? _selectList.SelectedValue.ToString() :  // Si une agence a déjà été sélectionnée (via Session["slctdOffice").
                                                                         _selectList.ElementAt(0).Text;  // sinon (en cas de session expirée) 
            SelectList _updatedList = new SelectList(_filters.LstOffices.Items, _slctdOffice); // _filters.LstOffices.FirstOrDefault(x => x.Text == _slctdOffice).Text);
            _filters.LstOffices = _updatedList;
            return _filters;
        }


        /// <summary>
        /// retourne les détails d'un client.
        /// </summary>
        /// <param name="cstmrId"></param>
        /// <returns></returns>
        public static VMCustomer GetCstmrById(string cstmrId)
        {
            VMCustomer _customer = new VMCustomer();
            _customer = null;
            if (cstmrId != null)
            {
                BO.Customer _cstmrToConvert = BL.BLCustomer.GetCustomer(cstmrId);
                if (_cstmrToConvert != null)
                    _customer = ToVMCustomer(_cstmrToConvert);
            }
            return _customer;
        }

        public static VMCustomer GetCstmrDetails(string cstmrUserName)
        {
            VMCustomer _customer = new VMCustomer();
            _customer = null;
            if (cstmrUserName != null)
            {
                BO.Customer _cstmrToConvert = BL.BLCustomer.GetCustomer(cstmrUserName);
                if (_cstmrToConvert != null)
                    _customer = ToVMCustomer(_cstmrToConvert);
            }
            return _customer;
        }

        /// <summary>
        /// Mets à jour les détails d'un client et retourne son nom si réussi.
        /// </summary>
        /// <param name="cstmrUpdate"></param>
        /// <returns></returns>
        public static void UpdteCstmrDetails(VMCustomer cstmrUpdate)
        {
            //string _UpdatedUserName = "";
            if (cstmrUpdate != null)
            {
             BO.Customer  _customer = ToBoCustomer(cstmrUpdate);
                BL.BLCustomer.UpdteCstmr(_customer);
            }
            //return _UpdatedUserName;
        }


        public static VMCustomer ToVMCustomer(BO.Customer cstmrToConvert)
        {
            VMCustomer _customer = new VMCustomer();
            if (cstmrToConvert != null)
            {
                _customer.Cstmr_Id = cstmrToConvert.Pers_Id;
                _customer.UserFirstName = cstmrToConvert.Surname;
                _customer.UserLastName = cstmrToConvert.Name;
                _customer.UserBDay = cstmrToConvert.BirthDate;
                _customer.Email = cstmrToConvert.Email;
                _customer.UserPhone = cstmrToConvert.Phone;
            }
            return _customer;
        }

        public static BO.Customer ToBoCustomer(VMCustomer cstmrToConvert)
        {
            BO.Customer _customer = new BO.Customer();
            if (cstmrToConvert != null)
            {
                _customer.Pers_Id = cstmrToConvert.Cstmr_Id;
                _customer.Surname = cstmrToConvert.UserFirstName;
                _customer.Name = cstmrToConvert.UserLastName;
                _customer.BirthDate = cstmrToConvert.UserBDay;
                _customer.Email = cstmrToConvert.Email;
                _customer.Phone = cstmrToConvert.UserPhone;
            }
            return _customer;
        }


    }
}