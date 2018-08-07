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
            if (Session["lstAgencies"] == null)
            {
                List<string> _lstAgencies = new List<string>() { "un", "deux", "trois" };

                Session["lstAgencies"] = new SelectList(_lstAgencies);
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