using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.View_Models;


namespace WebApplication1.Controllers
{
    public class VehicleController : Controller
    {
        // GET: Vehicle
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public void FilterVehicles(BO.FilterOptions  filterOptions) 
        {
            if (filterOptions.lstOffices != null)
            {
                Session["slctdOffice"] = filterOptions.lstOffices[0];
                SelectList UpdatedLstOffices = new SelectList(((VMvehicleFilters)Session["filters"]).LstOffices, filterOptions.lstOffices[0]);
                ((VMvehicleFilters)Session["filters"]).LstOffices = UpdatedLstOffices;
            }
            if (filterOptions.lstMakes != null)
            {
                Session["slctdMake"] = filterOptions.lstMakes[0];
                SelectList UpdatedlstMakes = new SelectList(((VMvehicleFilters)Session["filters"]).LstMakes, filterOptions.lstMakes[0]);
                ((VMvehicleFilters)Session["filters"]).LstMakes = UpdatedlstMakes;
            }
            if (filterOptions.lstFuels != null)
            {
                Session["slctdFuel"] = filterOptions.lstFuels[0];
                SelectList UpdatedlstFuels = new SelectList(((VMvehicleFilters)Session["filters"]).LstFuels, filterOptions.lstFuels[0]);
                ((VMvehicleFilters)Session["filters"]).LstFuels = UpdatedlstFuels;
            }
            if (filterOptions.lstDoors != null)
            {
                Session["slctdDoors"] = filterOptions.lstDoors[0];
                SelectList UpdatedlstDoors = new SelectList(((VMvehicleFilters)Session["filters"]).LstDoors, filterOptions.lstDoors[0]);
                ((VMvehicleFilters)Session["filters"]).LstDoors = UpdatedlstDoors;
            }


        }
    }
}