using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Web;

namespace INTRA.ShopRM.AppCode
{
    public class ShopRM_FunzioniGenerali_23
    {
        //public static string ConfermaOrdine_MailBodyCreate(int IDOrdine, Order MyOrder, List<CartItem> MyOrderItems, string CodCli)
        //{
        //    System.Security.Principal.IPrincipal User = HttpContext.Current.User;
        //    ClientiCat_Crud cliente = ClientiCat_Crud.GetClientDatiSpedizione(CodCli);
        //    CAT CatData = new CAT_CRUD()[User.Identity.Name];
        //    string EmailBody = string.Empty;
        //    EmailBody += "Data: " + DateTime.Now.ToString() + "<br/>";
        //    EmailBody += "Ordine presso Miele Service Partner " + CatData.RagSoc + "<br/>";
        //    EmailBody += "Ordine N°: " + IDOrdine + "<br/></b>";
        //    EmailBody += "<br />";
        //    EmailBody += "<span ><b>Dati destinazione beni</b></span>";
        //    EmailBody += "<br />";
        //    EmailBody += "<div style='padding-bottom:10px;'><div style='border:solid 1px black;width:100%;heigth:1rem;'></div>";
        //    EmailBody += $"<span style='width:100%'>{cliente.NomeCompleto} -- {cliente.Ind} {cliente.Cap} / {cliente.Loc} {cliente.Prov}</span>";
        //    EmailBody += "<div style='padding-top:10px;'></div><div style='border:solid 1px black;width:100%;heigth:1rem;'></div>";
        //    EmailBody += "<br />";
        //    EmailBody += "<br><br><span><b>Dettaglio Ordine</b></span>";
        //    EmailBody += "<table border='1' cellpadding='3' width='100%'";
        //    EmailBody += "style='border-collapse:collapse'>";
        //    EmailBody += "<tr style='background-color:#F0F0F0'>";
        //    EmailBody += "  <th>codice</th>";
        //    EmailBody += "  <th>descrizione</th>";
        //    EmailBody += "  <th>Qta</th>";
        //    EmailBody += "  <th>prezzo</th>";
        //    EmailBody += "  <th>subtotale</th>";
        //    EmailBody += "</tr>";
        //    Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
        //    decimal OrderAmount = 0;
        //    int i;
        //    for (i = 0; i <= MyOrderItems.Count - 1; i++)
        //    {

        //        OrderAmount += MyOrderItems[i].Quantity * MyOrderItems[i].ItemPrice;
        //        EmailBody += "<tr>";
        //        EmailBody += "  <td>" + MyOrderItems[i].MenuItemID + "</td>";
        //        EmailBody += "  <td>" + MyOrderItems[i].ItemName + "</td>";
        //        EmailBody += "  <td style='text-align:right'>" + MyOrderItems[i].Quantity + "  </td>";
        //        EmailBody += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].ItemPrice * 100) / 100).ToString("N2") + "  </td>";
        //        EmailBody += "  <td style='text-align:right'>" + (Math.Round(MyOrderItems[i].Quantity * MyOrderItems[i].ItemPrice * 100) / 100).ToString("N2") + " </td>";
        //        EmailBody += "</tr>";
        //    }
        //    EmailBody += "<tr>";
        //    EmailBody += "	<td colspan='4' style='text-align:right'>" + "Totale Euro" + "</td>";
        //    EmailBody += "	<td style='text-align:right'>" + (Math.Round(OrderAmount * 100) / 100).ToString("N2") + "</td>";
        //    EmailBody += "</tr>";
        //    EmailBody += "</table>";
        //    EmailBody += string.Empty;
        //    SHP_PRT_Setting PortalConfig = new SHP_PRT_Setting();
        //    string MsgConsegna = PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.MsgConsegna).ToString();
        //    if (!Convert.ToBoolean(PortalConfig.GetConfigurationValue(SHP_PRT_Setting.Settings.AbilitaMsgConsegna)))
        //    {
        //        MsgConsegna = string.Empty;
        //    }
        //    string Companymail = CatData.EMail;
        //    string CompanyTel = CatData.NumTel;
        //    string Company = CatData.RagSoc;
        //    string NoteCustomerVisibility = string.IsNullOrEmpty(MyOrder.NoteCustomer) ? "none" : "inherit";
        //    string br = string.IsNullOrEmpty(MyOrder.NoteCustomer) ? " " : "<br>";
        //    string CloseBr = string.IsNullOrEmpty(MyOrder.NoteCustomer) ? " " : "</br>";
        //    EmailBody += $"</br>{br}<span Style='color:rgb(23, 162, 184);display:{NoteCustomerVisibility}'><b>Note cliente: </b>{MyOrder.NoteCustomer}</span>";
        //    EmailBody += $"{CloseBr}<br><span Style='color:red'><b>" + MsgConsegna + "</b></span>";
        //    EmailBody += "<br><br>Se ha domande sull'ordine, è pregato di inviare una e-mail all'indirizzo <a href='mailto:";
        //    EmailBody += Companymail + "' >" + Companymail + "</a> riportando il numero d'ordine di cui sopra.<br>";
        //    EmailBody += $"<br><br> Per info chiamare {Company} al numero {CompanyTel}</p>";
        //    EmailBody += "<p>Grazie per la fiducia accordataci. <br>";
        //    EmailBody += "<p>Staff " + Company + " <br>";
        //    EmailBody += "</br>" + CreateFooterForOrderBody(CatData);
        //    return EmailBody;
        //}



        //public static string CreateFooterForOrderBody()
        //{
        //    string Company = CatDett.RagSoc;
        //    string CompanyAddress = CatDett.SedeLeg;
        //    string CompanyCity = CatDett.Local;
        //    string CompanyProvince = CatDett.Prov;
        //    string Piva = CatDett.PIva;
        //    string CompanyFooter = string.Format("{0} - {1} - {2} ({3}) / PIva : {4}", Company, CompanyAddress, CompanyCity, CompanyProvince, Piva);
        //    return CompanyFooter;
        //}


        public static string SetPasswordCliente_CreateBodyEmail(ClientiCat_Crud cliente)
        {
            string EmailBody = string.Empty;

            return EmailBody;
        }
    }
}