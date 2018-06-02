using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using BO;
using EL;
using DAL;
using static EL.CstmEx;

namespace BL
{
    public class BLVehicle
    {

        /// <summary>
        /// retourne un véhicle par son ID, sans détails
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public VehicleShort GetVehicleShort(int id)
        {
            VehicleShort vehicleToReturn = new VehicleShort();
            try
            {
                DataTable table = DalVehicle.GetVehicleById(id);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        DataRowView row = table.DefaultView[0];
                        VehicleShort temp = new VehicleShort();
                        temp.Id = (int)row["Id"];
                        temp.TypeId = (int)row["Vehicle_Id"];
                        temp.TarifId = (int)row["Customer_Id"];
                        vehicleToReturn = temp;
                    }
                }
                return vehicleToReturn;
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
        /// Récupération d'un véhicule avec détails.
        /// Photos optionnelles.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="withPics"></param>
        /// <returns></returns>
        public VehicleDetails GetVehicle(int id, bool withPics = true)
        {
            VehicleDetails vehicleToReturn = new VehicleDetails();
            try
            {
                DataTable table = DalVehicle.GetVehicleById(id);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        DataRowView row = table.DefaultView[0];
                        VehicleDetails temp = new VehicleDetails();
                        VehicleType vehicleType = new VehicleType();
                        temp.VehicleId = (int)row["Id"];
                        temp.OfficeName = row["Office_name"].ToString();
                        temp.DailyPrice = (decimal)row["DailyPrice"];
                        // Ajout des caractèristiques "type"
                        vehicleType.Id = (int)row["VehicleType_Id"];
                        vehicleType.MakeName = row["Make_name"].ToString();
                        vehicleType.ModelName = row["Model_Name"].ToString();
                        vehicleType.FuelName = row["Fuel_Name"].ToString();
                        vehicleType.CCName = row["CC_Name"].ToString();
                        vehicleType.DoorsCount = (byte)row["Doors_Count"];
                        temp.VehicleType = vehicleType;
                        // récup des images.
                        if (withPics == true)
                        {
                            List<Picture> pics = Getpics(vehicleType.Id);
                            if (pics != null) temp.Pictures = pics;
                        }
                        vehicleToReturn = temp;
                    }
                }
                return vehicleToReturn;
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
        /// Retourne la liste filtrée des véhicules.
        /// Photos optionnelles.
        /// </summary>
        /// <param name="vehicleFilters"></param>
        /// <param name="withPics"></param>
        /// <returns></returns>
        public List<VehicleDetails> GetVehicleByFilter(Vehiclefilter vehicleFilters, bool withPics = true)
        {
            List<VehicleDetails> vehicleToReturn = new List<VehicleDetails>();
            try
            {
                DataTable table = DalVehicle.GetVehiclesByFilter(vehicleFilters);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in table.DefaultView)
                        {
                            VehicleDetails temp = new VehicleDetails();
                            VehicleType vehicleType = new VehicleType();
                            temp.VehicleId = (int)row["Id"];
                            temp.OfficeName = row["Office_name"].ToString();
                            temp.DailyPrice = (decimal)row["DailyPrice"];
                            // Ajout des caractèristiques "type"
                            vehicleType.Id = (int)row["VehicleType_Id"];
                            vehicleType.MakeName = row["Make_name"].ToString();
                            vehicleType.ModelName = row["Model_Name"].ToString();
                            vehicleType.FuelName = row["Fuel_Name"].ToString();
                            vehicleType.CCName = row["CC_Name"].ToString();
                            vehicleType.DoorsCount = (byte)row["Doors_Count"];
                            temp.VehicleType = vehicleType;
                            // récup des images.
                            if (withPics == true)
                            {
                                List<Picture> pics = Getpics(vehicleType.Id);
                                if (pics != null) temp.Pictures = pics;
                            }
                            vehicleToReturn.Add(temp);
                        }
                    }
                }
                return vehicleToReturn;
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
        /// Retourne les images d'un type de véhicule.
        /// </summary>
        /// <param name="vehicleTypeId"></param>
        /// <returns></returns>
        public List<Picture> Getpics(int vehicleTypeId)
        {
            List<Picture> pics = new List<Picture>();
            try
            {
                DataTable table = DalVehicle.GetPics(vehicleTypeId);
                if (table != null)
                {
                    if (table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in table.DefaultView)
                        {
                            Picture temp = new Picture
                            {
                                Id = (int)row["Id"],
                                VehicleTypeId = (int)row["VehicleType_Id"],
                                Label = row["Label"].ToString(),
                                IsLarge = (bool)row["IsLarge"],

                            };
                            pics.Add(temp);
                        }
                    }
                }
                return pics;
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
