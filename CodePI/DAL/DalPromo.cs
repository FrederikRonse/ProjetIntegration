using System;
using System.Text;
using EL;
using static EL.CstmEx;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DalPromo
    {
        /// <summary>
        /// Retourne les modèles de promos par agences.
        /// (les promotions globales sont celles du siège (AirCar Belgium).
        /// Pour clients et employés.
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns> PromotionModel_Id, VehicleType_Id,[Name],Office_Name,[StartDate],[EndDate],[PercentReduc],[FixedReduc</returns>
        public static DataTable GetPromoByOffice(string officeName)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@officeName", officeName);

                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetPromoModels", connection))
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
        /// Récupération des promos liées à un type véhicule.
        /// pour clients et employés.
        /// </summary>
        /// <param name="vehicleTypeId"></param>
        /// <returns>ALL =  PromotionModel_Id, VehicleType_Id,[Name],Office_Name,[StartDate],[EndDate],[PercentReduc],[FixedReduc</returns>
        public static DataTable GetPromoByVehicle(int vehicleTypeId, string officeName)
        {
            DataTable _dataToReturn = null;

            using (SqlConnection connection = UtilsDAL.GetConnection())
            {
                StringBuilder _sLog = new StringBuilder();
                SqlParameter param1 = new SqlParameter("@vehicleTypeId", vehicleTypeId);
                SqlParameter param2 = new SqlParameter("@officeName", officeName);

                try
                {
                    using (SqlCommand command = new SqlCommand("SchCommon.GetPromoByVehicle", connection))
                    {
                        DataTable dataTemp = new DataTable();
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(param1);
                        command.Parameters.Add(param2);
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
    }
}

