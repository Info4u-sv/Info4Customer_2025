using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
/// <summary>
/// Summary description for Appointment
/// </summary>
public class AppointmentInvio
{
    private StreamWriter writer = null;
    public AppointmentInvio()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string GetFormatedDate(DateTime date)
    {
        string YY = date.Year.ToString();
        string MM = string.Empty;
        string DD = string.Empty;
        if (date.Month < 10) MM = "0" + date.Month.ToString();
        else MM = date.Month.ToString();
        if (date.Day < 10) DD = "0" + date.Day.ToString();
        else DD = date.Day.ToString();
        return YY + MM + DD;
    }
    public string GetFormattedTime(string time)
    {
        string[] times = time.Split(':');
        string HH = string.Empty;
        string MM = string.Empty;
        if (Convert.ToInt32(times[0]) < 10) HH = "0" + times[0];
        else HH = times[0];
        if (Convert.ToInt32(times[1]) < 10) MM = "0" + times[0];
        else MM = times[1];
        return HH + MM + "00Z";

    }
    public string MakeDayEvent(string subject, string location, DateTime startDate, DateTime endDate, string description)
    {
        // per rimuovere carriage return and new-line
        Regex re = new Regex("\r\n$");

        string filePath = string.Empty;
        string path = HttpContext.Current.Server.MapPath(@"\iCal\");
        filePath = path + subject + ".ics";
        writer = new StreamWriter(filePath);
        writer.WriteLine("BEGIN:VCALENDAR");
        writer.WriteLine("VERSION:2.0");
        writer.WriteLine("PRODID:-//hacksw/handcal//NONSGML v1.0//EN");
        writer.WriteLine("BEGIN:VEVENT");


        string startDay = "VALUE=DATE:" + GetFormatedDate(startDate);
        string endDay = "VALUE=DATE:" + GetFormatedDate(endDate);
        writer.WriteLine("TZID=Europe/Rome;");
        writer.WriteLine("DTSTART;" + startDay);
        writer.WriteLine("DTEND;" + endDay);
        writer.WriteLine("SUMMARY:" + re.Replace(subject, " "));
        writer.WriteLine("LOCATION:" + re.Replace(location, " "));
        writer.WriteLine("DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" + re.Replace(description, " "));
        writer.WriteLine("END:VEVENT");
        writer.WriteLine("END:VCALENDAR");
        writer.Close();

        return filePath;
    }
    public MemoryStream MakeHourEvent(string subject, string location, DateTime date, string startDateTime, string endDateTime, string description)
    {
        //string filePath = string.Empty;
        //string path = HttpContext.Current.Server.MapPath(@"\iCal\");
        // per rimuovere carriage return and new-line
        Regex re = new Regex("\r\n$");

        string replaceWith = " ";

        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        System.IO.StreamWriter writer = new System.IO.StreamWriter(stream);
        //filePath = path + subject + ".ics";
        //writer = new StreamWriter(filePath);

        writer.WriteLine("BEGIN:VCALENDAR");
        writer.WriteLine("VERSION:2.0");
        writer.WriteLine("PRODID:-//hacksw/handcal//NONSGML v1.0//EN");
        writer.WriteLine("BEGIN:VEVENT");
        //writer.WriteLine("TZID=Europe/Rome;");
        //string startDateTime = GetFormatedDate(date)+"T"+GetFormattedTime(startTime);
        //string endDateTime = GetFormatedDate(date) + "T" + GetFormattedTime(endTime);

        writer.WriteLine("DTSTART:" + startDateTime);
        writer.WriteLine("DTEND:" + endDateTime);
        writer.WriteLine("SUMMARY:" + re.Replace(subject, " "));
        writer.WriteLine("LOCATION:" + re.Replace(location, " "));
        writer.WriteLine("DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" + description.Replace("\r\n", replaceWith).Replace("\n", replaceWith).Replace("\r", replaceWith));
        writer.WriteLine("END:VEVENT");
        writer.WriteLine("END:VCALENDAR");

        writer.Flush();
        stream.Position = 0;


        //writer.Write("Hello its my sample file");


        //System.Net.Mime.ContentType ct = new System.Net.Mime.ContentType(System.Net.Mime.MediaTypeNames.Text.Plain);
        //System.Net.Mail.Attachment attach = new System.Net.Mail.Attachment(ms, ct);
        //attach.ContentDisposition.FileName = "myFile.ics";

        //// I guess you know how to send email with an attachment
        //// after sending email
        //ms.Close();

        return stream;

    }
}