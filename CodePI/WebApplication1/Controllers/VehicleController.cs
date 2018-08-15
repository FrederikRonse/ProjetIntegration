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
                BO.SlctdFilters _vehiclefilter = new BO.SlctdFilters();
                _vehiclefilter.OfficeName = Session["slctdOffice"].ToString();
                GetVehiclesByFilter(_vehiclefilter);
            //    return View(BL.BLVehicle.GetVehicleByFilter(_vehiclefilter));
            }
            return View();

        }

        // GET: Vehicle
        [HttpGet]
        public ActionResult GetVehiclesByFilter(BO.SlctdFilters slctdFilter = null, bool withPics = true)
        {
          //  if (slctdFilter == null)
            return View(BL.BLVehicle.GetVehicleByFilter(slctdFilter, withPics));

        }
    }

}
