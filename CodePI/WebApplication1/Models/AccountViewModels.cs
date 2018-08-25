using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }

    public class ExternalLoginListViewModel
    {
        public string ReturnUrl { get; set; }
    }

    public class SendCodeViewModel
    {
        public string SelectedProvider { get; set; }
        public ICollection<System.Web.Mvc.SelectListItem> Providers { get; set; }
        public string ReturnUrl { get; set; }
        public bool RememberMe { get; set; }
    }

    public class VerifyCodeViewModel
    {
        [Required]
        public string Provider { get; set; }

        [Required]
        [Display(Name = "Code")]
        public string Code { get; set; }
        public string ReturnUrl { get; set; }

        [Display(Name = "Remember this browser?")]
        public bool RememberBrowser { get; set; }

        public bool RememberMe { get; set; }
    }

    public class ForgotViewModel
    {
        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }

    public class LoginViewModel
    {
        [Required]
        [EmailAddress]
        [DataType(DataType.EmailAddress)]
        [MaxLength(50)]
        [Display(Name = "Email")]
        public string Email { get; set; }

        //[Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserPassError")]
        [StringLength(100, ErrorMessageResourceName = "UserPassError", ErrorMessageResourceType = typeof(Resource), MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "UserPassword", ResourceType = typeof(Resource))]
        public string Password { get; set; }
       
        [Display(Name = "UserRemember", ResourceType = typeof(Resource))]
        public bool RememberMe { get; set; }
    }

    public class RegisterViewModel
    {
        [Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserEmail")]
        [EmailAddress]
        [DataType(DataType.EmailAddress)]
        [MaxLength(50)]
        [Display(Name = "Email")]
        public string Email { get; set; }
        // TODO corriger our remmettre filtres accoutnviewmodels d'origine
        [Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserPassError")]
        [StringLength(100, ErrorMessageResourceName = "UserPassError", ErrorMessageResourceType = typeof(Resource), MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "UserPassword", ResourceType = typeof(Resource))]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "UserPasswordCfrm", ResourceType = typeof(Resource))]
        [Compare("Password", ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserPassCfrmError")]
        public string ConfirmPassword { get; set; }

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
        public string UserBDay { get; set; }
    }

    public class ResetPasswordViewModel
    {
        [Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserEmail")]
        [EmailAddress]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserPassError")]
        [StringLength(100, ErrorMessageResourceName = "UserPassError", ErrorMessageResourceType = typeof(Resource), MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "UserPassword", ResourceType = typeof(Resource))]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "UserPasswordCfrm", ResourceType = typeof(Resource))]
        [Compare("Password", ErrorMessageResourceType = typeof(Resource), ErrorMessageResourceName = "UserPassCfrmError")]
        public string ConfirmPassword { get; set; }


        public string Code { get; set; }
    }

    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }
}
