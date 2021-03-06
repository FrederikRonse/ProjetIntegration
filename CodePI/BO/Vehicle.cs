﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BO
{

    public class FilterOptions
    {
        public List<string> lstOffices { get; set; }
        public List<string> lstMakes { get; set; }
        public List<string> lstCC { get; set; }
        public List<string> lstFuels { get; set; }
        public List<byte> lstDoors { get; set; }
    }

    public class SlctdFilters
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string OfficeName { get; set; }
        public string MakeName { get; set; }
        public string FuelName {get; set; }
        public byte DoorsCount {get; set; }
    } 

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
        public string Path { get; set; }
        public int VehicleTypeId { get; set; }
        public string Label { get; set; }
        public bool? IsLarge { get; set; }
    }

}
