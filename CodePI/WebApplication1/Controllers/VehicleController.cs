using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication1.Controllers
{
    public class VehicleController : Controller
    {
        // GET: Vehicle
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public void FilterVehicles(BO.FilterOptions filterOptions)
        {

            Session["slctdOffice"] = filterOptions.lstOffices[0];
            Session["slctdMake"] = filterOptions.lstMakes[0];
            Session["slctdFuel"] = filterOptions.lstFuels[0];
            Session["slctdDoors"] =filterOptions.lstDoors[0];


        }
    }
}