using System;
using System.Text;
using EL;
using static EL.CstmEx;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DalCustomer
    {
        /// <summary>
        /// Retourne les détails de contact d'un client.
        /// </summary>
        /// <param name="id"></param>
        /// <returns>[Name],[Surname],BirthDate,Email</returns>
        public static DataTable GetCstmrById(string id)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@Id", id);

                try
                {
                    using (SqlCommand command = new SqlCommand("@SchEmployee.GetCustomerDetails", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        _sLog.Append("Open");
                        connection.Open();
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

        public static DataTable GetCstmrDetails(string cstmrUserName)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@UserName", cstmrUserName);

                try
                {
                    using (SqlCommand command = new SqlCommand("@SchEmployee.GetCustomerByuserName", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        _sLog.Append("Open");
                        connection.Open();
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
        /// Crée un nouveau client.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="surName"></param>
        /// <param name="birthDay"></param>
        /// <param name="email"></param>
        /// <param name="phone"></param>
        /// <returns></returns>
        public static int CreateCstmr(string name, string surName, DateTime birthDay, string email, string phone)
        {
            int _newId = 0;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param0 = new SqlParameter("@new_ID", SqlDbType.Int, 0); // 0 en output par défaut.
                param0.Direction = System.Data.ParameterDirection.Output;
                SqlParameter param1 = new SqlParameter("@name", name);
                SqlParameter param2 = new SqlParameter("@surName", surName);
                SqlParameter param3 = new SqlParameter("@birthDate", birthDay);
                SqlParameter param4 = new SqlParameter("@email", email);
                SqlParameter param5 = new SqlParameter("@phone", phone);
                SqlParameter[] parameters = { param1, param2, param3, param4, param5 };
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.AddCustomer", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("ExecuteNonQuery");
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected == 0) throw new CstmEx(ExType.dtaWrite);      // La création a échoué.
                        if (rowsAffected > 1) throw new CstmEx(ExType.sqlLineCount);  // nbre de lignes affectées erroné.
                        _newId = (int)command.Parameters["@new_ID"].Value;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", _sLog);

                    switch (sqlEx.Number)
                    {
                        case 4060:
                            throw new CstmEx(ExType.badDB, sqlEx); 
                        case 18456:
                            throw new CstmEx(ExType.badPWD, sqlEx); 

                        default:
                            throw new CstmEx(ExType.notHandledSql, sqlEx);
                    }
                }
                catch (Exception ex)
                {
                    ex.Data.Add("Log", _sLog);
                    throw new CstmEx(ExType.dtaWrite, ex);
                }
                #endregion Catch
            }
            return _newId;
        }


        /// <summary>
        /// mise à jour d'un client.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        /// <param name="surName"></param>
        /// <param name="birthDay"></param>
        /// <param name="email"></param>
        /// <param name="phone"></param>
        public static void UpdteCstmr(string id, string name, string surName, DateTime birthDay, string email, string phone) //, DateTime LastModified
        {
            //string _updatedCstmrName = "";
            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param0 = new SqlParameter("@id", id);
                SqlParameter param1 = new SqlParameter("@name", name);
                SqlParameter param2 = new SqlParameter("@surName", surName);
                SqlParameter param3 = new SqlParameter("@birthDate", birthDay);
                SqlParameter param4 = new SqlParameter("@email", email);
                SqlParameter param5 = new SqlParameter("@phone", phone);
                SqlParameter[] parameters = { param0, param1, param2, param3, param4, param5 };
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.UpdateCustomer", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("ExecuteNonQuery");
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected == 0) throw new CstmEx(ExType.dtaUpdate); //  La modification n'a pas pu être effectuée ! \n Veuillez réessayer.
                        if (rowsAffected > 1) throw new CstmEx(ExType.sqlLineCount);  // nbre de lignes affectées erroné
                        //_updatedCstmrName = command.Parameters["@userName"].ToString();
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
                    throw new CstmEx(ExType.dtaUpdate, ex); //"La modification n'a pas pu être effectuée !"
                }
                #endregion Catch
                //return _updatedCstmrName;
            }
        }
    }
}

