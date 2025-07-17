using Microsoft.Exchange.WebServices.Data;
using System;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Web;

namespace INTRA.AppCode
{
    public class Exchange
    {
        string Dominio = ConfigurationManager.AppSettings["Dominio"];
        string LinkExchange = ConfigurationManager.AppSettings["LinkExchange"];
        string ExchangeUrlBase = ConfigurationManager.AppSettings["ExchangeUrlBase"];

        #region Proprietà
        public string Oggetto { get; set; }
        public string Luogo { get; set; }
        public DateTime DataInizio { get; set; }
        public DateTime DataFine { get; set; }
        public TimeSpan OraInizio { get; set; }
        public TimeSpan OraFine { get; set; }
        public string Note { get; set; }
        public bool Tuttalagiornata { get; set; }
        #endregion

        public void Exchange_Connect(Exchange Dati)
        {
            var MyProfile = HttpContext.Current.Profile;

            Uri serverURI = new Uri(LinkExchange);
            ExchangeService service = new ExchangeService();
            service.Url = serverURI;
            service.UseDefaultCredentials = false;
            service.Credentials = new System.Net.NetworkCredential(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString(), Dominio);
            //Trust all certificates
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true);

            // trust sender
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, cert, chain, errors) => cert.Subject.Contains(ExchangeUrlBase));

            // validate cert by calling a function
            ServicePointManager.ServerCertificateValidationCallback += new RemoteCertificateValidationCallback(ValidateRemoteCertificate);

            Microsoft.Exchange.WebServices.Data.Appointment appointment = new Microsoft.Exchange.WebServices.Data.Appointment(service);
            appointment.Subject = Oggetto;
            appointment.Body = Note;
            appointment.Location = Luogo;
            appointment.Start = Convert.ToDateTime(DataInizio.ToShortDateString()).Add(OraInizio);
            appointment.End = Convert.ToDateTime(DataFine.ToShortDateString()).Add(OraFine);
            appointment.LegacyFreeBusyStatus = LegacyFreeBusyStatus.Busy;
            if (Tuttalagiornata)
            {
                appointment.IsAllDayEvent = true;
            }
            CalendarFolder folder = FindDefaultCalendarFolder(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString());
            appointment.Save(folder.Id, SendInvitationsMode.SendToNone);
            string id = appointment.Id.UniqueId;
        }
        public void ExchangeTasks_Connect(Exchange Dati)
        {
            var MyProfile = HttpContext.Current.Profile;

            Uri serverURI = new Uri(LinkExchange);
            //ExchangeService service = new ExchangeService();
            //service.Url = serverURI;
            //service.UseDefaultCredentials = false;
            //service.Credentials = new System.Net.NetworkCredential(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString(), Dominio);


            ExchangeService service = new ExchangeService();
            service.Url = serverURI;
            service.UseDefaultCredentials = false;
            service.Credentials = new System.Net.NetworkCredential(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString(), Dominio);
            //Trust all certificates
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true);

            // trust sender
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, cert, chain, errors) => cert.Subject.Contains(ExchangeUrlBase));

            // validate cert by calling a function
            ServicePointManager.ServerCertificateValidationCallback += new RemoteCertificateValidationCallback(ValidateRemoteCertificate);

            //see #1
            // exchange.ImpersonatedUserId = new ImpersonatedUserId(ConnectingIdType.SmtpAddress, ImpersonatedUser@domain.com");

            var task = new Task(service);
            task.Subject = Oggetto;
            task.Body = new MessageBody(Note);
            task.Status = TaskStatus.InProgress;
            task.StartDate = Convert.ToDateTime(DataInizio.ToShortDateString()).Add(OraInizio);
            task.DueDate = Convert.ToDateTime(DataFine.ToShortDateString()).Add(OraFine);
            task.IsReminderSet = true;
            TimeSpan MinutiDiAnticipo = TimeSpan.FromHours(0.50);
            task.ReminderDueBy = Convert.ToDateTime(DataInizio.ToShortDateString()).Add(OraInizio.Subtract(MinutiDiAnticipo));
            //task.ReminderMinutesBeforeStart = 15;
            TasksFolder folder = FindDefaultTaskFolder(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString());
            task.Save(folder.Id);
            //task.Save();
            string id = task.Id.UniqueId;

        }

        public CalendarFolder FindDefaultCalendarFolder(string NomeUser, string Password)
        {
            Uri serverURI = new Uri(LinkExchange);
            ExchangeService service = new ExchangeService();
            service.Url = serverURI;
            service.UseDefaultCredentials = false;
            service.Credentials = new System.Net.NetworkCredential(NomeUser, Password, Dominio);
            return CalendarFolder.Bind(service, WellKnownFolderName.Calendar, new PropertySet());
        }


        public TasksFolder FindDefaultTaskFolder(string NomeUser, string Password)
        {
            Uri serverURI = new Uri(LinkExchange);
            ExchangeService service = new ExchangeService();
            service.Url = serverURI;
            service.UseDefaultCredentials = false;
            service.Credentials = new System.Net.NetworkCredential(NomeUser, Password, Dominio);
            return TasksFolder.Bind(service, WellKnownFolderName.Tasks, new PropertySet());
        }

        public void EliminaAppuntamento(string IDAppuntamento)
        {
            var MyProfile = HttpContext.Current.Profile;
            Uri serverURI = new Uri(LinkExchange);
            ExchangeService service = new ExchangeService();
            service.Url = serverURI;
            service.UseDefaultCredentials = false;
            service.Credentials = new System.Net.NetworkCredential(MyProfile.GetPropertyValue("ExchangeUser").ToString(), MyProfile.GetPropertyValue("ExchangePsw").ToString(), Dominio);
            //Trust all certificates
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true);

            // trust sender
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, cert, chain, errors) => cert.Subject.Contains(ExchangeUrlBase));

            // validate cert by calling a function
            ServicePointManager.ServerCertificateValidationCallback += new RemoteCertificateValidationCallback(ValidateRemoteCertificate);
            // Instantiate an appointment object by binding to it by using the ItemId.
            // As a best practice, limit the properties returned to only the ones you need.
            Appointment appointment = Appointment.Bind(service, IDAppuntamento, new PropertySet());
            // Delete the appointment. Note that the item ID will change when the item is moved to the Deleted Items folder.
            appointment.Delete(DeleteMode.MoveToDeletedItems);
            // Verify that the appointment has been deleted by looking for a matching subject in the Deleted Items folder's first entry.
            ItemView itemView = new ItemView(1);
            itemView.Traversal = ItemTraversal.Shallow;
            // Just retrieve the properties you need.
            itemView.PropertySet = new PropertySet(ItemSchema.Id, ItemSchema.ParentFolderId, ItemSchema.Subject);
            // Note that the FindItems method results in a call to EWS.
            FindItemsResults<Item> deletedItems = service.FindItems(WellKnownFolderName.DeletedItems, itemView);
            Item deletedItem = deletedItems.First();
            Folder parentFolder = Folder.Bind(service, deletedItem.ParentFolderId, new PropertySet(FolderSchema.DisplayName));


        }

        //private static bool, cambiato perchè non mi faceva inserire la variabile ExchangeUrlBase, quindi avrei dovuto scriverlo a mano
        private bool ValidateRemoteCertificate(object sender, X509Certificate cert, X509Chain chain, SslPolicyErrors policyErrors)
        {
            bool result = false;
            if (cert.Subject.ToUpper().Replace("CN=", string.Empty).Contains(ExchangeUrlBase.ToUpper()))
            {
                result = true;
            }

            return result;
        }
    }
}