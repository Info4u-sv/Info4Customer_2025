using System.Collections.Generic;
using System.Linq;

namespace WebService4u.Models
{
    public class JSONOfferteKingStat_Group_AnnoMese
    {
        public int Anno { get; set; } = 0;
        public int TotaleAnno { get; set; } = 0;
        public int Gennaio { get; set; } = 0;
        public int Febbraio { get; set; } = 0;
        public int Marzo { get; set; } = 0;
        public int Aprile { get; set; } = 0;
        public int Maggio { get; set; } = 0;
        public int Giugno { get; set; } = 0;
        public int Luglio { get; set; } = 0;
        public int Agosto { get; set; } = 0;
        public int Settembre { get; set; } = 0;
        public int Ottobre { get; set; } = 0;
        public int Novembre { get; set; } = 0;
        public int Dicembre { get; set; } = 0;

        public static List<JSONOfferteKingStat_Group_AnnoMese> GetGroupedList_AnnoMese(int Anno, string DocType)
        {
            List<JsonOfferteKingStat> stats = JsonOfferteKingStat.GetJsonOfferteKingStats_List(DocType);
            if (Anno > 1900)
            {
                stats = stats.Where(x => x.Anno == Anno).ToList();
            }
            List<JSONOfferteKingStat_Group_AnnoMese> GroupedList = new List<JSONOfferteKingStat_Group_AnnoMese>();
            int Anno_var = 0;
            JSONOfferteKingStat_Group_AnnoMese ObjdET = null;
            foreach (JsonOfferteKingStat obj in stats)
            {
                if (Anno_var == 0)
                {
                    ObjdET = new JSONOfferteKingStat_Group_AnnoMese();
                    Anno_var = obj.Anno;
                    ObjdET.Anno = obj.Anno;
                }
                if (Anno_var != obj.Anno)
                {
                    GroupedList.Add(ObjdET);
                    Anno_var = obj.Anno;
                    ObjdET = new JSONOfferteKingStat_Group_AnnoMese();
                    ObjdET.Anno = obj.Anno;
                }
                //else
                //{
                ObjdET.TotaleAnno += obj.TotOfferte;
                switch (obj.Mese)
                {
                    case 1:
                        ObjdET.Gennaio = obj.TotOfferte;
                        break;
                    case 2:
                        ObjdET.Febbraio = obj.TotOfferte;
                        break;
                    case 3:
                        ObjdET.Marzo = obj.TotOfferte;
                        break;
                    case 4:
                        ObjdET.Aprile = obj.TotOfferte;
                        break;
                    case 5:
                        ObjdET.Maggio = obj.TotOfferte;
                        break;
                    case 6:
                        ObjdET.Giugno = obj.TotOfferte;
                        break;
                    case 7:
                        ObjdET.Luglio = obj.TotOfferte;
                        break;
                    case 8:
                        ObjdET.Agosto = obj.TotOfferte;
                        break;
                    case 9:
                        ObjdET.Settembre = obj.TotOfferte;
                        break;
                    case 10:
                        ObjdET.Ottobre = obj.TotOfferte;
                        break;
                    case 11:
                        ObjdET.Novembre = obj.TotOfferte;
                        break;
                    case 12:
                        ObjdET.Dicembre = obj.TotOfferte;
                        break;
                }
                //}
                if (stats.Last().Equals(obj))
                {
                    GroupedList.Add(ObjdET);
                }
            }
            return GroupedList;

        }
    }
}