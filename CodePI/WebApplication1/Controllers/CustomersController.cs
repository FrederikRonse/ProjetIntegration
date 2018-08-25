using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models.View_Models;
using WebApplication1.BLweb;
using EL;
using static EL.CstmEx;

namespace WebApplication1.Controllers
{
    public class CustomersController : Controller
    {
        /// <summary>
        /// Retourne les détails d'un client.
        /// </summary>
        /// <param name="cstmrId"></param>
        /// <returns></returns>
        // GET: Customer
        //public ActionResult CustomerDetails(string cstmrId)
        //{

        //    VMCustomer _customer = new VMCustomer();
        //    if (cstmrId == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    _customer = BLweb.BLweb.GetCstmrById(cstmrId);
        //    if (_customer == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(_customer);
        //}

        // GET: Customer
        public ActionResult CustomerDetails()
        {
            string _currentUser = User.Identity.Name;
            VMCustomer _customer = new VMCustomer();
            if (_currentUser == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            _customer = BLweb.BLweb.GetCstmrDetails(_currentUser);
            if (_customer == null)
            {
                return HttpNotFound();
            }
            return View(_customer);
        }

        [HttpPost]
        public ActionResult CustomerDetails(VMCustomer cstmrUpdate)
        {
            if (ModelState.IsValid)
            {
                BLweb.BLweb.UpdteCstmrDetails(cstmrUpdate);
                //ViewBag.Confirmation = _cstmrName;

                return View();
            }
            return RedirectToAction("Index", "Home");
        }

        /// <summary>
        /// Retourne les locations d'un client.
        /// </summary>
        /// <param name="cstmrId"></param>
        /// <param name="isCLosed"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult CustomerRents(int cstmrId, bool isCLosed = false)
        {
            List<VMRent> _vMrents = new List<VMRent>();

            List<BO.Rent> _rents = BL.BLRent.GetRentByCstmr(cstmrId, isCLosed);
            if (_rents.Count != 0)
            {
                foreach (BO.Rent item in _rents)
                {
                    VMRent _vmRent = new VMRent() { VehicleTypeId = item.VehicleTypeId, CstmrId = item.CstmrId, EmployeeId = item.EmployeeId, ReservationDate = item.ReservationDate, StartDate = item.StartDate, EndDate = item.EndDate, ToPay = item.ToPay, Paid = item.Paid };
                    _vMrents.Add(_vmRent);
                }
                return View(_vMrents);
            }
            return RedirectToAction("Index", "Home");
        }
    }
}