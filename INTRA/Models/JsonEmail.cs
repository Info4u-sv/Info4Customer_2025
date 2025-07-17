namespace WebService4u.Models
{
    public class JsonEmail
    {
        public JsonEmail() { }
        public string from { get; set; }
        public string to { get; set; }
        public string OggettoMail { get; set; }
        public string CodParametroTemplate { get; set; }
        public object ArrayParam { get; set; }

    }
}