using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;

namespace INTRA.AppCode
{
    public class ITAL_Param_Calcolo_Offerta
    {

        public ITAL_Param_Calcolo_Offerta()
        {

        }


        //Passare al costruttore l'id dell'offerta per avere poi i dati riferiti all'offerta
        public ITAL_Param_Calcolo_Offerta(string IdOfferta)
        {
            this.IdOfferta = IdOfferta;

            Calcoli_dict = GetParamCalcoli(true, IdOfferta);
        }
        /*
         Chiamata usata per ricavarare i parametri di calcolo dell'offerta.
        Legenda parametri da passare:
         PerCalcolo : valore booleano per indicare se i dati prelevati vengono dalla tabella dei parametri intranet (PRT_Parameter / false) o dalla tabella dell'offerta (ITAL_Offerta_Zone_Testata / true)
         IdOfferta : Id dell'offerta da cui ricavare i dati di calcolo (è un dato che può non essere passato se i dati che si stanno prelevando vengono dalla tabella dei parametri (PerCalcolo = false))

        Es.Chiamata :
            Dictionary<string,decimal> nomeDictionary = new ITAL_Param_Calcolo_Offerta()[false]  (Se si stanno prelevando i dati dalla tabella dei parametri)
         */
        //public Dictionary<string, decimal> this[bool PerCalcolo, string IdOfferta = null]
        //{
        //    get
        //    {
        //        return GetParamCalcoli(PerCalcolo, IdOfferta);
        //    }
        //}

        public static Dictionary<string, decimal> Calcoli_dict { get; set; }

        //public Dictionary<string,decimal> this[true,IdOfferta]
        //{
        //    get
        //    {
        //        if(this[true,IdOfferta] is null)
        //        {
        //            try
        //            {
        //                this[true,IdOfferta] = this[true, IdOfferta];
        //            }
        //            catch(Exception ex) 
        //            {
        //                Console.WriteLine(ex.Message); 
        //            }
        //        }
        //        return this[true,IdOfferta];
        //    }
        //    set
        //    {
        //        this[true,IdOfferta] = value;
        //    }
        //}
        public string IdOfferta { get; set; }

        //'+++ price parameters +++
        public decimal elementS { get; set; } = 48.15m;     //ok 48.20 [OF6/22]
        public decimal elementM { get; set; } = 57.54m;     //ok 57.69  [OF6/22]
        public decimal elementL { get; set; } = 60.21m;     //ok 65.82 [OF6/22] 

        // 'OPTIONS
        //'front stopper
        public decimal frontstopperS_Base { get; set; } = 57.05m;
        public decimal frontstopperM_Base { get; set; } = 66.79m;
        public decimal frontstopperL_Base { get; set; } = 69.45m;     //ok 65.82 [OF6/22]
        //public decimal frontstopperS { get { return this[true,IdOfferta]["FrontstopperS_Base"] - this[true,IdOfferta]["ElementS"]; } }  //frontstopperS_Base - elementS
        //public decimal frontstopperM { get { return this[true,IdOfferta]["FrontstopperM_Base"] - this[true,IdOfferta]["ElementM"]; } } //frontstopperM - elementM
        //public decimal frontstopperL { get { return this[true,IdOfferta]["FrontstopperL_Base"] - this[true,IdOfferta]["ElementL"]; } } //frontstopperL - elementL
        public static decimal frontstopperS { get { return Calcoli_dict["FrontstopperS_Base"] - Calcoli_dict["ElementS"]; } }  //frontstopperS_Base - elementS
        public static decimal frontstopperM { get { return Calcoli_dict["FrontstopperM_Base"] - Calcoli_dict["ElementM"]; } } //frontstopperM - elementM
        public static decimal frontstopperL { get { return Calcoli_dict["FrontstopperL_Base"] - Calcoli_dict["ElementL"]; } } //frontstopperL - elementL

        public static Dictionary<string, decimal> frontstopperTaglia
        {
            get
            {
                Dictionary<string, decimal> frontstopperTaglia1 = new Dictionary<string, decimal>();
                frontstopperTaglia1.Add("S", frontstopperS);
                frontstopperTaglia1.Add("M", frontstopperM);
                frontstopperTaglia1.Add("L", frontstopperL);
                return frontstopperTaglia1;
            }
        }

        //'divider
        public decimal dividerS_Base = 70.11m;
        public static decimal dividerS
        {
            get
            {
                //return this[true, IdOfferta]["DividerS_Base"] - this[true, IdOfferta]["ElementM"] - frontstopperM; //dividerS_Base - elementM  - frontstopperM        
                return Calcoli_dict["DividerS_Base"] - Calcoli_dict["ElementM"] - frontstopperM; //dividerS_Base - elementM  - frontstopperM
            }
        }
        public static decimal dividerM
        {
            get
            {
                return dividerS;
            }
        }
        public decimal dividerL_Base { get; set; } = 73.68m;
        public static decimal dividerL
        {
            get
            {
                //return this[true, IdOfferta]["DividerL_Base"] - this[true, IdOfferta]["ElementL"] - frontstopperL; //dividerL_Base - elementL
                return Calcoli_dict["DividerL_Base"] - Calcoli_dict["ElementL"] - frontstopperL; //dividerL_Base - elementL
            }
        }

        public static Dictionary<string, decimal> dividerTaglia
        {
            get
            {
                Dictionary<string, decimal> dividerTaglia1 = new Dictionary<string, decimal>();
                dividerTaglia1.Add("S", dividerS);
                dividerTaglia1.Add("M", dividerM);
                dividerTaglia1.Add("L", dividerL);
                return dividerTaglia1;
            }
        }


        //'front cover
        public decimal frontcoverS_Base { get; set; } = 6.5m;
        public static decimal frontcoverS
        {
            get
            {
                //return this[true, IdOfferta]["FrontcoverS_Base"];  //'stima    *frontcoverS_Base*
                return Calcoli_dict["FrontcoverS_Base"];  //'stima    *frontcoverS_Base*
            }
        }
        public decimal frontcoverM_Base { get; set; } = 74.63m;
        public static decimal frontcoverM
        {
            get
            {
                //return this[true, IdOfferta]["FrontcoverM_Base"] - this[true, IdOfferta]["ElementM"] - frontstopperM; //'ok  7.84      *frontcoverM_Base - elementM - frontstopperM*
                return Calcoli_dict["FrontcoverM_Base"] - Calcoli_dict["ElementM"] - frontstopperM; //'ok  7.84      *frontcoverM_Base - elementM - frontstopperM*
            }
        }
        public decimal frontcoverL_Base { get; set; } = 76.26m;
        public static decimal frontcoverL
        {
            get
            {
                //return this[true, IdOfferta]["FrontcoverL_Base"] - this[true, IdOfferta]["ElementL"] - frontstopperM;  //'ok 16.05      *frontcoverL_Base - elementL - frontstopperL*
                return Calcoli_dict["FrontcoverL_Base"] - Calcoli_dict["ElementL"] - frontstopperL;  //'ok 16.05      *frontcoverL_Base - elementL - frontstopperL*

            }
        }

        public static Dictionary<string, decimal> frontcoverTaglia
        {
            get
            {
                Dictionary<string, decimal> frontcoverTaglia1 = new Dictionary<string, decimal>();
                frontcoverTaglia1.Add("S", frontcoverS);
                frontcoverTaglia1.Add("M", frontcoverM);
                frontcoverTaglia1.Add("L", frontcoverL);
                return frontcoverTaglia1;
            }
        }

        public decimal suspension3 { get; set; } = 288.39m; //  '21.50*6+53.13*3 [OF6/22] - prev.price 237.24
        public decimal suspension4 { get; set; } = 391.54m; // '28.31*6+55.42*4 [OF6/22] - prev.price 356.45
        public decimal suspension4L { get; set; } = 277.84m; //  'not used
        public decimal pack3 { get; set; } = 100.33m;
        public decimal pack4 { get; set; } = 202.7m;
        public decimal ship1X { get; set; } = 161.25m;
        public decimal markup { get; set; } = 1.68m;  //'moltiplicatore +68%
        public decimal scontomax { get; set; } = 0.9m; // 'sconto max 10%
        public decimal provvigione { get; set; } = 0.89m; //  'provvigione 11%
        public decimal economiascala { get; set; } = 0.95m;


        //public static decimal CalcolaPrezzoZona(int SmallElementi, int MediumElementi, int LargeElementi, int AmpiezzaNettaZona, int CampateNum, string IdOfferta)
        //{
        //    decimal _retval = 0;
        //    ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
        //    //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
        //    Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;
        //    //add price elements
        //    _retval = SmallElementi * parametriCalcolo["ElementS"] * parametriCalcolo["Markup"]; //elementS * markup
        //    _retval = _retval + MediumElementi * parametriCalcolo["ElementM"] * parametriCalcolo["Markup"]; // _obj.elementM * _obj.markup
        //    _retval = _retval + LargeElementi * parametriCalcolo["ElementL"] * parametriCalcolo["Markup"]; // _obj.elementL * _obj.markup

        //    if (AmpiezzaNettaZona < 3600)
        //    { _retval = _retval + (CampateNum * (parametriCalcolo["Suspension3"] + parametriCalcolo["Pack3"]) * parametriCalcolo["Markup"]); } // (_obj.suspension3 + _obj.pack3) * _obj.markup
        //    else
        //    { _retval = _retval + (CampateNum * (parametriCalcolo["Suspension4"] + parametriCalcolo["Pack4"]) * parametriCalcolo["Markup"]); } //(_obj.suspension4 + _obj.pack4) * _obj.markup)

        //    switch (CampateNum)
        //    {
        //        case int n when n < 5:
        //            _retval = _retval + CampateNum * parametriCalcolo["Ship1X"];//ship1X
        //            break;

        //        case int n when n >= 5 && n <= 10:
        //            _retval = _retval * parametriCalcolo["Economiascala"] + CampateNum * parametriCalcolo["Ship1X"]; //_retval * _obj.economiascala + CampateNum * ship1X
        //            break;
        //        case int n when n >= 11 && n <= 20:
        //            _retval = _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(parametriCalcolo["Economiascala"]), 2)) + CampateNum * parametriCalcolo["Ship1X"]; //  _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(_obj.economiascala), 2)) + CampateNum * _obj.ship1X
        //            break;
        //        case int n when n > 20:
        //            _retval = _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(parametriCalcolo["Economiascala"]), 3)) + CampateNum * parametriCalcolo["Ship1X"]; // _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(_obj.economiascala), 3)) + CampateNum * _obj.ship1X
        //            break;
        //    }
        //    return _retval;
        //}
        //public static decimal CalcolaPrezzoOpzione(string Taglia, string Strato, string Posti, string TipoOpzione, int CampateNum, string IdOfferta)
        //{
        //    decimal _retVal = 0;

        //    int Nr_Elementi = ITAL_Nr_Elementi.ITAL_Nr_Elementi_Get(Taglia, Strato, Posti);

        //    _retVal = CampateNum * Nr_Elementi;

        //    switch (TipoOpzione)
        //    {
        //        case "B": //'front stopper
        //            _retVal *= CalcoloFrontStopper(Taglia, IdOfferta);
        //            break;
        //        case "D": // 'divider
        //            _retVal *= CalcoloDivider(Taglia, IdOfferta);
        //            break;
        //        case "S": // 'front cover
        //            _retVal *= CalcoloFrontCover(Taglia, IdOfferta);
        //            break;
        //    }
        //    return _retVal;
        //}
        public static decimal CalcoloFrontStopper(string Taglia, string IdOfferta)
        {
            // ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
            Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;
            decimal _retVal = frontstopperTaglia[Taglia];
            return _retVal * parametriCalcolo["Markup"]; //_retVal * _obj.markup
        }
        public static decimal CalcoloDivider(string Taglia, string IdOfferta)
        {
            //ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
            Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;
            decimal _retVal = dividerTaglia[Taglia];
            return _retVal * parametriCalcolo["Markup"]; //_retVal * _obj.markup
        }
        public static decimal CalcoloFrontCover(string Taglia, string IdOfferta)
        {
            //ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
            Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;
            decimal _retVal = frontcoverTaglia[Taglia];
            return _retVal * parametriCalcolo["Markup"]; //_retVal * _obj.markup
        }

        public static decimal[] CalcoloTotaleOfferta(decimal Imponibile, bool AgenteEsterno, decimal ScontoConcesso, string IdOfferta)
        {
            //ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            Dictionary<string, decimal> parametriCalcolo = ITAL_Param_Calcolo_Offerta.GetParamCalcoli(true, IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;

            decimal ImponibileConScontoMAx = Imponibile / parametriCalcolo["Scontomax"]; //
            decimal[] _retValArray = new decimal[2];
            decimal _appoggio = 0;

            if (AgenteEsterno)
            {
                _appoggio = ImponibileConScontoMAx / parametriCalcolo["Provvigione"]; //ImponibileConScontoMAx / _obj.provvigione
                decimal percentualeCalcolo = _appoggio * (parametriCalcolo["MarginePercent"] / 100);
                _appoggio = _appoggio + percentualeCalcolo;

            }
            else { _appoggio = ImponibileConScontoMAx; }

            _retValArray[0] = _appoggio;

            if (ScontoConcesso > 0)
            {
                _appoggio = _appoggio * (100 - ScontoConcesso) / 100;

            }
            _retValArray[1] = _appoggio;
            return _retValArray;
        }


        public static Dictionary<string, decimal> GetParamCalcoli(bool PerCalcolo, string IdOfferta)
        {
            Dictionary<string, decimal> retval = null;

            string table = PerCalcolo ? "ITAL_Offerta_Testata" : "PRT_Parameter";
            string filter = PerCalcolo ? $"WHERE IdOfferta = {IdOfferta}" : "WHERE IsFrontEnd = 1";
            string[] ElementiCalcolo = new string[] { "ElementS", "ElementM", "ElementL", "FrontstopperS_Base", "FrontstopperM_Base", "FrontstopperL_Base", "DividerS_Base", "DividerL_Base", "FrontcoverS_Base", "FrontcoverM_Base", "FrontcoverL_Base", "Suspension3", "Suspension4", "Suspension4L", "Pack3", "Pack4", "Ship1X", "Markup", "Scontomax", "Provvigione", "Economiascala", "MarginePercent" };
            string ElementToSelect = PerCalcolo ? string.Join(",", ElementiCalcolo) : "CodParam,Value";
            string Select = $"SELECT {ElementToSelect} FROM {table} {filter}";

            SqlDataReader reader = new Sql4Helper().ExecuteReader(Select);

            if (reader.HasRows)
            {
                retval = new Dictionary<string, decimal>();
                while (reader.Read())
                {
                    if (PerCalcolo)
                    {
                        for (int i = 0; i < ElementiCalcolo.Length; i++)
                        {
                            retval.Add(ElementiCalcolo[i], Convert.ToDecimal(reader[ElementiCalcolo[i]]));
                        }
                    }
                    else
                    {
                        decimal value = decimal.Parse(reader["Value"].ToString(), CultureInfo.InvariantCulture);
                        retval.Add(reader["CodParam"].ToString(), value);
                    }
                }
            }
            return retval;
        }



        public decimal CalcolaPrezzoOpzioneV2(string Taglia, string Strato, string Posti, string TipoOpzione, int CampateNum, string IdOfferta)
        {
            decimal _retVal = 0;

            int Nr_Elementi = ITAL_Nr_Elementi.ITAL_Nr_Elementi_Get(Taglia, Strato, Posti);

            _retVal = CampateNum * Nr_Elementi;

            switch (TipoOpzione)
            {
                case "B": //'front stopper
                    _retVal *= CalcoloFrontStopper(Taglia, IdOfferta);
                    break;
                case "D": // 'divider
                    _retVal *= CalcoloDivider(Taglia, IdOfferta);
                    break;
                case "S": // 'front cover
                    _retVal *= CalcoloFrontCover(Taglia, IdOfferta);
                    break;
            }
            return _retVal;
        }


        public decimal CalcolaPrezzoZonaV2(int SmallElementi, int MediumElementi, int LargeElementi, int AmpiezzaNettaZona, int CampateNum, string IdOfferta, decimal PrezzoOpzioni)
        {
            decimal _retval = PrezzoOpzioni;
            //ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
            Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;
            //add price elements
            _retval += SmallElementi * parametriCalcolo["ElementS"] * parametriCalcolo["Markup"]; //elementS * markup
            _retval = _retval + MediumElementi * parametriCalcolo["ElementM"] * parametriCalcolo["Markup"]; // _obj.elementM * _obj.markup
            _retval = _retval + LargeElementi * parametriCalcolo["ElementL"] * parametriCalcolo["Markup"]; // _obj.elementL * _obj.markup

            if (AmpiezzaNettaZona < 3600)
            { _retval = _retval + (CampateNum * (parametriCalcolo["Suspension3"] + parametriCalcolo["Pack3"]) * parametriCalcolo["Markup"]); } // (_obj.suspension3 + _obj.pack3) * _obj.markup
            else
            { _retval = _retval + (CampateNum * (parametriCalcolo["Suspension4"] + parametriCalcolo["Pack4"]) * parametriCalcolo["Markup"]); } //(_obj.suspension4 + _obj.pack4) * _obj.markup)

            switch (CampateNum)
            {
                case int n when n < 5:
                    _retval = _retval + CampateNum * parametriCalcolo["Ship1X"];//ship1X
                    break;

                case int n when n >= 5 && n <= 10:
                    _retval = _retval * parametriCalcolo["Economiascala"] + CampateNum * parametriCalcolo["Ship1X"]; //_retval * _obj.economiascala + CampateNum * ship1X
                    break;
                case int n when n >= 11 && n <= 20:
                    _retval = _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(parametriCalcolo["Economiascala"]), 2)) + CampateNum * parametriCalcolo["Ship1X"]; //  _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(_obj.economiascala), 2)) + CampateNum * _obj.ship1X
                    break;
                case int n when n > 20:
                    _retval = _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(parametriCalcolo["Economiascala"]), 3)) + CampateNum * parametriCalcolo["Ship1X"]; // _retval * Convert.ToDecimal(Math.Pow(Convert.ToDouble(_obj.economiascala), 3)) + CampateNum * _obj.ship1X
                    break;
            }
            return _retval;
        }



        public decimal[] CalcoloTotaleOffertaV2(decimal Imponibile, bool AgenteEsterno, decimal ScontoConcesso)
        {
            //ITAL_Param_Calcolo_Offerta _obj = new ITAL_Param_Calcolo_Offerta(IdOfferta);
            //Dictionary<string, decimal> parametriCalcolo = _obj[true, IdOfferta];
            Dictionary<string, decimal> parametriCalcolo = Calcoli_dict;

            decimal ImponibileConScontoMAx = Imponibile / parametriCalcolo["Scontomax"]; //
            decimal[] _retValArray = new decimal[3];
            decimal _appoggio = 0;

            if (AgenteEsterno)
            {
                _appoggio = ImponibileConScontoMAx / parametriCalcolo["Provvigione"]; //ImponibileConScontoMAx / _obj.provvigione
                _retValArray[0] = _appoggio;
                decimal percentualeCalcolo = _appoggio * (parametriCalcolo["MarginePercent"] / 100);
                _appoggio = _appoggio + percentualeCalcolo;

            }
            else { _appoggio = ImponibileConScontoMAx; }

            _retValArray[1] = _appoggio;

            if (ScontoConcesso > 0)
            {
                _appoggio = _appoggio * (100 - ScontoConcesso) / 100;

            }
            _retValArray[2] = _appoggio;
            return _retValArray;
        }


    }

}