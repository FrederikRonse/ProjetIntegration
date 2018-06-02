
using System;
using System.Text;
using EL;
using static EL.CstmEx;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DalVehicle
    {
        /// <summary>
        /// table pour GetVehicleByFilter déplacée dans BO (et référence BO ajoutée à DAL).
        /// </summary>
        //public class VehicleFilters
        //{
        //    protected DateTime _startDate;
        //    protected DateTime _endDate;
        //    protected string _officeName;
        //    protected string _makeName;
        //    protected string _fuelName;
        //    protected byte _doorsCount;
        //    // Propriétés.
        //    public DateTime StartDate { get => _startDate; set => _startDate = value; }
        //    public DateTime EndDate { get => _endDate; set => _endDate = value; }
        //    public string OfficeName { get => _officeName; set => _officeName = value; }
        //    public string MakeName { get => _makeName; set => _makeName = value; }
        //    public string FuelName { get => _fuelName; set => _fuelName = value; }
        //    public byte DoorsCount { get => _doorsCount; set => _doorsCount = value; }
        //}

        /// <summary>
        /// retourne un véhicule par son ID.
        /// </summary>
        /// <param name="vehicle_Id"></param>
        /// <returns></returns>
        public static DataTable GetVehicleById(int vehicle_Id)
        {
            DataTable dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@id", vehicle_Id);
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetVehicleById", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        sLog.Append("Open");
                        connection.Open();
                        datadapt.SelectCommand = command;
                        sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", sLog);

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
                    ex.Data.Add("Log", sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return dataToReturn;
        }

        /// <summary>
        /// Récupère les images d'un type de véhicule.
        /// </summary>
        /// <param name="vehicleType_Id"></param>
        /// <returns></returns>
        public static DataTable GetPics(int vehicleType_Id)
        {
            DataTable dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@VehicleType_Id", vehicleType_Id);
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetPictures", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        sLog.Append("Open");
                        connection.Open();
                        datadapt.SelectCommand = command;
                        sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", sLog);

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
                    ex.Data.Add("Log", sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return dataToReturn;
        }

        /// <summary>
        /// retourne une instance de chaque types de véhicules
        /// correspondant aux filtres.
        /// </summary>
        /// <param name="vFilters"></param>
        /// <returns></returns>
        public static DataTable GetVehiclesByFilter(BO.Vehiclefilter vFilters)
        {
            DataTable dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@startDate", vFilters.StartDate);
                SqlParameter param2 = new SqlParameter("@endtDate", vFilters.EndDate);
                SqlParameter param3 = new SqlParameter("@officeName", vFilters.OfficeName);
                SqlParameter param4 = new SqlParameter("@makeName", vFilters.MakeName);
                SqlParameter param5 = new SqlParameter("@fuelName", vFilters.FuelName);
                SqlParameter param6 = new SqlParameter("@doorsCount", vFilters.DoorsCount);
                SqlParameter[] parameters = { param1, param2, param3, param4, param5, param6 };
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetVehiclesByFilter", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        sLog.Append("Open");
                        connection.Open();
                        datadapt.SelectCommand = command;
                        sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", sLog);

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
                    ex.Data.Add("Log", sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return dataToReturn;
        }

        /// <summary>
        /// Ajoute un véhicule.
        /// retourne l'ID du nouveau véhicule.
        /// </summary>
        /// <param name="vehicleType_Id"></param>
        /// <param name="basetarif_Id"></param>
        /// <returns></returns>
        public static int AddVehicle(int vehicleType_Id, int basetarif_Id)
        {
            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder sLog = new StringBuilder();
                SqlParameter param0 = new SqlParameter("@new_ID", SqlDbType.Int, 0); // 0 en output par défaut.
                param0.Direction = System.Data.ParameterDirection.Output;
                SqlParameter param1 = new SqlParameter("@vehicleType_Id", vehicleType_Id);
                SqlParameter param2 = new SqlParameter("@basetarif_Id", basetarif_Id);
                SqlParameter[] parameters = { param0, param1, param2 };
                try
                {
                    using (SqlCommand command = new SqlCommand("SchEmployee.AddVehicle", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddRange(parameters);
                        sLog.Append("Open");
                        connection.Open();
                        sLog.Append("ExecuteNonQuery");
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected == 0) throw new CstmEx(ExType.dtaWrite);     // La création a échoué. 
                        if (rowsAffected > 1) throw new CstmEx(ExType.sqlLineCount);  // nbre de lignes affectées erroné.
                        int newId = (int)command.Parameters["@new_ID"].Value;
                        return newId;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", sLog);

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
                    ex.Data.Add("Log", sLog);
                    throw new CstmEx(ExType.dtaWrite, ex);
                }
                #endregion Catch
            }
        }



        /// <summary>
        /// enumération pour GetVehicleByFilter. / pas utilisé
        /// </summary>
        public enum EnumVehicleFilters
        {
            startDate,
            endDate,
            officeName,
            makeName,
            fuelName,
            doorsCount,
        }

    }
}

