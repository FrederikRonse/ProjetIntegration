using System;
using System.Data;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public static class BLCustomer
    {
        /// <summary>
        /// Renvoie les détails d'un client par son ID.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Customer GetCustomerById(string id)
        {
            Customer _customer = new Customer();
            try
            {
                DataTable _table = DalCustomer.GetCstmrDetails(id);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        DataRowView row = _table.DefaultView[0];
                        Customer temp = new Customer
                        {
                            Pers_Id = row["Id"].ToString(),
                            UserName = row["UserName"].ToString(),
                            Name = row["FirstName"].ToString(),
                            Surname = row["Lastname"].ToString(),
                            BirthDate = DateTime.Parse(row["Birthday"].ToString()),
                            Email = row["Email"].ToString(),
                            Phone = row["Phone"].ToString()
                        };

                        _customer = temp;
                    }
                }
                return _customer;
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

        public static Customer GetCustomer(string cstmrUserName)
        {
            Customer _customer = new Customer();
            try
            {
                DataTable _table = DalCustomer.GetCstmrDetails(cstmrUserName);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        DataRowView row = _table.DefaultView[0];
                        Customer temp = new Customer
                        {
                            Pers_Id = row["Id"].ToString(),
                            UserName = row["UserName"].ToString(),
                            Name = row["FirstName"].ToString(),
                            Surname = row["Lastname"].ToString(),
                            BirthDate = DateTime.Parse(row["Birthday"].ToString()),
                            Email = row["Email"].ToString(),
                            Phone = row["Phone"].ToString()
                        };

                        _customer = temp;
                    }
                }
                return _customer;
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
        /// Création d'un client.
        /// </summary>
        /// <param name="newCstmr"></param>
        public static void CreateCstmr(Customer newCstmr)
        {
            if (newCstmr == null)
            {
                throw new ArgumentNullException(nameof(newCstmr));
            }
            try
            {
                DalCustomer.CreateCstmr(newCstmr.Name, newCstmr.Surname, newCstmr.BirthDate, newCstmr.Email, newCstmr.Phone);
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
        /// Mise à jour d'un client.
        /// </summary>
        /// <param name="Cstmr"></param>
        public static void UpdteCstmr(Customer Cstmr)
        {
            //string _UpdatedUserName = "";
            if (Cstmr == null)
            {
                throw new ArgumentNullException(nameof(Cstmr));
            }
            try
            {
                DAL.DalCustomer.UpdteCstmr(Cstmr.Pers_Id, Cstmr.Name, Cstmr.Surname, Cstmr.BirthDate, Cstmr.Email, Cstmr.Phone);
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
            // return _UpdatedUserName;
        }
    }
}
