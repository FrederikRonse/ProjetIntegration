using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EL
{
    public static class CheckInputStrg
    {
        public enum InputType
        {
            Isbn, Title, Name, ItemCode, CardNum 
        }

        /// <summary>
        /// Vérifie la validité des strings entrés par rapport aux règles métier.
        /// </summary>
        /// <param name="controlName"></param>
        /// <param name="txtToChck"></param>
        /// <returns></returns>
        public static bool Check(InputType inputType, string txtToChck)
        {
            bool IsOk = false;
            switch (inputType)
            {
                //Uniquement 10 ou 13 caractères décimaux.
                case InputType.Isbn:
                    if ((txtToChck.Length == 10 || txtToChck.Length == 13)
                        && txtToChck.Any(c => char.IsDigit(c)))
                        IsOk = true;
                    break;
                //Entre 1 et 50 caractères.
                // Vérifie que le string n'est pas composé uniquement d'espaces. 
                case InputType.Title:
                    if (!String.IsNullOrWhiteSpace(txtToChck)
                        && txtToChck.Length > 1
                        && txtToChck.Length < 50)
                        IsOk = true;
                    break;
                // Entre 3 et 20 caractères. 
                // Vérifie que le string n'est pas vide ou composé uniquement d'espaces 
                // et que chaque caractère est soit une lettre ou un espace ou " ' " ou "-".)
                case InputType.Name:
                    if ((txtToChck.Length >= 3 && txtToChck.Length <= 50)
                        && (!String.IsNullOrWhiteSpace(txtToChck)
                        && (txtToChck.Any(c => char.IsLetter(c)
                                || char.IsWhiteSpace(c)
                                || char.Equals(c, "'")
                                || char.Equals(c, "-")))))
                        IsOk = true;
                    break;

                // Entre 5 et 20 caractères. Uniquement des caractères alphanumériques.
                case InputType.ItemCode:
                    if ((txtToChck.Length > 5 && txtToChck.Length <= 20)
                        && (txtToChck.Any(c => char.IsLetterOrDigit(c))))
                        IsOk = true;
                    break;

                //uniquement des chiffres
                case InputType.CardNum:
                    if (//(!String.IsNullOrWhiteSpace(txtToChck)&&
                         (txtToChck.Any(c => char.IsDigit(c))))//)
                        IsOk = true;
                    break;

                //Pas de date future. // Géré dans la méthode concernée.
                default:
                    break;
            }
            return IsOk;
        }
    }
}
