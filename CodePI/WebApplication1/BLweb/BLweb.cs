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
    }
}