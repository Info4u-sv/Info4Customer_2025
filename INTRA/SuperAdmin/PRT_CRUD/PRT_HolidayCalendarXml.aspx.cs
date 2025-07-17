using INTRA.AppCode;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace INTRA.SuperAdmin.PRT_CRUD
{
    public partial class PRT_HolidayCalendarXml : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PRT_ParameterCalendar _obj = new PRT_ParameterCalendar();
                YearStart_Txt.Text = _obj.GetValue_ParameterCalendarByCode("YearStart");
                YearEnd_Txt.Text = _obj.GetValue_ParameterCalendarByCode("YearEnd");
            }
        }

        protected void SalvaXml_Click(object sender, EventArgs e)
        {
            XmlDocument MyXmlDocument = new XmlDocument();
            MyXmlDocument.Load(Server.MapPath("~/App_Data/PRT_holidays.xml"));
            XmlNodeList nodes = MyXmlDocument.SelectNodes("//Holiday[@Location='Italy']");
            foreach (XmlNode userNode in nodes)
            {
                XmlNode parent = userNode.ParentNode;
                parent.RemoveChild(userNode);
            }
            // verify the new XML structure
            string newXML = MyXmlDocument.OuterXml;
            MyXmlDocument.Save(Server.MapPath("~/App_Data/PRT_holidays.xml"));

            MyXmlDocument.Load(Server.MapPath("~/App_Data/PRT_holidays.xml"));

            string SqlString = "SELECT * FROM [PRT_HolidayCalendar]";
            List<PRT_HolidayCalendar> _listFestivita = new List<PRT_HolidayCalendar>();
            using (SqlConnection myConnection = new SqlConnection())
            {
                myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["info4portaleConnectionString"].ConnectionString;
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = myConnection;
                myCommand.CommandText = SqlString;
                myConnection.Open();
            
                SqlDataReader myReader = myCommand.ExecuteReader();
                if (myReader.HasRows)
                {
                    while (myReader.Read())
                    {
                        PRT_HolidayCalendar _obj = new PRT_HolidayCalendar();
                        _obj.DataFestivita = myReader["DataFestivita"].ToString();
                        _obj.Descrizione = myReader["Descrizione"].ToString();
                        _listFestivita.Add(_obj);
                    }
                }
                myReader.Close();
                myConnection.Close();
            }

            for (int i = Convert.ToInt32(YearStart_Txt.Text); i <= Convert.ToInt32(YearEnd_Txt.Text); i++)
            {
                foreach (PRT_HolidayCalendar LocalListElement in _listFestivita)
                {
                    XmlElement ParentElement = MyXmlDocument.CreateElement("Holiday");
                    ParentElement.SetAttribute("Location", "Italy");
                    ParentElement.SetAttribute("DisplayName", LocalListElement.Descrizione);
                    ParentElement.SetAttribute("Date", LocalListElement.DataFestivita + "/"+ i +" 00:00:00");
                    ParentElement.SetAttribute("Year", i.ToString());
                    MyXmlDocument.DocumentElement.AppendChild(ParentElement);
                }
                List<PRT_HolidayCalendar> _listPasqua = new List<PRT_HolidayCalendar>();
                PRT_HolidayCalendar _Obj = new PRT_HolidayCalendar();
                _listPasqua = _Obj.GetPasquaPasquettaPerAnno(i);
                foreach (PRT_HolidayCalendar LocalListElement in _listPasqua)
                {
                    XmlElement ParentElement = MyXmlDocument.CreateElement("Holiday");
                    ParentElement.SetAttribute("Location", "Italy");
                    ParentElement.SetAttribute("DisplayName", LocalListElement.Descrizione);
                    ParentElement.SetAttribute("Date", LocalListElement.DataFestivita);
                    ParentElement.SetAttribute("Year", i.ToString());
                    MyXmlDocument.DocumentElement.AppendChild(ParentElement);
                }

            }


            //XmlElement ParentElement = MyXmlDocument.CreateElement("Holiday");
            //    ParentElement.SetAttribute("Location", "Italy");
            //    ParentElement.SetAttribute("DisplayName", "Natale");
            //    ParentElement.SetAttribute("Date", "25/12/2022 00:00:00");
            //    MyXmlDocument.DocumentElement.AppendChild(ParentElement);
                MyXmlDocument.Save(Server.MapPath("~/App_Data/PRT_holidays.xml"));
            }
        }
    }