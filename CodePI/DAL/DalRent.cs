using System;
using System.Text;
using EL;
using static EL.CstmEx;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DalRent
    {
        /// <summary>
        /// Renvoie les détails d'une réservation.
        /// d'après son ID
        /// Todo : éventuellement différencier employé / cstmr ou "common"
        /// </summary>
        /// <param name="id"></param>
        /// <returns>id,vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, PickupDate, ReturnDate, Paid, Employee_Id, IsClosed</returns>
        public static DataTable GetRentById(int id)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@Id", id);

                try
                {
                    using (SqlCommand command = new SqlCommand("SchEmployee.GetReservationById", connection))
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
        /// Renvoie les réservations d'un client.
        /// Todo : éventuellement différencier employé / cstmr
        /// </summary>
        /// <param name="cstmrId"></param>
        /// <returns>id,vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, PickupDate, ReturnDate, Paid, Employee_Id, IsClosed</returns>
        public static DataTable GetRentsByCstmr(int cstmrId, bool isClosed)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@Id", cstmrId);
                SqlParameter param2 = new SqlParameter("@isClosed", cstmrId);

                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetReservationByCstmr", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        command.Parameters.Add(param2);
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
        /// Crée une réservation (Rent).
        /// différentie le schéma utilisé si un n° d'employé à été renseigné ou non.
        /// Un client ne peut pas non plus changer le montant de 0 pour "paid".
        /// </summary>
        /// <param name="vehicle_Id"></param>
        /// <param name="customer_Id"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="toPay"></param>
        /// <param name="paid"></param>
        /// <param name="employeeID"></param>
        /// <returns></returns>
        public static int CreateRent(int vehicle_Id, int customer_Id, DateTime startDate, DateTime endDate, decimal toPay, decimal paid = 0, int employeeID = 0)
        {
            int _newId = 0;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param0 = new SqlParameter("@new_ID", SqlDbType.Int, 0); // 0 en output par défaut.
                param0.Direction = System.Data.ParameterDirection.Output;
                SqlParameter param1 = new SqlParameter("@Vehicle_Id", vehicle_Id);
                SqlParameter param2 = new SqlParameter("@Customer_Id", customer_Id);
                SqlParameter param3 = new SqlParameter("@StartDate", startDate);
                SqlParameter param4 = new SqlParameter("@EndDate", endDate);
                SqlParameter param5 = new SqlParameter("@ToPay", toPay);
                SqlParameter param6 = new SqlParameter("@Paid", paid);
                SqlParameter param7 = new SqlParameter("@Employee_Id", paid);
                SqlParameter[] parameters = { param0, param1, param2, param3, param4, param5 };
                string cmdText = "\"SchCustomer.AddReservation\"";

                if (employeeID != 0)
                {
                    parameters = new SqlParameter[] { param1, param2, param3, param4, param5, param6, param7 };
                    cmdText = "\"SchEmployee.AddReservation\"";
                }
                try
                {
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("ExecuteNonQuery");
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected == 0) throw new CstmEx(ExType.dtaWrite);
                        if (rowsAffected > 1) throw new CstmEx(ExType.sqlLineCount);
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
        /// Met à jour / Clôture une réservation.
        /// Seul un employé peut le faire
        /// </summary>
        /// <param name="id"></param>
        /// <param name="vehicle_Id"></param>
        /// <param name="customer_Id"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="toPay"></param>
        /// <param name="isClosed"></param>
        /// <param name="paid"></param>
        public static void UpdateRent(int id, int vehicle_Id, int customer_Id, DateTime startDate, DateTime endDate, decimal toPay, bool isClosed, decimal paid)
        {
            int _newId = 0;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param0 = new SqlParameter("@id", id);
                SqlParameter param1 = new SqlParameter("@Vehicle_Id", vehicle_Id);
                SqlParameter param2 = new SqlParameter("@Customer_Id", customer_Id);
                SqlParameter param3 = new SqlParameter("@StartDate", startDate);
                SqlParameter param4 = new SqlParameter("@EndDate", endDate);
                SqlParameter param5 = new SqlParameter("@ToPay", toPay);
                SqlParameter param6 = new SqlParameter("@isClosed", isClosed);
                SqlParameter param7 = new SqlParameter("@Paid", paid);
                SqlParameter[] parameters = { param0, param1, param2, param3, param4, param5, param6, param7 };
                try
                {
                    using (SqlCommand command = new SqlCommand(cmdText: "SchEmployee.UpdateReservation", connection: connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("ExecuteNonQuery");
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected == 0) throw new CstmEx(ExType.dtaUpdate);
                        if (rowsAffected > 1) throw new CstmEx(ExType.sqlLineCount);
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
                    throw new CstmEx(ExType.dtaUpdate, ex);
                }
                #endregion Catch
            }
        }
    }
}

