using info4lab.Portal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Nr_Elementi
    {
        public string Taglia { get; set; }
        public string Strato { get; set; }
        public int PostiPallet { get; set; }
        public int Nr_Elementi { get; set; }
        private static List<ITAL_Nr_Elementi> Ital_Nr_Elementi_list
        {
            get
            {
                return ITAL_Nr_Element_Get();
            }
        }

        public static int U_ValoreTaglie_Get(string Taglia, string Strati, string Posti, int CampateNum)
        {
            int _retva = 0;
            //string[] strati;
            if (Strati == string.Empty) { _retva = 0; }
            else
            {

                //string SqlString = $"SELECT sum([Nr_Elementi]) as totale FROM [ITAL_Nr_Elementi] WHERE taglia = '{Taglia}' AND strato in ({Strati}) AND PostiPallet = {Posti}";
                //SqlDataReader myReader = new Sql4Gestionale().ExecuteReader(SqlString);

                //if (myReader.HasRows)
                //{
                //    while (myReader.Read())
                //    {
                //        _retva = (int)myReader["totale"];  
                //    }
                //}
                //myReader.Close();
                //if (Strati.Contains(","))
                //{
                //    strati = Strati.Split(',');
                //}
                //else
                //{
                //    strati = new string[1] { Strati };
                //}
                _retva = Ital_Nr_Elementi_list.Where(x => x.Taglia == Taglia && Strati.Contains(x.Strato) && x.PostiPallet == Convert.ToInt32(Posti)).Sum(x => x.Nr_Elementi);

            }
            return _retva * CampateNum;

        }
        public static int ITAL_Nr_Elementi_Get(string Taglia, string Strato, string Posti)
        {
            int _retva = Ital_Nr_Elementi_list.Where(x => x.Taglia == Taglia && x.Strato == Strato && x.PostiPallet == Convert.ToInt32(Posti)).First().Nr_Elementi;
            //string SqlString = $"SELECT [Nr_Elementi]  FROM [ITAL_Nr_Elementi] WHERE taglia = '{Taglia}' AND strato = '{Strato}' AND PostiPallet = {Posti}";
            //SqlDataReader myReader = new Sql4Gestionale().ExecuteReader(SqlString);
            //if (myReader.HasRows)
            //{
            //    while (myReader.Read())
            //    {
            //        _retva = (int)myReader["Nr_Elementi"];
            //    }
            //}
            //myReader.Close();
            return _retva;
        }

        public static int[] ITAL_Nr_Elementi_Taglia_PostiPallet__Get(string Taglia, string Posti, string TagliaPosterire, string TagliaCentrale, string TagliaFrontale)
        {
            int[] _retva = new int[3];
            List<ITAL_Nr_Elementi> sortedList = Ital_Nr_Elementi_list.Where(x => x.Taglia == Taglia && x.PostiPallet == Convert.ToInt32(Posti)).ToList();
            for (int i = 0; i < 3; i++)
            {
                _retva[i] = sortedList[i].Nr_Elementi;
            }
            //string SqlString = $"SELECT [Nr_Elementi], Strato  FROM [ITAL_Nr_Elementi] WHERE taglia = '{Taglia}' AND PostiPallet = {Posti}";
            //SqlDataReader myReader = new Sql4Helper().ExecuteReader(SqlString);
            //if (myReader.HasRows)
            //{
            //    while (myReader.Read())
            //    {
            //        int i = 0;
            //        while (myReader.Read())
            //        {

            //            _retva[i] = (int)myReader["Nr_Elementi"];
            //            i++;
            //        }
            //    }
            //}
            //myReader.Close();

            if (TagliaCentrale != Taglia)
            {
                _retva[0] = 0;
            }

            if (TagliaFrontale != Taglia)
            {
                _retva[1] = 0;
            }
            if (TagliaPosterire != Taglia)
            {
                _retva[2] = 0;
            }


            return _retva;
        }

        private static List<ITAL_Nr_Elementi> ITAL_Nr_Element_Get()
        {
            string CacheTable = "Nr_Elementi_Listi";
            if (!CacheHelper.ItemExists(CacheTable))
            {
                List<ITAL_Nr_Elementi> _retval = new List<ITAL_Nr_Elementi>();
                string Sql = "SELECT Taglia, Strato, PostiPallet, Nr_Elementi FROM [ITAL_Nr_Elementi]";

                SqlDataReader reader = new Sql4Helper().ExecuteReader(Sql);
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        _retval.Add(new ITAL_Nr_Elementi
                        {
                            Taglia = reader["Taglia"].ToString(),
                            Strato = reader["Strato"].ToString(),
                            PostiPallet = (int)reader["PostiPallet"],
                            Nr_Elementi = (int)reader["Nr_Elementi"]
                        });
                    }
                }
                CacheHelper.Insert(CacheTable, _retval);
            }
            return CacheHelper.Retrieve<List<ITAL_Nr_Elementi>>(CacheTable);
        }
    }

    public class ITAL_Anagrafiche_CRUD
    {

    }

}