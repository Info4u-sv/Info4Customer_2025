using DevExpress.Web;
using DevExpress.Xpo;
using info4lab.Portal;
using Info4U.Models;
using INTRA.AppCode;
using INTRA.ShopRM.AppCode;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;

namespace INTRA.Magazzino
{
    public partial class Dashboard_Magazzino_V2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Cambia_Dep_Callback_Callback(object source, CallbackEventArgs e)
        {
            Session["CodDep_Session"] = e.Parameter as string;
            Articoli_Dts.DataBind();
        }

        protected void Genera_Ordine_Callback_Callback(object source, CallbackEventArgs e)
        {
            string CodDep = Session["CodDep_Session"] as string;
            //SqlParameter[] parameters = new SqlParameter[] {
            //    new SqlParameter("@CodDep",CodDep)
            //};
            SqlDataReader reader = new Info4U.Models.Sql4Gestionale().ExecuteReader("SELECT CodCLi FROM TabDep WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            string CodCli = "";
            if (reader.Read())
            {
                CodCli = reader["CodCli"] as string;
            }

            Ordini_Crud_v2 InserimentoTest = new Ordini_Crud_v2();
            InserimentoTest.OrdDat = DateTime.Now;
            InserimentoTest.PrevCons = DateTime.Now;
            InserimentoTest.CodCli = CodCli;
            InserimentoTest.CodPag = string.Empty;

            InserimentoTest.CodBan = string.Empty;

            InserimentoTest.BanCli = GetBancli_BYCodCli(CodCli);

            InserimentoTest.NumOrdCli = string.Empty;
            InserimentoTest.DataOrdCli = DateTime.Now;
            InserimentoTest.CodVal = string.Empty;

            InserimentoTest.Agente = string.Empty;
            InserimentoTest.Deposito = CodDep;
            InserimentoTest.Sconto1 = 0;
            InserimentoTest.Sconto2 = 0;
            InserimentoTest.CodLis = "00";
            InserimentoTest.Note = string.Empty;

            InserimentoTest.CodDiv = string.Empty;

            InserimentoTest.CodSpe1 = string.Empty;

            InserimentoTest.CodSpe2 = string.Empty;
            InserimentoTest.CodPor = string.Empty;
            //string OrdNum = string.Empty;
            //OrdNum = "O" + UpdateLastIdProtocollo();

            //InserimentoTest.OrdNum = OrdNum;
            InserimentoTest.CostoTrasporto = 0;
            InserimentoTest.FlagTrasporto = false;

            InserimentoTest.U_IdBozza = 0;

            int LastIdOrdine = InserimentoTest.U_I_OrdCliTest_Insert(InserimentoTest);
            int daFatt = 0, daContr = 0;
            string RifIvaCliente = Order.GetRifIva_V2(CodCli);
            reader = new Info4U.Models.Sql4Gestionale().ExecuteReader(@"SELECT        U_Inventario_Deposito.CodArt, Articoli.Misura, U_Inventario_Deposito.Qta_Eff, U_Inventario_Deposito.DaFatturare
FROM            U_Inventario_Deposito INNER JOIN
                         Articoli ON U_Inventario_Deposito.CodArt = Articoli.CodArt WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = CodDep });
            int totQta = 0, nRiga = 1;
            while (reader.Read())
            {
                if (Convert.ToInt32(reader["Qta_Eff"]) > 0)
                {
                    if (Convert.ToInt32(reader["DaFatturare"]) == 1) daFatt++; else daContr++;
                    totQta += Convert.ToInt32(reader["Qta_Eff"]);
                    U_OrdCliDett_Insert(Convert.ToInt32(reader["Qta_Eff"]), reader["CodArt"] as string, reader["Misura"] as string, LastIdOrdine, RifIvaCliente, Session["CodDep_Session"] as string,nRiga);
                    nRiga++;
                    new AppCode.Sql4Gestionale().ExecuteNonQuery(string.Format("UPDATE U_Inventario_Deposito SET Qta_Eff = 0 WHERE CodArt = '{0}' AND CodDep = '{1}'", reader["CodArt"] as string, Session["CodDep_Session"] as string));
                    new AppCode.Sql4Gestionale().ExecuteNonQuery("UPDATE U_I_OrdCliDett SET U_DaEvadere = @Qta WHERE CodArt = @CodArt AND IDTestata = @ID",new SqlParameter { ParameterName="@Qta", Value = Convert.ToInt32(reader["Qta_Eff"]) },
                        new SqlParameter { ParameterName = "@CodArt", Value = reader["CodArt"] as string }, new SqlParameter { ParameterName = "@ID", Value = LastIdOrdine });
                }
                
            }
            Ordini_Crud_v2 UpdateQta = new Ordini_Crud_v2();
            UpdateQta.TotQta = (float)Convert.ToDouble(totQta);
            UpdateQta.TotImp = 0;
            UpdateQta.IdTestata = LastIdOrdine;
            UpdateQta.U_OrdCliTestQta_Update(UpdateQta);

            if (daFatt > 0)
            {
                MembershipUser UserLog = Membership.GetUser();
                AppCode.Sql4Gestionale objSqlHelper = new AppCode.Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[3];
                objParams[0] = new SqlParameter("@IdOrdineTest", LastIdOrdine);
                objParams[1] = new SqlParameter("@Utente", UserLog.UserName);
                objParams[2] = new SqlParameter("@DaFatt", "1");
                objSqlHelper.ExecuteNonQuery("U_I_King_BollaDaOrdine_Insert", objParams);
            }
            if (daContr > 0)
            {
                MembershipUser UserLog = Membership.GetUser();
                AppCode.Sql4Gestionale objSqlHelper = new AppCode.Sql4Gestionale();
                SqlParameter[] objParams = new SqlParameter[3];
                objParams[0] = new SqlParameter("@IdOrdineTest", LastIdOrdine);
                objParams[1] = new SqlParameter("@Utente", UserLog.UserName);
                objParams[2] = new SqlParameter("@DaFatt", "0");
                objSqlHelper.ExecuteNonQuery("U_I_King_BollaDaOrdine_Insert", objParams);
            }

            Articoli_Dts.DataBind();
        }
        public int GetBancli_BYCodCli(string CodCli)
        {
            int CodBan = 0;
            //SqlParameter[] parameters = new SqlParameter[] {
            //    new SqlParameter("@CodCli",CodCli)
            //};
            string SqlString = "SELECT IDBan FROM BancheCli  WHERE CodCli = '" + CodCli + "' AND Preferenziale <> 0";
            using (SqlConnection myConnection2 = new SqlConnection())
            {
                myConnection2.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand2 = new SqlCommand
                {
                    Connection = myConnection2,
                    CommandText = SqlString
                };
                myConnection2.Open();
#pragma warning disable CS0219 // La variabile 'retVal2' è assegnata, ma il suo valore non viene mai usato
                bool retVal2 = false;
#pragma warning restore CS0219 // La variabile 'retVal2' è assegnata, ma il suo valore non viene mai usato

                SqlDataReader myReader2 = myCommand2.ExecuteReader();
                if (!myReader2.HasRows)
                { retVal2 = false; }

                else
                {
                    while (myReader2.Read())
                    {

                        CodBan = Convert.ToInt32(myReader2["IDBan"].ToString());

                    }
                }
                myReader2.Close();
                myConnection2.Close();
            }
            return CodBan;
        }
        private string UpdateLastIdProtocollo()
        {
            string SqlString = " SELECT  Ultimo FROM  Protocolli  WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
#pragma warning restore CS0219 // La variabile 'UMFinale' è assegnata, ma il suo valore non viene mai usato
            int LastID = 0;
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand
                {
                    Connection = myConnection,
                    CommandText = SqlString
                };
                myConnection.Open();


                SqlDataReader myReader = myCommand.ExecuteReader();

                while (myReader.Read())
                {
                    LastID = Convert.ToInt32(myReader["Ultimo"].ToString());

                }

                myReader.Close();
                myConnection.Close();
            }

            _ = new Portal4Set_SA();
            LastID++;
            string updateCommand = " UPDATE [Protocolli] set [Ultimo] = " + LastID + " WHERE TipoDoc = 'OC' AND Protocollo = 'O' ";
            string LastIDString = Convert.ToString(LastID);
            using (SqlConnection connection =
                   new SqlConnection(ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(updateCommand, connection);
                command.Connection.Open();
                _ = command.ExecuteNonQuery();

            }
            return LastIDString;
        }
        public static void U_OrdCliDett_Insert(int Qta, string CodArt, string UM, int IdTestata, string RifIvaCliente, string codDep, int nRiga)
        {
            SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["GestionaleConnectionString"].ConnectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("U_I_OrdCliDett_Insert_Tmp", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@CodArt" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@UM" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@QtaOrd" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@Prezzo" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@Importo" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@Note" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@IdTestata" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@NRiga" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@QtaAnag" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@U_Confez_Intra" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@Sconto" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@PrevCons" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@RifIva" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@NumDec" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@u_pz_lordo" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@U_Sc1" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@U_Sc2" });
            cmd.Parameters.Add(new SqlParameter() { ParameterName = "@CodDep" });

            int rowCounter = 0;
            rowCounter++;
            cmd.Parameters["@CodArt"].Value = CodArt;
            cmd.Parameters["@UM"].Value = UM;
            cmd.Parameters["@QtaOrd"].Value = (float)Qta;
            cmd.Parameters["@Prezzo"].Value = (float)0;
            cmd.Parameters["@Importo"].Value = (float)0;
            cmd.Parameters["@Note"].Value = string.Empty;
            cmd.Parameters["@IdTestata"].Value = IdTestata;
            cmd.Parameters["@NRiga"].Value = nRiga;
            cmd.Parameters["@QtaAnag"].Value = Qta;
            cmd.Parameters["@U_Confez_Intra"].Value = string.Empty;
            cmd.Parameters["@Sconto"].Value = string.Empty;
            cmd.Parameters["@PrevCons"].Value = DateTime.Now;
            cmd.Parameters["@RifIva"].Value = RifIvaCliente;
            cmd.Parameters["@NumDec"].Value = string.Empty;
            cmd.Parameters["@u_pz_lordo"].Value = string.Empty;
            cmd.Parameters["@U_Sc1"].Value = string.Empty;
            cmd.Parameters["@U_Sc2"].Value = string.Empty;
            cmd.Parameters["@CodDep"].Value = codDep;

            cmd.ExecuteNonQuery();


            cnn.Close();
        }

        protected void Articoli_Gridview_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int qta = Convert.ToInt32(e.NewValues["Qta_Eff"]);
            object CodArt = e.Keys[0];
            string CodArtS = CodArt.ToString();
            new AppCode.Sql4Gestionale().ExecuteNonQuery(string.Format("UPDATE U_Inventario_Deposito SET Qta_Eff = {2} WHERE CodArt = '{0}' AND CodDep = '{1}'", CodArtS, Session["CodDep_Session"] as string, qta));
            Testata_Dts.DataBind();
        }

        protected void ShopRedirect_CallBack_Callback(object source, CallbackEventArgs e)
        {
            string Parametro = Generic_Gridview.GetRowValues( Convert.ToInt32(e.Parameter), "CodDep").ToString();        
            string pattern = @"^[A-Z]\d{3}$";
            Regex regex = new Regex(pattern);
            if (regex.IsMatch(Parametro))
            {
                KING_CRUD insert = new KING_CRUD
                {
                    CodDep = Parametro,
                    UtenteApertura = HttpContext.Current.User.Identity.Name,
                };
                insert.CodDep = Parametro;
                insert.UtenteApertura = HttpContext.Current.User.Identity.Name;

                SqlDataReader reader = new AppCode.Sql4Gestionale().ExecuteReader("SELECT TabDep.U_Token, Clienti.Denom, TabDep.U_UltimoControllo_Inventario FROM TabDep INNER JOIN Clienti ON TabDep.CodCli = Clienti.CodCli WHERE CodDep = (@CodDep)", new SqlParameter() { ParameterName = "@CodDep", Value = insert.CodDep });
                if (reader.Read())
                {
                    HttpCookie CodDep_cookie = HttpContext.Current.Request.Cookies["CodDep"];
                    if (CodDep_cookie != null /*&& CodCLiDett_cookie != null*/)
                    {
                        PRT_Cookie_Crud_23.RewriteCoockies("CodDep", insert.CodDep, "Dep_Denom", reader["Denom"] as string, "U_Token", reader["U_Token"] != null ? reader["U_Token"].ToString() : null, "Action_Giornata", null);
                    }
                    else
                    {
                        CodDep_cookie = new HttpCookie("CodDep");
                        CodDep_cookie.Values.Add("CodDep", insert.CodDep);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        CodDep_cookie = new HttpCookie("Dep_Denom");
                        CodDep_cookie.Values.Add("Dep_Denom", reader["Denom"] as string);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        string s = reader["U_Token"] != null ? reader["U_Token"].ToString() : null;
                        CodDep_cookie = new HttpCookie("U_Token");
                        CodDep_cookie.Values.Add("U_Token", s);
                        CodDep_cookie.Expires = DateTime.MaxValue;
                        Response.Cookies.Add(CodDep_cookie);

                        CodDep_cookie = new HttpCookie("Action_Giornata");
                        CodDep_cookie.Values.Add("Action_Giornata", null);
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
                    ASPxWebControl.RedirectOnCallback("/ShopRM/default.aspx");
                }
            }
        }
    }
}