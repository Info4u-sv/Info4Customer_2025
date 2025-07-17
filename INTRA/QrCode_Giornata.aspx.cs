using DevExpress.Web;
using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace INTRA
{
    public partial class QrCode_Giornata : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser UserLog = Membership.GetUser();
                SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT CodDep FROM U_Giornata_Testata WHERE Status = 1 AND UtenteApertura = (@UtenteApertura)", new SqlParameter() { ParameterName = "@UtenteApertura", Value = UserLog.UserName });
                if (reader.Read())
                {
                    Errore_Lbl.Text = "Un'altra sessione di lavoro è ancora aperta, chiuderla prima di continuare. ";
                    Errore_Btn.ClientVisible = true;
                }
                else
                {
                    Messaggio_Lbl.Text = "Non ci sono giornate aperte, è possibile aprirne una nuova.";
                }
                
            }
        }
        protected void Accesso_Callbackpnl_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            MembershipUser UserLog = Membership.GetUser();
            dynamic MyProfile = HttpContext.Current.Profile;
            string[] Parametri = e.Parameter.Split('-');
            string pattern = @"^[A-Z]\d{3}$";
            Regex regex = new Regex(pattern);
            if (regex.IsMatch(Parametri[0]) && Parametri.Length > 1)
            {
                if (Parametri[1] == "chiudi")
                {
                    KING_CRUD upd = new KING_CRUD
                    {
                        UtenteAperturaGiornata = UserLog.UserName,
                        CodDep = Parametri[0] as string,
                    };
                    int ID = upd.U_Giornata_Testata_Chiudi(upd);
                    if (ID != 0)
                    {
                        //SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT TabDep.U_Token, Clienti.Denom, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = upd.CodDep });
                        //if (reader.Read())
                        //{
                        //    HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                        //    if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
                        //    {
                        //        PRT_Cookie_Crud_23.RewriteCoockies("CodDep", upd.CodDep, "Dep_Denom", reader["Denom"] as string, "U_Token", reader["U_Token"] != null ? reader["U_Token"].ToString() : null, "Action_Giornata", "chiudi");
                        //    }
                        //    else
                        //    {
                        //        CodDep_cookie = new HttpCookie("CodDep");
                        //        CodDep_cookie.Values.Add("CodDep", upd.CodDep);
                        //        CodDep_cookie.Expires = DateTime.MaxValue;
                        //        Response.Cookies.Add(CodDep_cookie);

                        //        CodDep_cookie = new HttpCookie("Dep_Denom");
                        //        CodDep_cookie.Values.Add("Dep_Denom", reader["Denom"] as string);
                        //        CodDep_cookie.Expires = DateTime.MaxValue;
                        //        Response.Cookies.Add(CodDep_cookie);

                        //        string s = reader["U_Token"] != null ? reader["U_Token"].ToString() : null;
                        //        CodDep_cookie = new HttpCookie("U_Token");
                        //        CodDep_cookie.Values.Add("U_Token", s);
                        //        CodDep_cookie.Expires = DateTime.MaxValue;
                        //        Response.Cookies.Add(CodDep_cookie);

                        //        CodDep_cookie = new HttpCookie("Action_Giornata");
                        //        CodDep_cookie.Values.Add("Action_Giornata", "chiudi");
                        //        CodDep_cookie.Expires = DateTime.MaxValue;
                        //        Response.Cookies.Add(CodDep_cookie);
                        //    }
                        //    HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
                        //    DateTime data = reader["U_UltimoControllo_Inventario"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]);
                        //    if (DataCens_cookie != null /*&& CodCLiDett_cookie != null*/)
                        //    {
                        //        PRT_Cookie_Crud_23.RewriteCoockies("DataCensimento", data.Date.ToString());
                        //    }
                        //    else
                        //    {
                        //        DataCens_cookie = new HttpCookie("DataCensimento");
                        //        DataCens_cookie.Values.Add("DataCensimento", data.Date.ToString());
                        //        DataCens_cookie.Expires = DateTime.MaxValue;
                        //        Response.Cookies.Add(DataCens_cookie);
                        //    }
                        //    Session["AzioneEseguita"] = 1;
                        //    //string script = @"sessionStorage.setItem('AzioneEseguita','1');
                        //    //                 window.location.href = '/ShopRM/Deposito/Deposito_Dett.aspx?CodDep='" + reader["U_Token"] as string+";";
                        //    //ScriptManager.RegisterStartupScript(this,this.GetType(), "setSessionStorage", script, true);
                        //    ASPxWebControl.RedirectOnCallback("/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=" + reader["U_Token"] as string);
                        //}
                        HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                        if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
                        {
                            CodDep_cookie.Expires = DateTime.Now.AddDays(-1d);
                            Response.Cookies.Add(CodDep_cookie);
                        }
                        HttpCookie U_Token_cookie = HttpContext.Current.Request.Cookies["U_Token"];
                        if (U_Token_cookie != null /*&& CodCLiDett_cookie != null*/)
                        {
                            U_Token_cookie.Expires = DateTime.Now.AddDays(-1d);
                            Response.Cookies.Add(U_Token_cookie);
                        }
                        HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
                        if (DataCens_cookie != null /*&& CodCLiDett_cookie != null*/)
                        {
                            DataCens_cookie.Expires = DateTime.Now.AddDays(-1d);
                            Response.Cookies.Add(DataCens_cookie);
                        }
                        Session["AzioneEseguita"] = 1;
                        ASPxWebControl.RedirectOnCallback("/ShopRM/Default.aspx");
                    }
                    else
                    {
                        Errore_Lbl.Text = "Non risulta alcuna giornata aperta per l'utente " + UserLog.UserName.ToUpper();
                        Errore_Lbl.ForeColor = System.Drawing.Color.Red;
                    }

                }
                else
                {
                    KING_CRUD insert = new KING_CRUD
                    {
                        CodDep = Parametri[0] as string,
                        UtenteAperturaGiornata = UserLog.UserName,
                    };

                    int IDPrecedenteSessioneDiLavoro = CheckGiorntataPresente(insert);
                    if (IDPrecedenteSessioneDiLavoro == 0)
                    {
                        insert.CodDep = Parametri[0];
                        insert.UtenteApertura = UserLog.UserName;
                        //insert.AreaCompetenza = MyProfile.AreaCompetenza;
                        insert.U_Giornata_Testata_Ins(insert);
                        SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT TabDep.U_Token, Clienti.Denom, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = insert.CodDep });
                        if (reader.Read())
                        {
                            HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                            if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
                            {
                                PRT_Cookie_Crud_23.RewriteCoockies("CodDep", insert.CodDep, "Dep_Denom", reader["Denom"] as string, "U_Token", reader["U_Token"] != null ? reader["U_Token"].ToString() : null, "Action_Giornata", "apri");
                            }
                            else
                            {
                                CodDep_cookie = new HttpCookie("CodDep");
                                CodDep_cookie.Values.Add("CodDep", insert.CodDep);
                                CodDep_cookie.Expires = DateTime.MaxValue;
                                Response.Cookies.Add(CodDep_cookie);

                                string s = reader["U_Token"] != null ? reader["U_Token"].ToString() : null;
                                CodDep_cookie = new HttpCookie("U_Token");
                                CodDep_cookie.Values.Add("U_Token", s);
                                CodDep_cookie.Expires = DateTime.MaxValue;
                                Response.Cookies.Add(CodDep_cookie);

                                CodDep_cookie = new HttpCookie("Dep_Denom");
                                CodDep_cookie.Values.Add("Dep_Denom", reader["Denom"] as string);
                                CodDep_cookie.Expires = DateTime.MaxValue;
                                Response.Cookies.Add(CodDep_cookie);

                                CodDep_cookie = new HttpCookie("Action_Giornata");
                                CodDep_cookie.Values.Add("Action_Giornata", "apri");
                                CodDep_cookie.Expires = DateTime.MaxValue;
                                Response.Cookies.Add(CodDep_cookie);
                            }
                            HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
                            DateTime data = reader["U_UltimoControllo_Inventario"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(reader["U_UltimoControllo_Inventario"]);
                            if (DataCens_cookie != null /*&& CodCLiDett_cookie != null*/)
                            {
                                PRT_Cookie_Crud_23.RewriteCoockies("DataCensimento", data.Date.ToString());
                            }
                            else
                            {
                                DataCens_cookie = new HttpCookie("DataCensimento");
                                DataCens_cookie.Values.Add("DataCensimento", data.Date.ToString());
                                DataCens_cookie.Expires = DateTime.MaxValue;
                                Response.Cookies.Add(DataCens_cookie);
                            }

                            Session["AzioneEseguita"] = 1;
                            //string script = @"sessionStorage.setItem('AzioneEseguita','1');
                            //                 window.location.href = '/ShopRM/Deposito/Deposito_Dett.aspx?CodDep='" + reader["U_Token"] as string + ";";
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "setSessionStorage", script, true);
                            ASPxWebControl.RedirectOnCallback("/ShopRM/Deposito/Deposito_Dett.aspx?CodDep=" + reader["U_Token"] as string);
                        }

                    }
                    else
                    {
                        Errore_Lbl.Text = "Un'altra sessione di lavoro è ancora aperta, chiuderla prima di continuare. ";
                        Errore_Lbl.ForeColor = System.Drawing.Color.Red;
                        Errore_Btn.ClientVisible = true;
                    }
                }
            }
            else
            {
                Errore_Lbl.Text = "Errore durante la lettura del QrCode. Controllare il QrCode e riprovare. ";
                Errore_Lbl.ForeColor = System.Drawing.Color.Red;
                Errore_Btn.ClientVisible = true;
            }
        }
        protected int CheckGiorntataPresente(KING_CRUD Check)
        {
            int retval = Check.U_Giornata_Testata_QRCode_Check(Check);
            return retval;
        }

        protected void Chiudi_Giornata_Callback_Callback(object source, CallbackEventArgs e)
        {
            HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
            if (CodDep_cookie != null)
            {
                CodDep_cookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(CodDep_cookie);
            }
            HttpCookie U_Token_cookie = HttpContext.Current.Request.Cookies["U_Token"];
            if (U_Token_cookie != null)
            {
                U_Token_cookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(U_Token_cookie);
            }
            HttpCookie DataCens_cookie = HttpContext.Current.Request.Cookies["DataCensimento"];
            if (DataCens_cookie != null)
            {
                DataCens_cookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(DataCens_cookie);
            }
            MembershipUser UserLog = Membership.GetUser();
            new Sql4Gestionale().ExecuteNonQuery("UPDATE U_Giornata_Testata SET Status = 3, DataFine = GETDATE(), UtenteChiusura = UtenteApertura WHERE Status = 1 AND UtenteApertura = '" + UserLog.UserName +"'");
        }
        //protected bool CheckGiornataUtente(string Utente)
        //{
        //    bool check = false;
        //    SqlDataReader reader = new Sql4Gestionale().ExecuteReader("SELECT TabDep.CodDep FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE CodDep = '" + insert.CodDep + "'");
        //    if (reader.Read())
        //    {
        //    }
        //    return check;
        //}
    }
}