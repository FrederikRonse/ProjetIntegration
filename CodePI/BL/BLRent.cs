using System;
using System.Data;
using System.Collections.Generic;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public class BLRent
    {
        /// <summary>
        /// Retourne une réservation par son ID.
        /// Pour Employés uniquement.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Rent GetRent(int id)
        {
            Rent rent = new Rent();
            try
            {
                DataTable table = DalRent.GetRentById(id);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        DataRowView row = table.DefaultView[0];
                        Rent temp = new Rent();
                        temp.Id = (int)row["Id"];
                        temp.VehicleId = (int)row["Vehicle_Id"];
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

                        rent = temp;
                    }
                }
                return rent;
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
        public List<Rent> GetRentByCstmr(int cstmrId, bool isClosed)
        {
            List<Rent> rents = new List<Rent>();
            try
            {
                DataTable table = DalRent.GetRentsByCstmr(cstmrId, isClosed);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in table.DefaultView)
                        {
                            Rent temp = new Rent
                            {
                                Id = (int)row["Id"],
                                VehicleId = (int)row["Vehicle_Id"],
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

                            rents.Add(temp);
                        }
                    }
                }
                return rents;
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
        public void CreateRent(Rent newRent)
        {
            if (newRent == null)
            {
                throw new ArgumentNullException(nameof(newRent));
            }
            try
            {
                
                DalRent.CreateRent(newRent.VehicleId, newRent.CstmrId, newRent.StartDate, newRent.EndDate, newRent.ToPay, newRent.Paid, (int)newRent.EmployeeId);
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
        /// update / clôture d'une réservation.
        /// </summary>
        /// <param name="newRent"></param>
        public void UpdteRent(Rent newRent)
        {
            if (newRent == null)
            {
                throw new ArgumentNullException(nameof(Rent));
            }
            try
            {
                DalRent.UpdateRent(id:newRent.Id, vehicle_Id:newRent.VehicleId, customer_Id: newRent.CstmrId, startDate: newRent.StartDate, endDate:newRent.EndDate, toPay:newRent.ToPay, isClosed:newRent.IsClosed, paid:newRent.Paid);
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
