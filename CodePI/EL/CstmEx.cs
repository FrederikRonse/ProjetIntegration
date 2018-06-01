using System;
using System.Collections.Generic;
//using System.Linq;
//using System.Text;
using System.Threading.Tasks;
//using System.Windows.Forms;

namespace EL
{
    public class CstmEx : ApplicationException
    {
        private ExType _exType;
        private Exception _e;

        public enum ExType
        {
            noExMsg,
            notHandled,
            notHandledSql,
            srvrError,
            noConnStr,
            endPointNotFound,
            badDB,
            badPWD,
            sqlLineCount,
            rcrdExist,
            noResult,
            dtaRead,
            dtaWrite,
            dtaUpdate,
            dtaDelete,
            retry,
        }

        /// <summary>
        /// Instancie une exception Custom.
        /// (Remplace "throw New".
        /// </summary>
        /// <param name="exType"></param>
        /// <param name="e"></param>
        /// <returns></returns>
        public static CstmEx ThrowCstmEx(ExType exType, Exception e = null)
        {
            throw new CstmEx(exType, e);
        }

        /// <summary>
        ///  Constructeur recevant le numéro d'erreur à déclancher
        ///  et une éventuelle exception remontée (pour relancer une exception sql non traitée,...).
        /// </summary>
        /// <param name="exType"></param>
        /// <param name="e"></param>
        public CstmEx(ExType exType, Exception e = null)
        {
            _exType = exType;
            _e = e;
        }

        /// <summary>
        /// Retourne l'exception originellement interceptéé.
        /// Surcharge de "InnerException" héritée.
        /// </summary>
        public new Exception InnerException
        {
            get
            {
                return _e;
            }
        }

        /// <summary>
        /// Renvoie le type d'exception custom.
        /// "GetType" existe déjà pour les exceptions normales.
        /// </summary>
        public ExType GetExType
        {
            get
            {
                return _exType;
            }
        }

        /// <summary>
        /// Renvoie le message d'erreur en fonction du type d'exception custom 
        /// entré en paramètre du constructeur.
        /// </summary>
        /// <returns>message d'erreur</returns>
        public string GetMsg
        {
            get
            {
                string sMessage;
                switch (_exType)
                {
                    case ExType.notHandled:
                        sMessage = String.Format("Exception sans traitement particulier ! \n {0} \n {1}", _e.Message, _e.TargetSite);
                        break;

                    case ExType.notHandledSql:
                        sMessage = "Erreur SQL non traitée !";
                        if (_e != null) throw _e;
                        break;

                    case ExType.srvrError:
                        sMessage = "Une erreur est survenue au niveau du serveur !";
                        break;

                    case ExType.noConnStr:
                        sMessage = "pas de ConnectionString disponible !";
                        break;

                    case ExType.endPointNotFound:
                        sMessage = " End point not found! Vérifiez que le serveur est lancé.";
                        break;

                    case ExType.badDB:
                        sMessage = "Mauvaise base de données !";
                        break;
                    case ExType.badPWD:
                        sMessage = "Mauvais mot de passe !";
                        break;
                    case ExType.sqlLineCount:
                        sMessage = "nbre de lignes affectées lors de l'opération sql erronné !";
                        break;
                   
                    case ExType.rcrdExist:
                        sMessage = "Cet enregistrement existe déjà !"; //Erreur SQL : violation d'unicité d'index !
                        break;

                    case ExType.noResult:
                        sMessage = " Aucun résultat ne correspond à cette recherche !";
                        break;

                    case ExType.dtaRead:
                        sMessage = "Un problème est survenu à la récupération des données !";
                        break;

                    case ExType.dtaWrite:
                        sMessage = " Un problème est survenu à l'ajout !";
                        break;

                    case ExType.dtaUpdate:
                        sMessage = " Un problème est survenu à la modification des données !";
                        break;
                 
                    case ExType.dtaDelete:
                        sMessage = " Un problème est survenu à la suppression ! ";
                        break;

                    case ExType.retry:
                        sMessage = " La modification n'a pas pu être effectuée ! \n Veuillez réessayer.";
                        break;

                    default:
                        sMessage = String.Format("Pas de message d'erreur adapté ! \n {0} \n {1}", _e.Message, _e.TargetSite);
                        break;
                }
                return sMessage;
            }
        }

        /// <summary>
        /// Retourne le log.
        /// </summary>
        public string GetLog
        {
            private set
            {

            }
            get
            {
                string returnStr = "";
                if (_e.Data.Contains("Log"))
                {
                    returnStr = string.Format("\n Log : \n{0}", _e.Data["Log"].ToString());
                }
                return returnStr;
            }
        }

        /// <summary>
        /// Centralise la création des fenêtres de dialogue suite à la levée d'une exception dans le programme.
        /// </summary>
        /// <param name="e"></param>
        //public static void Display(CstmEx e)
        //{
        //    string message = e.GetMsg;
        //    if (e.Data.Contains("Log"))
        //    {
        //        string log = string.Format("\n Log : \n{0}", e.Data["Log"].ToString());
        //        message += log;
        //    }
        //    MessageBox.Show(message, "Attention", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        //}
    }
}
