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
            return View();
        }

        public ActionResult About()
        {
            BL.Class1 class1 = new BL.Class1();
            BO.Office office=class1.testc();
            
            ViewBag.Message = office.Name;

            return View();
        }

        public ActionResult Contact()
        {
            
            ViewBag.Message = "page \"contact\"";

            return View();
        }
    }
}