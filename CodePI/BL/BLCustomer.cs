using System;
using System.Data;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public class BLCustomer
    {
        /// <summary>
        /// Renvoie les détails d'un client par son ID.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Customer GetCustomer(int id)
        {
            Customer customer = new Customer();
            try
            {
                DataTable table = DalCustomer.GetCstmrDetails(id);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        DataRowView row = table.DefaultView[0];
                        Customer temp = new Customer
                        {
                            Name = row["Name"].ToString(),
                            Surname = row["Surname"].ToString(),
                            BirthDate = DateTime.Parse(row["BirthDate"].ToString()),
                            Email = row["Email"].ToString(),
                            Phone = row["Phone"].ToString()
                        };

                        customer = temp;
                    }
                }
                return customer;
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
        public void CreateCstmr(Customer newCstmr)
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
        public void UpdteCstmr(Customer Cstmr)
        {
            if (Cstmr == null)
            {
                throw new ArgumentNullException(nameof(Cstmr));
            }
            try
            {
                DalCustomer.UpdteCstmr(Cstmr.Pers_Id, Cstmr.Name, Cstmr.Surname, Cstmr.BirthDate, Cstmr.Email, Cstmr.Phone);
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
