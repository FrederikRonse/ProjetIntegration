using System;
using System.Text;
using EL;
using static EL.CstmEx;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DalOffice
    {
        /// <summary>
        /// Retourne un employé par son id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static DataTable GetEmployee(int id)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@Id", id);
              
                try
                {
                    using (SqlCommand command = new SqlCommand("@SchEmployee.GetEmployeeById", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        _sLog.Append("Open");
                        connection.Open();
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        _dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", _sLog);

                    switch (sqlEx.Number)
                    {
                        case 4060:
                            throw new CstmEx(ExType.badDB, sqlEx); //"Mauvaise base de données"
                        case 18456:
                            throw new CstmEx(ExType.badPWD, sqlEx); //"Mauvais mot de passe"

                        default:
                            throw new CstmEx(ExType.notHandledSql, sqlEx); //"Erreur SQL non traitée !" L'exception sera rError_Layerancée.
                    }
                }
                catch (Exception ex)
                {
                    ex.Data.Add("Log", _sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return _dataToReturn;
        }


        /// <summary>
        /// Retourne la liste des agences / emplacements.
        /// </summary>
        /// <returns>string Name</returns>
        public static DataTable GetOfficeList()
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetOfficeList", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        _sLog.Append("Open");
                        connection.Open();
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        _dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", _sLog);

                    switch (sqlEx.Number)
                    {
                        case 4060:
                            throw new CstmEx(ExType.badDB, sqlEx); //"Mauvaise base de données"
                        case 18456:
                            throw new CstmEx(ExType.badPWD, sqlEx); //"Mauvais mot de passe"

                        default:
                            throw new CstmEx(ExType.notHandledSql, sqlEx); //"Erreur SQL non traitée !" L'exception sera rError_Layerancée.
                    }
                }
                catch (Exception ex)
                {
                    ex.Data.Add("Log", _sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return _dataToReturn;
        }
    }
}

