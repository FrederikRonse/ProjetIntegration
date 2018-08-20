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
        /// Permet de passer les filtres de selection
        /// entre la partie web et la dal.
        /// </summary>
        //public class Vehiclefilter : DalVehicle.VehicleFilters
        //{
        //    public DateTime StartDate { get => _startDate; set => _startDate = value; }
        //    public DateTime EndDate { get => _endDate; set => _endDate = value; }
        //    public string OfficeName { get => _officeName; set => _officeName = value; }
        //    public string MakeName { get => _makeName; set => _makeName = value; }
        //    public string FuelName { get => _fuelName; set => _fuelName = value; }
        //    public byte DoorsCount { get => _doorsCount; set => _doorsCount = value; }
        //}

        /// <summary>
        /// Retourne les filtres possibles pour la selection des véhicules.
        /// </summary>
        /// <returns></returns>
        public static FilterOptions GetFilterOptions()
        {
            FilterOptions _filterToReturn = new FilterOptions();
            try
            {
                DataSet dataSet = DAL.DalVehicle.GetFilterOptions();
                if (dataSet != null)
                {
                    List<string> _officeList = new List<string>();
                    List<string> _MakeList = new List<string>();
                    List<string> _CCList = new List<string>();
                    List<string> _FuelList = new List<string>();
                    List<byte> _DoorsList = new List<byte>();

                    foreach (DataRow row in dataSet.Tables["OfficeList"].Rows)
                    {
                        _officeList.Add(row[0].ToString());
                    }
                    foreach (DataRow row in dataSet.Tables["MakeList"].Rows)
                    {
                        _MakeList.Add(row[0].ToString());
                    }
                    foreach (DataRow row in dataSet.Tables["CCList"].Rows)
                    {
                        _CCList.Add(row[0].ToString());
                    }
                    foreach (DataRow row in dataSet.Tables["FuelList"].Rows)
                    {
                        _FuelList.Add(row[0].ToString());
                    }
                    foreach (DataRow row in dataSet.Tables["DoorsList"].Rows)
                    {
                        _DoorsList.Add((byte)row[0]);
                    }
                    _filterToReturn.lstOffices = _officeList;
                    _filterToReturn.lstMakes = _MakeList;
                    _filterToReturn.lstCC = _CCList;
                    _filterToReturn.lstFuels = _FuelList;
                    _filterToReturn.lstDoors = _DoorsList;
                }
                return _filterToReturn;
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
        public static VehicleDetails GetVehicle(int id, bool withPics = true)
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
        /// Récupération d'un type de véhicule avec détails.
        /// Photos optionnelles.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="withPics"></param>
        /// <returns></returns>
        public static VehicleDetails GetVehicleTypeById(int id, bool withPics = true)
        {
            VehicleDetails _vehicleToReturn = new VehicleDetails();
            try
            {
                DataTable _table = DalVehicle.GetVehicleTypeById(id);
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
        public static List<VehicleDetails> GetVehicleByFilter(SlctdFilters vehicleFilters, bool withPics = true)
        {
            List<VehicleDetails> _vehicleToReturn = new List<VehicleDetails>();
            try
            {
                DalVehicle.VehicleFilters _vehicleFilters = new DalVehicle.VehicleFilters();
                _vehicleFilters.StartDate = vehicleFilters.StartDate;
                _vehicleFilters.EndDate = vehicleFilters.EndDate;
                _vehicleFilters.OfficeName = vehicleFilters.OfficeName;
                _vehicleFilters.MakeName = vehicleFilters.MakeName;
                _vehicleFilters.FuelName = vehicleFilters.FuelName;
                _vehicleFilters.DoorsCount = vehicleFilters.DoorsCount;

                DataTable _table = DalVehicle.GetVehiclesByFilter(_vehicleFilters);
                if (_table != null)
                {
                    if (_table.Rows.Count != 0)
                    {
                        foreach (DataRowView row in _table.DefaultView)
                        {
                            VehicleDetails temp = new VehicleDetails();
                            VehicleType vehicleType = new VehicleType();
         //                   temp.VehicleId = (int)row["Id"];
                            temp.OfficeName = row["Office_name"].ToString();
                            temp.DailyPrice = (decimal)row["DailyPrice"];
                            // Ajout des caracteristiques "type"
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
        public static List<Picture> Getpics(int vehicleTypeId)
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
                                Path = row["Path"].ToString(),

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


        /// <summary>
        /// retourne un véhicle par son ID, sans détails
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static VehicleShort GetVehicleShort(int id)
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
    }
}
