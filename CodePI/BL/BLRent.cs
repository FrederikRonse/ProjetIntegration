using System;
using System.Data;
using System.Collections.Generic;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public static class BLRent
    {
        /// <summary>
        /// Retourne une réservation par son ID.
        /// Pour Employés uniquement.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Rent GetRent(int id)
        {
            Rent _rent = new Rent();
            try
            {
                DataTable _table = DalRent.GetRentById(id);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        DataRowView row = _table.DefaultView[0];
                        Rent temp = new Rent();
                        temp.Id = (int)row["Id"];
                        temp.VehicleTypeId = (int)row["Vehicle_Id"];
                        temp.CstmrId = (int)row["Customer_Id"];
                        temp.ReservationDate = (DateTime)row["ReservationDate"];
                        temp.StartDate = (DateTime)row["StartDate"];
                        temp.EndDate = (DateTime)row["EndDate"];
                        temp.ToPay = (decimal)row["ToPay"];
                        temp.Paid = (decimal)row["Paid"];
                        temp.IsClosed = (bool)row["IsClosed"];

                        if (row["PickupDate"] != DBNull.Value && row["ReturnDate"] != DBNull.Value)
                        {
                            temp.PickupDate = (DateTime)row["PickupDate"];
                            temp.ReturnDate = (DateTime)row["ReturnDate"];
                        }
                        if (row["Employee_Id"] != DBNull.Value)
                            temp.EmployeeId = (int)row["Employee_Id"];

                        _rent = temp;
                    }
                }
                return _rent;
            }
            #region Catch
            catch (CstmEx cstmEx)
            {
                throw new CstmEx(ExType.dtaRead, cstmEx);
            }
            catch (Exception ex)
            {
                throw new CstmEx(ExType.srvrError, ex);
            }
            #endregion Catch
        }

        /// <summary>
        /// retourne les réservations d'un client.
        /// Clôturées ou pas au choix.
        /// </summary>
        /// <param name="cstmrId"></param>
        /// <returns></returns>
        public static List<Rent> GetRentByCstmr(int cstmrId, bool isClosed)
        {
            List<Rent> _rents = new List<Rent>();
            try
            {
                DataTable _table = DalRent.GetRentsByCstmr(cstmrId, isClosed);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
                        {
                            Rent temp = new Rent
                            {
                                Id = (int)row["Id"],
                                VehicleTypeId = (int)row["Vehicle_Id"],
                                CstmrId = (int)row["Customer_Id"],
                                ReservationDate = (DateTime)row["ReservationDate"],
                                StartDate = (DateTime)row["StartDate"],
                                EndDate = (DateTime)row["EndDate"],
                                ToPay = (decimal)row["ToPay"],
                                Paid = (decimal)row["Paid"],
                                IsClosed = (bool)row["IsClosed"]
                            };

                            if (row["PickupDate"] != DBNull.Value && row["ReturnDate"] != DBNull.Value)
                            {
                                temp.PickupDate = (DateTime)row["PickupDate"];
                                temp.ReturnDate = (DateTime)row["ReturnDate"];
                            }
                            if (row["Employee_Id"] != DBNull.Value)
                                temp.EmployeeId = (int)row["Employee_Id"];

                            _rents.Add(temp);
                        }
                    }
                }
                return _rents;
            }
            #region Catch
            catch (CstmEx cstmEx)
            {
                throw new CstmEx(ExType.dtaRead, cstmEx);
            }
            catch (Exception ex)
            {
                throw new CstmEx(ExType.srvrError, ex);
            }
            #endregion Catch
        }

        /// <summary>
        /// Création d'une réservation.
        /// </summary>
        /// <param name="newRent"></param>
        public static int CreateRent(Rent newRent)
        {
            int _carNumber = 0;

            if (newRent == null)
            {
                throw new ArgumentNullException(nameof(newRent));
            }
            try
            {
                _carNumber = DalRent.CreateRent(newRent.VehicleTypeId, newRent.CstmrId, newRent.StartDate, newRent.EndDate, newRent.ToPay, newRent.Paid, (int)newRent.EmployeeId);
            }
            #region Catch
            catch (CstmEx cstmEx)
            {
                throw new CstmEx(ExType.dtaRead, cstmEx);
            }
            catch (Exception ex)
            {
                throw new CstmEx(ExType.srvrError, ex);
            }
            #endregion Catch
            return _carNumber;
        }

        /// <summary>
        /// update / clôture d'une réservation.
        /// </summary>
        /// <param name="rentToUpdate"></param>
        public static void UpdteRent(Rent rentToUpdate)
        {
            if (rentToUpdate == null)
            {
                throw new ArgumentNullException(nameof(Rent));
            }
            try
            {
                DalRent.UpdateRent(id: rentToUpdate.Id, vehicle_Id: rentToUpdate.VehicleTypeId, customer_Id: rentToUpdate.CstmrId, startDate: rentToUpdate.StartDate, endDate: rentToUpdate.EndDate, toPay: rentToUpdate.ToPay, isClosed: rentToUpdate.IsClosed, paid: rentToUpdate.Paid);
            }
            #region Catch
            catch (CstmEx cstmEx)
            {
                throw new CstmEx(ExType.dtaRead, cstmEx);
            }
            catch (Exception ex)
            {
                throw new CstmEx(ExType.srvrError, ex);
            }
            #endregion Catch
        }
    }
}
