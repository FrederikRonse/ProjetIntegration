using System;
using System.Collections.Generic;
using System.Data;
using BO;
using EL;
using static EL.CstmEx;

namespace BL
{
    public class BLOffice
    {

        /// <summary>
        /// Retourne la liste de toutes les agences / emplacements.
        /// </summary>
        /// <returns></returns>
        public List<Office> GetOffices()
        {
            List<Office> _officeList = new List<Office>();
            try
            {
                DataTable table = DAL.DalOffice.GetOfficeList();
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in table.DefaultView)
                        {
                            Office tempOffice = new Office();
                            tempOffice.Name = row["Name"].ToString();
                            _officeList.Add(tempOffice);
                        }
                    }
                }
                return _officeList;
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
