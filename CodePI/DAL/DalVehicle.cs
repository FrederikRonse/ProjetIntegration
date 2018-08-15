
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
        /// Classe pour passage des filtres.
        /// </summary>
        public class VehicleFilters
        {
            protected DateTime _startDate;
            protected DateTime _endDate;
            protected string _officeName;
            protected string _makeName;
            protected string _fuelName;
            protected byte _doorsCount;
            // Propriétés.
            public DateTime StartDate { get => _startDate; set => _startDate = value; }
            public DateTime EndDate { get => _endDate; set => _endDate = value; }
            public string OfficeName { get => _officeName; set => _officeName = value; }
            public string MakeName { get => _makeName; set => _makeName = value; }
            public string FuelName { get => _fuelName; set => _fuelName = value; }
            public byte DoorsCount { get => _doorsCount; set => _doorsCount = value; }
        }


        /// <summary>
        /// Retourne les options de filtres possibles pour la sélection d'un véhicule
        /// , pour toute la flotte.
        /// </summary>
        /// <returns></returns>
        public static DataSet GetFilterOptions()
        {
            using (DataSet _dataToReturn = new DataSet("filterData"))

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetOfficeList", connection))
                    {
                        DataTable OfficeList = new DataTable();
                        DataTable MakeList = new DataTable();
                        DataTable CCList = new DataTable();
                        DataTable FuelList = new DataTable();
                        DataTable DoorsList = new DataTable();

                        command.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        
                        //datadapt.TableMappings.Add("Table", "OfficeList");
                        //datadapt.TableMappings.Add("Table1", "MakeList");
                        //datadapt.TableMappings.Add("Table2", "CCList");
                        //datadapt.TableMappings.Add("Table3", "FuelList");
                        //datadapt.TableMappings.Add("Table4", "DoorsList");

                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("Fill");
                        datadapt.Fill(OfficeList);
                        _dataToReturn.Tables.Add(OfficeList);

                        command.CommandText = "SchCommon.GetMakeList";
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(MakeList);
                        _dataToReturn.Tables.Add(MakeList);

                        command.CommandText = "SchCommon.GetCCList";
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(CCList);
                        _dataToReturn.Tables.Add(CCList);

                        command.CommandText = "SchCommon.GetFuelList";
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(FuelList);
                        _dataToReturn.Tables.Add(FuelList);

                        command.CommandText = "SchCommon.GetDoorsList";
                        datadapt.SelectCommand = command;
                        _sLog.Append("Fill");
                        datadapt.Fill(DoorsList);
                        _dataToReturn.Tables.Add(DoorsList);


                        _dataToReturn.Tables[0].TableName = "OfficeList";
                        _dataToReturn.Tables[1].TableName = "MakeList";
                        _dataToReturn.Tables[2].TableName =  "CCList";
                        _dataToReturn.Tables[3].TableName =  "FuelList";
                        _dataToReturn.Tables[4].TableName =  "DoorsList";
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
                return _dataToReturn;
            }
        }

        /// <summary>
        /// retourne un véhicule par son ID.
        /// </summary>
        /// <param name="vehicle_Id"></param>
        /// <returns></returns>
        public static DataTable GetVehicleById(int vehicle_Id)
        {
            DataTable __dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder __sLog = new StringBuilder();
                SqlParameter _param1 = new SqlParameter("@id", vehicle_Id);
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetVehicleById", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(_param1);
                        SqlDataAdapter datadapt = new SqlDataAdapter(command);
                        __sLog.Append("Open");
                        connection.Open();
                        __sLog.Append("Fill");
                        datadapt.Fill(dataTemp);
                        __dataToReturn = dataTemp;
                    }
                }
                #region Catch
                catch (SqlException sqlEx)
                {
                    sqlEx.Data.Add("Log", __sLog);

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
                    ex.Data.Add("Log", __sLog);
                    throw new CstmEx(ExType.dtaRead, ex); //"Problème à la récupération des données par la DAL !"
                }
                #endregion Catch
            }
            return __dataToReturn;
        }

        /// <summary>
        /// Récupère les images d'un type de véhicule.
        /// </summary>
        /// <param name="vehicleType_Id"></param>
        /// <returns></returns>
        public static DataTable GetPics(int vehicleType_Id)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@VehicleType_Id", vehicleType_Id);
                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetPictures", connection))
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
        /// retourne une instance de chaque types de véhicules
        /// correspondant aux filtres.
        /// Datetime.now si pas de dates fournies.
        /// </summary>
        /// <param name="vFilters"></param>
        /// <returns></returns>
        public static DataTable GetVehiclesByFilter(VehicleFilters vFilters)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@startDate",  vFilters.StartDate == DateTime.MinValue ?   DateTime.Now : vFilters.StartDate);
                SqlParameter param2 = new SqlParameter("@endtDate", vFilters.EndDate == DateTime.MinValue ? DateTime.Now : vFilters.EndDate);
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
                StringBuilder _sLog = new StringBuilder();
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
                        _sLog.Append("Open");
                        connection.Open();
                        _sLog.Append("ExecuteNonQuery");
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
        }
    
    }
}

