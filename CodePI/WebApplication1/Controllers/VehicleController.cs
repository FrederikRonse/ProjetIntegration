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
    public class VehicleController : Controller
    {
        // GET: Vehicle
        public ActionResult Index()
        {
            if (string.IsNullOrEmpty(Session["slctdOffice"].ToString()) == false)
            {
                BL.BLVehicle.Vehiclefilter _vehiclefilter = new BL.BLVehicle.Vehiclefilter();
                _vehiclefilter.OfficeName = Session["slctdOffice"].ToString();
            }

            return View();
        }

        // GET: Vehicle
        [HttpGet]
        public ActionResult GetVehiclesByFilter(BL.BLVehicle.Vehiclefilter slctdFilter = null, bool withPics = true)
        {
          //  if (slctdFilter == null)
            return View(BL.BLVehicle.GetVehicleByFilter(slctdFilter, withPics));

        }
    }

}
