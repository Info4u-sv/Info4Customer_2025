using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Data.SqlClient;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI.HtmlControls;

namespace INTRA.Users
{
    public partial class ProfiloUtente : System.Web.UI.Page
    {
        string username = string.Empty;
        //MembershipUser user;


        protected void Page_Load(object sender, EventArgs e)
        {

            #region Not used code
            //CARICA I DATI DELL'UTENTE SELEZIONATO

            //MembershipUser u = Membership.GetUser();
            //UserTxt_B.Text = u.UserName;
            //UserTxt.Text = u.UserName;
            //RegMailTxt.Text = u.Email;


            ////ottiene i campi personalizzati
            //dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserTxt_B.Text, true);
            //bool ExchangeEnabled = Convert.ToBoolean(WebConfigurationManager.AppSettings["ExchangeEnabled"]);
            //Exchange_panel.Visible = ExchangeEnabled;
            //if (!IsPostBack)
            //{
            //    NomeTxt_B.Text = MyProfile.nome;
            //    CognomeTxt_B.Text = MyProfile.cognome;
            //    SocietaTxt_B.Text = MyProfile.Societa;
            //    //TipoSocietaTxt_B.Text = MyProfile.tipo_soc;
            //    //CodFiscPrivTxt_B.Text = MyProfile.CodiceFiscale;
            //    IndPrivTxt_B.Text = MyProfile.Indirizzo;
            //    CapPrivTxt_B.Text = MyProfile.Cap;
            //    CittaPrivTxt_B.Text = MyProfile.citta;
            //    ProvPrivTxt_B.Text = MyProfile.Provincia;
            //    TelPrivTxt_B.Text = MyProfile.Telefono;
            //    FaxPrivTxt_B.Text = MyProfile.fax;


            //    //firmaTecnico.Src = MyProfile.FirmaTecnico;
            //    ImgTecnico_B.Src = MyProfile.ImgTecnico;
            //    if (ExchangeEnabled)
            //    {
            //        Utente_Exchange_Txt_B.Text = MyProfile.ExchangeUser;
            //        Password_Exchange_Txt_B.Text = MyProfile.ExchangePsw;
            //        DfCalendar_Exchange_Txt_B.Text = "calendario";

            //    }


            //    if (MyProfile.email.Equals("") || (MyProfile.email.Equals(null)))
            //    {
            //        ContactMailTxt_B.Text = u.Email;
            //    }
            //    else
            //    {
            //        ContactMailTxt_B.Text = MyProfile.email;
            //    }
            //}
            #endregion
            if (!IsPostBack)
            {
                MembershipUser user = Membership.GetUser();
                UserTxt.Text = user.UserName;
                RegMailTxt.Text = user.Email;
                dynamic MyProfile = ProfileBase.Create(user.UserName, true);
                ImgTecnico_B.Src = MyProfile.ImgTecnico;
                HtmlGenericControl RegioneSociale_div = ragioneSociale_div;
                HtmlGenericControl Profilo_Div = profilo_div;
                HtmlGenericControl ChangePassword_div = cambiaPassword_div;
                if (CheckIfUserIsOuterSeller(user.UserName))
                {
                    Rivenditore_Det_CRUD rivenditore = new Rivenditore_Det_CRUD()[user.UserName];
                    Denom_text.Text = rivenditore.Denom;
                    Nazione_Combox.Value = rivenditore.CodNaz;
                    Indirizzo_Txt.Text = rivenditore.Ind;
                    Provincia_Combobox.Value = rivenditore.Prov;
                    Cap_text.Text = rivenditore.Cap;
                    Local_Txt.Text = rivenditore.Loc;
                    SitoWeb_txt.Text = rivenditore.SitoWeb;
                    EMail_text.Text = rivenditore.EMail;
                    Tel_text.Text = rivenditore.Tel;
                    PIva_text.Text = rivenditore.PIva;
                    Ricarico_spin.Value = rivenditore.MarginePercent;
                    RegioneSociale_div.Style.Add("display", "inherit");
                    Profilo_Div.Attributes["class"] = "col-md-4";
                    ChangePassword_div.Attributes["class"] = "col-md-12";
                }
                else
                {
                    RegioneSociale_div.Style.Add("display", "none");
                    Profilo_Div.Attributes["class"] = "col-md-12";
                    ChangePassword_div.Attributes["class"] = "col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3";
                }
            }
        }

        private void Page_PreRender()
        {
        }




        protected void FirmaTecnico_LinkB_Click(object sender, EventArgs e)
        {
            Response.Redirect("Firma_Tecnico.aspx");
        }
        protected void CambiaPsw_LinkBt_Click(object sender, EventArgs e)
        {
            MembershipUser user = Membership.GetUser();

            // var user = user.UserName;
            // var user = Membership.GetUser(Request.QueryString["username"]);
            if (confirmPasswordTextBox != null)
            {
                user.ChangePassword(user.ResetPassword(), confirmPasswordTextBox.Text);
                Response.Redirect("ProfiloUtente.aspx?Msg=1");
            }
        }


        protected void UpdateDetRiv_pnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            MembershipUser user = Membership.GetUser();
            dynamic MyProfile = ProfileBase.Create(user.UserName, true);
            if (CheckIfUserIsOuterSeller(user.UserName))
            {
                Rivenditore_Det_CRUD rivenditore = new Rivenditore_Det_CRUD();
                rivenditore.ID_VIO_Utenti = rivenditore.GetIdUtente(user.UserName);
                rivenditore.Denom = Denom_text.Text;
                rivenditore.CodNaz = Nazione_Combox.SelectedItem.Value.ToString();
                rivenditore.Ind = Indirizzo_Txt.Text;
                rivenditore.Prov = Provincia_Combobox.SelectedItem.Value.ToString();
                rivenditore.Cap = Cap_text.Text;
                rivenditore.Loc = Local_Txt.Text;
                rivenditore.SitoWeb = SitoWeb_txt.Text;
                rivenditore.EMail = EMail_text.Text;
                rivenditore.Tel = Tel_text.Text;
                rivenditore.PIva = PIva_text.Text;
                rivenditore.MarginePercent = Convert.ToDecimal(Ricarico_spin.Value);
                rivenditore.DetRivenditore_Update(rivenditore);
            }
            if (textAreaFileContents != null)
            {
                if (!string.IsNullOrEmpty(textAreaFileContents.Value.ToString()))
                {
                    MyProfile.ImgTecnico = textAreaFileContents.Value;

                }
            }

            MyProfile.Save();
            ((ASPxCallbackPanel)sender).JSProperties["cpImagineTecnico"] = MyProfile.ImgTecnico;
            //ASPxWebControl.RedirectOnCallback(VirtualPathUtility.ToAbsolute("/Users/ProfiloUtente.aspx?Msg=1")); 
        }



        #region NON USATO
        //protected void btnSaveRegister_Click(object sender, EventArgs e)
        //{
        //            //raccolta e salvataggio dati
        //            dynamic MyProfile = (ProfileBase)ProfileBase.Create(UserTxt.Text, true);
        //            bool ExchangeEnabled = Convert.ToBoolean(WebConfigurationManager.AppSettings["ExchangeEnabled"]);
        //#pragma warning disable CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata
        //            try
        //            {
        //                MyProfile.nome = NomeTxt_B.Text;
        //                MyProfile.cognome = CognomeTxt_B.Text;
        //                MyProfile.Societa = SocietaTxt_B.Text;
        //                //MyProfile.tipo_soc = TipoSocietaTxt_B.Text;
        //                //MyProfile.CodiceFiscale = CodFiscPrivTxt_B.Text;
        //                MyProfile.Indirizzo = IndPrivTxt_B.Text;
        //                MyProfile.Cap = CapPrivTxt_B.Text;
        //                MyProfile.citta = CittaPrivTxt_B.Text;
        //                MyProfile.Provincia = ProvPrivTxt_B.Text;
        //                MyProfile.Telefono = TelPrivTxt_B.Text;
        //                MyProfile.fax = FaxPrivTxt_B.Text;
        //                MyProfile.email = ContactMailTxt_B.Text;
        //                if (textAreaFileContents != null)
        //                {
        //                    if (!string.IsNullOrEmpty(textAreaFileContents.Value.ToString()))
        //                    {
        //                        MyProfile.ImgTecnico = textAreaFileContents.Value;

        //                    }
        //                }
        //                if (ExchangeEnabled)
        //                {
        //                    MyProfile.ExchangeUser = Utente_Exchange_Txt_B.Text;
        //                    MyProfile.ExchangePsw = Password_Exchange_Txt_B.Text;
        //                    MyProfile.DefaultCalendar = DfCalendar_Exchange_Txt_B.Text;
        //                }
        //                else { }

        //                MyProfile.Save();
        //            }
        //            catch (Exception ex)
        //            {
        //                Response.Redirect("ProfiloUtente.aspx?&Msg=0");
        //            }
        //#pragma warning restore CS0168 // La variabile 'ex' è dichiarata, ma non viene mai usata

        //            Response.Redirect("ProfiloUtente.aspx?Msg=1");
        //}
        #endregion

        protected void ChangePassword_pnl_Callback(object sender, CallbackEventArgsBase e)
        {
            MembershipUser user = Membership.GetUser();
            user.ChangePassword(user.ResetPassword(), confirmPasswordTextBox.Text);

        }


        protected bool CheckIfUserIsOuterSeller(string UserName)
        {
            bool retval = false;
            string tipoAge = string.Empty;
            string sql = $"SELECT TipoAge FROM VIO_Utenti WHERE (UtenteIntranet = N'{UserName}')";
            SqlDataReader reader = new Sql4Helper().ExecuteReader(sql);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    tipoAge = reader["TipoAge"].ToString();
                }
            }
            retval = tipoAge == "Esterno";
            return retval;
        }
    }
}