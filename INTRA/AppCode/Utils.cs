using DevExpress.Web;
using DevExpress.Web.Internal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Xml.Linq;

public static class Utils
{

    static bool? _isSiteMode;
    static List<NavigationItem> _navigationItems;
    static object lockObject = new object();
    static Thread backgroundThread;

    static HttpContext Context { get { return HttpContext.Current; } }
    static string UploadImagesFolder { get { return Context.Server.MapPath("~/Content/Photo/UploadImages/"); } }

    public static bool IsIE7 { get { return RenderUtils.Browser.IsIE && RenderUtils.Browser.Version < 8; } }
    public static bool IsSiteMode
    {
        get
        {
            if (!_isSiteMode.HasValue)
                _isSiteMode = ConfigurationManager.AppSettings["SiteMode"].Equals("true", StringComparison.InvariantCultureIgnoreCase);
            return _isSiteMode.Value;
        }
    }

    public static void ApplyTheme(Page page)
    {
        var themeName = CurrentTheme;
        if (string.IsNullOrEmpty(themeName))
            themeName = "Default";
        page.Theme = themeName;
    }

    public static string CurrentTheme
    {
        get
        {
            var themeCookie = Context.Request.Cookies["MailDemoCurrentTheme"];
            return themeCookie == null ? "Office365" : HttpUtility.UrlDecode(themeCookie.Value);
        }
    }

    public static bool IsDarkTheme
    {
        get
        {
            var theme = CurrentTheme;
            return theme == "Office2010Black" || theme == "PlasticBlue" || theme == "RedWine" || theme == "BlackGlass";
        }
    }

    public static string CurrentPageName
    {
        get
        {
            var key = "CE1167E3-A068-4E7C-8BFD-4A7D308BEF43";
            if (Context.Items[key] == null)
                Context.Items[key] = GetCurrentPageName();
            return Context.Items[key].ToString();
        }
    }

    public static List<NavigationItem> NavigationItems
    {
        get
        {
            if (_navigationItems == null)
            {
                _navigationItems = new List<NavigationItem>();
                PopuplateNavigationItems(_navigationItems);
            }
            return _navigationItems;
        }
    }

    public static string GetSearchText(Page page)
    {
        var key = "D672659E-FF11-40FF-A63B-FAFB0BFE760B";
        if (Context.Items[key] == null)
        {
            string value = null;
            if (!TryGetClientStateValue<string>(page, "SearchText", out value))
                value = string.Empty;
            Context.Items[key] = value;
        }
        return Context.Items[key].ToString();
    }

    public static bool TryGetClientStateValue<T>(Page page, string key, out T result)
    {
        var hiddenField = page.Master.Master.FindControl("HiddenField") as ASPxHiddenField;
        if (hiddenField == null || !hiddenField.Contains(key))
        {
            result = default(T);
            return false;
        }
        result = (T)hiddenField[key];
        return true;
    }

    public static byte[] GetContactPhotoContentBytes(string savedPath)
    {
        var path = Context.Server.MapPath(String.Format("~/Content/Photo/{0}", savedPath));
        if (!File.Exists(path))
            return null;

        byte[] byteArray = null;
        using (System.IO.FileStream stream = new System.IO.FileStream(path, System.IO.FileMode.Open, System.IO.FileAccess.Read))
        {
            byteArray = new byte[stream.Length];
            stream.Read(byteArray, 0, (int)stream.Length);
        }
        return byteArray;
    }
    public static string GetContactPhotoUrl(string relativePath)
    {
        if (string.IsNullOrEmpty(relativePath))
            return "Content/Photo/User.png";
        return "Content/Photo/" + relativePath;
    }

    public static string GetUploadedPhotoUrl(string imageKeyString)
    {
        Guid imageKey;
        if (string.IsNullOrEmpty(imageKeyString) || !Guid.TryParse(imageKeyString, out imageKey))
            return string.Empty;
        return string.Format("UploadImages/{0}.jpg", imageKey);
    }

    public static string SaveContactPhoto(byte[] newPhoto)
    {
        if (newPhoto == null)
            return string.Empty;
        var imageKey = Guid.NewGuid();
        var filePath = Path.Combine(UploadImagesFolder, imageKey.ToString() + ".jpg");

        using (var stream = new MemoryStream(newPhoto))
        {
            using (var original = (Bitmap)Image.FromStream(stream))
            using (var thumbnail = new ImageThumbnailCreator(original, ImageSizeMode.FillAndCrop).CreateImageThumbnail(new Size(200, 240)))
                ImageUtils.SaveToJpeg(thumbnail, filePath);
        }

        return string.Format("UploadImages/{0}.jpg", imageKey);
    }

    public static void StartClearExpiredFilesBackgroundThread()
    {
        lock (lockObject)
        {
            if (backgroundThread == null)
                backgroundThread = new Thread(RemoveTempFilesWorker);
            if (!backgroundThread.IsAlive)
                backgroundThread.Start(UploadImagesFolder);
        }
    }

    public static string NormalizeXmlString(string xmlContent)
    {
        if (string.IsNullOrEmpty(xmlContent))
            return string.Empty;
        var xmlString = Regex.Replace(xmlContent, @"^.*?(?=<)", string.Empty, RegexOptions.IgnorePatternWhitespace);
        return xmlString.StartsWith("<") ? xmlString : string.Empty;
    }

    static void RemoveTempFilesWorker(object startParam)
    {
        if (startParam == null)
            return;
        var directory = startParam.ToString();
        while (true)
        {
            Thread.Sleep(60000);
            RemoveExpiredTempFiles(directory);
        }
    }

    static void RemoveExpiredTempFiles(string directory)
    {
        var expirationTime = DateTime.UtcNow - new TimeSpan(0, 15, 0);
        try
        {
            foreach (var file in new DirectoryInfo(directory).GetFiles("*"))
            {
                if (file.CreationTimeUtc < expirationTime)
                    try
                    {
                        file.Delete();
                    }
                    catch { }
            }
        }
        catch { }
    }

    static void SmoothGraphics(Graphics g)
    {
        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
        g.PixelOffsetMode = PixelOffsetMode.HighQuality;
    }

    static string GetCurrentPageName()
    {
        var fileName = Path.GetFileName(Context.Request.Path);
        var result = fileName.Substring(0, fileName.Length - 5);
        if (result.ToLower() == "default")
            result = "mail";
        if (result.ToLower().Contains("print"))
            result = "print";
        return result.ToLower();
    }

    static void PopuplateNavigationItems(List<NavigationItem> list)
    {
        var path = Utils.Context.Server.MapPath("~/App_Data/Navigation.xml");
        list.AddRange(XDocument.Load(path).Descendants("Item").Select(n => new NavigationItem()
        {
            Text = n.Attribute("Text").Value,
            NavigationUrl = n.Attribute("NavigateUrl").Value,
            SpriteClassName = n.Attribute("SpriteClassName").Value
        }));
    }
    public static string GetSearchText4U(Page page)
    {
        var key = "D672659E-FF11-40FF-A63B-FAFB0BFE760B";
        if (Context.Items[key] == null)
        {
            string value = null;
            if (!TryGetClientStateValue4U<string>(page, "SearchText", out value))
                value = string.Empty;
            Context.Items[key] = value;
        }
        return Context.Items[key].ToString();
    }

    public static bool TryGetClientStateValue4U<T>(Page page, string key, out T result)
    {
        var hiddenField = page.Master.FindControl("HiddenField") as ASPxHiddenField;
        if (hiddenField == null || !hiddenField.Contains(key))
        {
            result = default(T);
            return false;
        }
        result = (T)hiddenField[key];
        return true;
    }
    public static string FormatSize(object value)
    {
        double amount = Convert.ToDouble(value);
        string unit = "KB";
        if (amount != 0)
        {
            if (amount <= 1024)
                amount = 1;
            else
                amount /= 1024;

            if (amount > 1024)
            {
                amount /= 1024;
                unit = "MB";
            }
            if (amount > 1024)
            {
                amount /= 1024;
                unit = "GB";
            }
        }
        return String.Format("{0:#,0} {1}", Math.Round(amount, MidpointRounding.AwayFromZero), unit);
    }

}

public class NavigationItem
{
    public string Text { get; set; }
    public string NavigationUrl { get; set; }
    public string SpriteClassName { get; set; }

}

