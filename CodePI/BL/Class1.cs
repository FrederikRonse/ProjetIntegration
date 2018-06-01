using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using BO;
using EL;
using static EL.CstmEx;

namespace BL
{
    public class Class1
    {

        public Office testc()
        {
            BO.Office office = new BO.Office();
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
                            office = tempOffice;
                        }
                    }
                }
                return office;
            }
            catch (CstmEx cstmEx)
            {
                throw new CstmEx(ExType.dtaRead, cstmEx); 

            }
            catch (Exception ex)
            {
                throw new CstmEx(ExType.srvrError, ex);
            }
        }
    }
}
