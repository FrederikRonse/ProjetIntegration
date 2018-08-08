using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            if (Session["lstOffices"] == null)
            {
                BL.BLVehicle _bLVehicle = new BL.BLVehicle();
                BO.FilterOptions _filterOptions = _bLVehicle.GetFilterOptions(); // = new SelectList(_officeList, "Name", "Name", _officeList[0].Name);
                _filterOptions.lstOffices.Remove("AirCar Belgium");
                Session["lstOffices"] = new SelectList(_filterOptions.lstOffices);
                Session["lstMakes"] = new SelectList(_filterOptions.lstMakes);
                Session["lstFuels"] = new SelectList(_filterOptions.lstFuels);
                Session["lstDoors"] = new SelectList(_filterOptions.lstDoors);
            }
            return View();
        }

        public ActionResult About()
        {

            ViewBag.Message = "";

            return View();
        }

        public ActionResult Contact()
        {

            ViewBag.Message = "page \"contact\"";

            return View();
        }
    }
}