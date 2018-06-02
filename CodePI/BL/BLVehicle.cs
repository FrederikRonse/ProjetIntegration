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
        /// Permet de passe les filtres de selection
        /// entre la partie web et la dal.
        /// </summary>
        public class Vehiclefilter : DalVehicle.VehicleFilters
        {
            public DateTime StartDate { get => _startDate; set => _startDate = value; }
            public DateTime EndDate { get => _endDate; set => _endDate = value; }
            public string OfficeName { get => _officeName; set => _officeName = value; }
            public string MakeName { get => _makeName; set => _makeName = value; }
            public string FuelName { get => _fuelName; set => _fuelName = value; }
            public byte DoorsCount { get => _doorsCount; set => _doorsCount = value; }
        }


        /// <summary>
        /// retourne un véhicle par son ID, sans détails
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public VehicleShort GetVehicleShort(int id)
        {
            VehicleShort _vehicleToReturn = new VehicleShort();
            try
            {
                DataTable _table = DalVehicle.GetVehicleById(id);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        DataRowView row = _table.DefaultView[0];
                        VehicleShort temp = new VehicleShort();
                        temp.Id = (int)row["Id"];
                        temp.TypeId = (int)row["Vehicle_Id"];
                        temp.TarifId = (int)row["Customer_Id"];
                        _vehicleToReturn = temp;
                    }
                }
                return _vehicleToReturn;
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
            VehicleDetails _vehicleToReturn = new VehicleDetails();
            try
            {
                DataTable _table = DalVehicle.GetVehicleById(id);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        DataRowView row = _table.DefaultView[0];
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
                        _vehicleToReturn = temp;
                    }
                }
                return _vehicleToReturn;
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
            List<VehicleDetails> _vehicleToReturn = new List<VehicleDetails>();
            try
            {
                DataTable _table = DalVehicle.GetVehiclesByFilter((DalVehicle.VehicleFilters)vehicleFilters);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
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
                            _vehicleToReturn.Add(temp);
                        }
                    }
                }
                return _vehicleToReturn;
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
            List<Picture> _pics = new List<Picture>();
            try
            {
                DataTable _table = DalVehicle.GetPics(vehicleTypeId);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
                        {
                            Picture temp = new Picture
                            {
                                Id = (int)row["Id"],
                                VehicleTypeId = (int)row["VehicleType_Id"],
                                Label = row["Label"].ToString(),
                                IsLarge = (bool)row["IsLarge"],

                            };
                            _pics.Add(temp);
                        }
                    }
                }
                return _pics;
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
