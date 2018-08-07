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
                BL.BLOffice _bLOffice = new BL.BLOffice();
               List<BO.Office> _officeList = _bLOffice.GetOffices();
                Session["lstOffices"] = new SelectList(_officeList, "Name", "Name"); // , _officeList[0].Name


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