using System;
using System.Data;
using System.Collections.Generic;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public static class BLPromo
    {
        /// <summary>
        /// Renvoie les promos d'une agence.
        /// Les promos globales sont celles du siège (Aircar Belgium).
        /// </summary>
        /// <param name="officeName"></param>
        /// <returns></returns>
        public static List<Promo> GetPromosByOffice(string officeName)
        {
            List<Promo> _promos = new List<Promo>();
            try
            {
                DataTable _table = DalPromo.GetPromoByOffice(officeName);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
                        {
                            Promo temp = new Promo();
                            temp.PromotionModel_Id = (int)row["PromotionModel_Id"];
                            temp.VehicleType_Id = (int)row["VehicleType_Id"];
                            temp.Name = row["Name"].ToString();
                            temp.Office_Name = row["Office_Name"].ToString();
                            temp.StartDate = (DateTime)row["StartDate"];
                            temp.EndDate = (DateTime)row["EndDate"];

                            if (row["PercentReduc"] != DBNull.Value) temp.PercentReduc = (byte)row["PercentReduc"];
                            if (row["FixedReduc"] != DBNull.Value) temp.FixedReduc = (int)row["FixedReduc"];

                            _promos.Add(temp);
                        }
                    }
                }
                return _promos;
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
        /// Retourne les promos dont bénéficie un type de véhicule.
        /// </summary>
        /// <param name="vehicleId"></param>
        /// <returns></returns>
        public static List<Promo> GetPromosForVehicleType(int vehicleTypeId, string officeName)
        {
            List<Promo> _promos = new List<Promo>();
            try
            {
                DataTable _table = DalPromo.GetPromoByVehicle(vehicleTypeId, officeName);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
                        {
                            Promo temp = new Promo();
                            temp.PromotionModel_Id = (int)row["PromotionModel_Id"];
                            temp.VehicleType_Id = (int)row["VehicleType_Id"];
                            temp.Name = row["Name"].ToString();
                            temp.Office_Name = row["Office_Name"].ToString();
                            temp.StartDate = (DateTime)row["StartDate"];
                            temp.EndDate = (DateTime)row["EndDate"];

                            if (row["PercentReduc"] != DBNull.Value) temp.PercentReduc = (byte)row["PercentReduc"];
                            if (row["FixedReduc"] != DBNull.Value) temp.FixedReduc = (decimal)row["FixedReduc"];

                            _promos.Add(temp);
                        }
                    }
                }
                return _promos;
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
