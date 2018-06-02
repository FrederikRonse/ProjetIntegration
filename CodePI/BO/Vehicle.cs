using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BO
{
    public class VehicleType
    {
        public int Id { get; set; }
        public string MakeName { get; set; }
        public string ModelName { get; set; }
        public string FuelName { get; set; }
        public string CCName { get; set; }
        public byte DoorsCount { get; set; }
    }

    public class VehicleShort
    {
        public int Id { get; set; }
        public int TypeId { get; set; }
        public int TarifId { get; set; }
    }

    public class VehicleDetails
    {
        public int VehicleId { get; set; }
        public string OfficeName { get; set; }
        public decimal DailyPrice { get; set; }
        public VehicleType VehicleType { get; set; }
        public List<Picture> Pictures { get; set; }
    }

    public class Picture
    {
        public int Id { get; set; }
        public int VehicleTypeId { get; set; }
        public string Label { get; set; }
        public bool? IsLarge { get; set; }
    }

    /// <summary>
    /// Classe intialement dans DAL.vehicle
    /// permet de passer les filtres de selection de véhicules.
    /// </summary>
    public class Vehiclefilter
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

    ///// <summary>
    ///// version plus brouillonne mais plus rapide à l'usage.
    ///// </summary>
    //public class VehicleDetails
    //{
    //    public int VehicleId { get; set; }
    //    public string OfficeName { get; set; }
    //    public decimal DailyPrice { get; set; }
    //    public int TypeId { get; set; }
    //    public string MakeName { get; set; }
    //    public string ModelName { get; set; }
    //    public string FuelName { get; set; }
    //    public string CCName { get; set; }
    //    public byte DoorsCount { get; set; }
    //    public Pictures[] Pictures { get; set; }
    //}


}
