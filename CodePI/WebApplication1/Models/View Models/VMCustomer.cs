using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models.View_Models
{
    public class VMCustomer
    {
        [Key]
        [ScaffoldColumn(false)]
        public string Cstmr_Id { get; set; }

        [DataType(DataType.Text)]
        [Display(Name = "UserName", ResourceType = typeof(Resource))]
        [MaxLength(50)]
        public string UserName { get; set; }

        [DataType(DataType.Text)]
        [Display(Name = "UserFirstName", ResourceType = typeof(Resource))]
        [MaxLength(50)]
        public string UserFirstName { get; set; }

        [DataType(DataType.Text)]
        [Display(Name = "UserLastName", ResourceType = typeof(Resource))]
        [MaxLength(50)]
        public string UserLastName { get; set; }

        [DataType(DataType.Text)]
        [Display(Name = "UserPhone", ResourceType = typeof(Resource))]
        [MaxLength(50)]
        public string UserPhone { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "UserBDay", ResourceType = typeof(Resource))]
        public DateTime UserBDay { get; set; }

        [Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserEmail")]
        [EmailAddress]
        [DataType(DataType.EmailAddress)]
        [MaxLength(50)]
        [Display(Name = "Email")]
        public string Email { get; set; }
      
    }
}