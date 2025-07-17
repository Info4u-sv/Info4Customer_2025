using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using INTRA.Age_Ordini.AppCode;
using INTRA.ShopRM.AppCode;

namespace INTRA.AppCode
{
    public class SHP_OrderBodyMail
    {

        public string CreaOrdineBodyMail(string OrderId , Ordini_Crud_v2 MyOrder, List<CartItem> MyOrderItems, bool Cliente)
        {
            string EmailBody = string.Empty;
            EmailBody += "<b>Ordine No.: " + OrderId + "<br /></b>";
            EmailBody += "Data: " + DateTime.Now.ToString() + "<br />";
            EmailBody += "Note: " + MyOrder.Note + "<br />";
            EmailBody += "<br />";
            EmailBody += "_______________________________________________________________";
            EmailBody += "<br />";
            EmailBody += "<br /><br /><span ><b>Dettaglio Ordine</b></span>";
            EmailBody += "<table border='1' cellpadding='3'";
            EmailBody += "style='border-collapse:collapse; width: 100%;'>";
            EmailBody += "<tr style='background-color:#F0F0F0'>";
            EmailBody += "  <th style='text-align:left'>Descrizione</th>";
            EmailBody += "  <th>Unità</th>";
            EmailBody += "  <th>Q.tà</th>";
            EmailBody += "  <th>Prezzo</th>";
            EmailBody += "  <th>Subtotale</th>";
            EmailBody += "</tr>";
            Thread.CurrentThread.CurrentCulture = new CultureInfo("it-IT", false);
            decimal OrderAmount = 0;
            int i = 0;
            for (i = 0; i <= MyOrderItems.Count - 1; i++)
            {
                OrderAmount += MyOrderItems[i].Quantity * MyOrderItems[i].ItemPrice;
                EmailBody += "<tr>";
                    string ScontoApplicato = string.Empty;
                    if (!string.IsNullOrEmpty(MyOrderItems[i].ScontoApplicato.ToString()))
                    {
                        ScontoApplicato = "</br><span style='Color:red'>" + MyOrderItems[i].ScontoApplicato.ToString()+ "</span>";
                    }
                    EmailBody += "  <td>" + MyOrderItems[i].ItemName + ScontoApplicato + "</td>";
                    EmailBody += "  <td style='text-align:center'>" + MyOrderItems[i].UM + "</td>";
                    EmailBody += "  <td style='text-align:center'>" + MyOrderItems[i].Quantity + "  </td>";
                    EmailBody += "  <td style='text-align:right; min-width:80px'>" + (Math.Round(MyOrderItems[i].ItemPrice * 100) / 100).ToString("C", CultureInfo.CurrentUICulture).ToString() + " </td>";
                    EmailBody += "  <td style='text-align:right; min-width:80px'>" + (Math.Round((MyOrderItems[i].Quantity * MyOrderItems[i].ItemPrice) * 100) / 100).ToString("C", CultureInfo.CurrentCulture).ToString() + " </td>";
                EmailBody += "</tr>";
            }

            if (!Cliente)
            {
                EmailBody += "<tr>";
                EmailBody += "	<td colspan='4' style='text-align:right'>" + "Spese di trasporto" + "</td>";
                EmailBody += "	<td style='text-align:right'>" + MyOrder.CostoTrasporto.ToString("C", CultureInfo.CurrentCulture).ToString() + " </td>";
                OrderAmount += Convert.ToDecimal(MyOrder.CostoTrasporto);
                EmailBody += "</tr>";
            }

            EmailBody += "<tr>";
            EmailBody += "	<td colspan='4' style='text-align:right'>" + "Totale" + "</td>";
            EmailBody += "	<td style='text-align:right'>" + OrderAmount.ToString("C", CultureInfo.CurrentCulture).ToString() + " </td>";
            EmailBody += "</tr>";
            EmailBody += "</table>";
            return EmailBody;
        }
    }
}