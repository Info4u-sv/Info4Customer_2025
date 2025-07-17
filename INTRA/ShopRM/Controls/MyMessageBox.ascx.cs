using System;

namespace INTRA.ShopRM.Controls
{
    public partial class MyMessageBox : System.Web.UI.UserControl
    {
        #region Properties
        public bool ShowCloseButton { get; set; }
        public bool ShowStaticMsg { get; set; }
        public string ShowStaticType { get; set; }
        public string ShowStaticMessageTxt { get; set; }
        #endregion

        #region Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ShowStaticMsg)
            {
                switch (ShowStaticType)
                {
                    case "Error":
                        Show(MessageType.Error, ShowStaticMessageTxt);
                        break;
                    case "Info":
                        Show(MessageType.Info, ShowStaticMessageTxt);
                        break;
                    case "Success":
                        Show(MessageType.Success, ShowStaticMessageTxt);
                        break;
                    case "Warning":
                        Show(MessageType.Warning, ShowStaticMessageTxt);
                        break;
                    default:
                        Show(MessageType.Error, "Errore");
                        break;
                }
            }
            //if (ShowCloseButton)
            //    CloseButton.Attributes.Add("onclick", "document.getElementById('" + MessageBox.ClientID + "').style.display = 'none'");
        }
        #endregion

        #region Wrapper methods
        public void ShowError(string message)
        {
            Show(MessageType.Error, message);
        }

        public void ShowInfo(string message)
        {
            Show(MessageType.Info, message);
        }

        public void ShowSuccess(string message)
        {
            Show(MessageType.Success, message);
        }

        public void ShowWarning(string message)
        {
            Show(MessageType.Warning, message);
        }
        #endregion

        #region Show control
        public void Show(MessageType messageType, string message)
        {
            //CloseButton.Visible = ShowCloseButton;
            litMessage.Text = message;

            MessageBox.CssClass = messageType.ToString().ToLower();
            Visible = true;
        }
        #endregion

        #region Enum
        public enum MessageType
        {
            Error = 1,
            Info = 2,
            Success = 3,
            Warning = 4
        }
        #endregion
    }
}