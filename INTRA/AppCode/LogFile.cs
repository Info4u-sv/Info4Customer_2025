using System;
/// <summary>
/// Descrizione di riepilogo per PRT_Documenti
/// </summary>
public class LogFile
{
    public LogFile()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }

    private string sLogFormat;
    private string DataEliminazione;
    private string sErrorTime;

    public void CreateLogFiles()
    {
        //sLogFormat used to create log files format :
        // dd/mm/yyyy hh:mm:ss AM/PM ==> Log Message
        sLogFormat = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString() + " ==> ";
        DataEliminazione = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString();
        //this variable used to create log filename format "
        //for example filename : ErrorLogYYYYMMDD
        string sYear = DateTime.Now.Year.ToString();
        string sMonth = DateTime.Now.Month.ToString();
        string sDay = DateTime.Now.Day.ToString();
        sErrorTime = sYear + sMonth + sDay;
    }
    public void ErrorLog(string LogFilePath, string sErrMsg)
    {
        //CreateLogFiles();
        //sErrMsg = sErrMsg + " <=== ";
        //StreamWriter sw = new StreamWriter(LogFilePath + ".txt", true);
        //sw.WriteLine(sLogFormat + sErrMsg);
        //sw.Flush();
        //sw.Close();
    }
}