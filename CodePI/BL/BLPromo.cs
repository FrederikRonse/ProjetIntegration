using System;
using System.Data;
using System.Collections.Generic;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public class BLPromo
    {
        
        public Rent Getxxx(int id)
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

        public List<Rent> GetxxByxx(int cstmrId, bool isClosed)
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

    }
}
