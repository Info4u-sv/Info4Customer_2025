using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using info4lab;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Descrizione di riepilogo per Col_Rapportini
/// </summary>
/// 
namespace INTRA.Age_Ordini.AppCode
{
    public class TCK_Ticket_v2
    {
        public TCK_Ticket_v2()
        {
            //
            // TODO: aggiungere qui la logica del costruttore
            //
        }

        #region property

        public string CodRapportino { get; set; }
        public string CodCliente { get; set; }
        public string Società { get; set; }
        public string PIva { get; set; }
        public string Indirizzo { get; set; }
        public string Cap { get; set; }
        public string Località { get; set; }
        public string Provincia { get; set; }
        public string Telefono { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string Matricola { get; set; }
        public string Scala { get; set; }
        public int TipoImpianto { get; set; }
        public string PersonaDaContattare { get; set; }
        public int TipoChiamata { get; set; }
        public int AreaAss { get; set; }
        public string MotivoChiamata { get; set; }
        public string Note { get; set; }
        public string GuastoRilevato { get; set; }
        public string LavoroEseguito { get; set; }
        public bool InterventoChiuso { get; set; }
        public string Osservazioni { get; set; }
        public string DataIntervento { get; set; }
        public string DataIns { get; set; }
        public string EditUser { get; set; }
        public string CreatedOn { get; set; }
        public string UpdatedOn { get; set; }

        public string User { get; set; }
        public string Ore { get; set; }
        public int StatusRpt { get; set; }

        public int Id { get; set; }
        public string IncaricatoCli { get; set; }
        public string ImmagineTxt { get; set; }
        public string PercorsoImmagine { get; set; }

        //--- modifica 16-04-2016
        public int TCK_TipoRichiesta { get; set; }
        public int TCK_AreaCompetenza { get; set; }
        public int TCK_TipoEsecuzionePresunta { get; set; }
        public int TCK_TipoEsecuzione { get; set; }
        public int TCK_StatusChiamata { get; set; }
        public int TCK_StatusChiamataChiusura { get; set; }
        public int TCK_PrioritaRichiesta { get; set; }
        public int TCK_TipoChiusuraChiamataFattura { get; set; }

        public string OraInzioIntervento { get; set; }
        public string OraFineIntervento { get; set; }
        public string NomePersonaRiferimento { get; set; }
        public string TelPersonaRiferimento { get; set; }
        public string MailPersonaRiferimento { get; set; }
        public float DirittoFisso { get; set; }
        public float TariffaOraria { get; set; }
        public int SpeseViaggioKm { get; set; }
        public float SpeseViaggioEuro { get; set; }
        public float TotaleEuroForfait { get; set; }
        //--- modifica 1/08/2016
        public string TCK_StatusChiamata_etichetta { get; set; }
        public string TCK_TipoRichiesta_etichetta { get; set; }
        public string TCK_AreaCompetenza_etichetta { get; set; }
        public string TCK_TipoEsecuzionePresunta_etichetta { get; set; }
        public string TCK_TipoEsecuzione_etichetta { get; set; }
        public string TCK_PrioritaRichiesta_etichetta { get; set; }

        //--- modifica 5/08/2016
        public string ImgFirmaCliente { get; set; }
        public string ImgFirmaTecnico { get; set; }
        public string FirmaCliente { get; set; }
        public bool TicketFirmato { get; set; }
        //--- modifica 1/09/2016
        public string InterventoPresso { get; set; }
        public string FirmaTecnico { get; set; }
        public string NoteAnnullamentoTck { get; set; }
        public string NoteTecnico { get; set; }
        public string LinkTckPdf { get; set; }
        public string TckInviatoA { get; set; }
        public string TCK_StatusChiamataChiusura_Etichetta { get; set; }

        public int TotTecnici_TCK { get; set; }
        public float TempoInterventoTotale { get; set; }
        public string UM_Tempo { get; set; }
        //--- modifica 29/09/2016

        public int StatusControlloFatt { get; set; }
        public string ApprovatoDa { get; set; }

        //modifica 21/12/2016
        public int StatusControlloRegistrazione { get; set; }

        public int NumeroRegistrazione { get; set; }

        public string NoteFatturazioneFinale { get; set; }

        public int StatusControlloFatturazioneFinale { get; set; }

        // modifica 27/12/2016
        public string societa { get; set; }
        public string Denom { get; set; }
        public string Ind { get; set; }

        public string Prov { get; set; }
        public string Loc { get; set; }
        public string Tel { get; set; }

        public string Riferim { get; set; }

        public string EMail { get; set; }
        public string CodCli { get; set; }

        //modifica del 13/01/2017 Alessio

        public string CodArt_King { get; set; }
        public int IdIntervento_King { get; set; }

        public decimal PrezzoDa { get; set; }

        public decimal PrezzoA { get; set; }

        public string EmailTecnicoPerCliente { get; set; }

        public bool FlagPrezzoA { get; set; }

        public decimal ScontoIncondizionato { get; set; }
        #endregion

        //    public int InsertCOL_Rapportini(TCK_Ticket_v2 Rapportini)
        //    {
        //        //string firmavuota = "data: image / jpeg; base64,/ 9j / 4AAQSkZJRgABAQAAAQABAAD//gA7Q1JFQVRPUjogZ2QtanBlZyB2MS4wICh1c2luZyBJSkcgSlBFRyB2NjIpLCBxdWFsaXR5ID0gOTAK/9sAQwADAgIDAgIDAwMDBAMDBAUIBQUEBAUKBwcGCAwKDAwLCgsLDQ4SEA0OEQ4LCxAWEBETFBUVFQwPFxgWFBgSFBUU/9sAQwEDBAQFBAUJBQUJFA0LDRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU/8AAEQgA4QEsAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/VKjNFFABmiijNABRRmjNABRR+VJ+VAC0Un5Uv5UAFFJ+VH5UAL/AJ6Uf56UlFAC/j+lH+elJRQAv+elH4/pSUUAL/npR/npSUUAL+P6Uf56UlFAC/56Ufj+lJRQAv8AnpR/npSUUAL/AJ6Uf56UlFAC/wCelH+elJRQAv8AnpR/npSUUAL/AJ6Uf56UlFAC/wCelH+elJRQAv8AnpR/npSUf560ALRR3oP+eKACik/z0paAE/z1paT/AD0paAD86PzoooAPzo/OiigA/Oj86KKAE/z1o/z1pf8APSj/AD0oAT/PWj/PWl/z0o/z0oAT/PWj/PWl/wA9KP8APSgBP89aP89aX/PSj/PSgBP89aP89aX/AD0o/wA9KAE/z1o/z1pf89KP89KAE/z1opf89KP89KAEo/z1pf8APSj/AD0oASil/wA9KP8APSgBP89aKX/PSj/PSgBKP89aX/PSj/PSgBKKX/PSj/PSgBP89aWj/PSj/PSgA70hpe9BoASiiloASij/AD1paACilpKACiiloASiiigA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAKQ0tIaAClpKWgApaSigAooo/wA9KACiiigAoo/z0ooAWiiigAooooAKKKKACiiigAooooAKKKKAEpaSigAooooAWkoooAKWkooAKKKKAFpKKKAClpKWgBKQ0tIaAClpKWgAoopaAEo/z1oooAKKKKAD/PWiiigBaKKKACiiigAooooAKKKKACiiigAooooASiiloASiiigAopaSgAoopaAEooooAKKWkoAKWkpaAEpDS0hoAKWkpaACiiigAo/z0oo/z1oAKKKKAD/PSij/AD1ooAWiiigAooooAKKKKACiiigAooooAKKKKAEooooAKKKKACiiigAooooAKKKKACiiigApaSloAQ0lKetJQAtJS0UAJRR/nrS0AH+etH+etH50fnQAf560f560fnR+dAB/nrR/nrR+dH50AH+etFFFABR/nrRRQAUUUUAH+etFFFABR/nrRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAAetJSmkoAWiikoAP8APSlpKKAF/wA9KP8APSj/AD1o/wA9aAD/AD0o/wA9KP8APWj/AD1oAP8APSj/AD0o/wA9aP8APWgAoo/z1ooAKKKP89aACiiigAoo/wA9aKACiij/AD1oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAPWkpT1pKAFooooAT/PWlpP8APSloAPzo/Oj/AD0o/wA9KAD86Pzo/wA9KP8APSgA/Oj86P8APSj/AD0oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAA0lKetJQAtJS0UAJRR/nrS0AH+etH+etH50fnQAf560f560fnR+dAB/nrR/nrR+dH50AH+etFFFABR/nrRRQAUUUUAH+etFFFABR/nrRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAAetJSmkoAWiikoAP89KWkooAX/PSj/PSj/PWj/PWgA/z0o/z0o/z1o/z1oAP89KP89KP89aP89aACij/PWigAooo/z1oAKKKKACij/PWigAooo/z1oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAPWkpT1pKAFooooAT/PWlpP89KWgA/Oj86P89KP89KAD86Pzo/z0o/z0oAPzo/Oj/PSj/PSgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAQ/55oFKaQUALRRRQAUUf56UUALRRRQAUUUUAFFFFACUtJRQAUUUUALSUUUAFLSUUAFFFFAC0lFFACUUUf56UAFFFFABRR/npRQAUUUf56UAFFFFABRR/npRQAUf560Uf56UABoFB/zzQKAFooooAKKKKAFooooAKKKKACiiigBKKKWgBKKKKACilpKACiiloASiiigAopaSgBKKKKACiiigAooooAKKKKACiiigAooooAKKKP89aAFPWk7UUUAFFFFAB2ooooAdRRRQAUUUUAFFFFACUd6KKACiiigA70UUUAFHeiigAooooAO9FFFADaKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/9k=";
        //        string firmavuota = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFQAAAA7CAYAAADlya1OAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6Q0EyMkFGRUM3NUNCMTFFNjk3NzZDM0JDRTBFRjYyNjciIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6Q0EyMkFGRUI3NUNCMTFFNjk3NzZDM0JDRTBFRjYyNjciIHhtcDpDcmVhdG9yVG9vbD0iV2luZG93cyBQaG90byBFZGl0b3IgMTAuMC4xMDAxMS4xNjM4NCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ1dWlkOmZhZjViZGQ1LWJhM2QtMTFkYS1hZDMxLWQzM2Q3NTE4MmYxYiIgc3RSZWY6ZG9jdW1lbnRJRD0iMDRBNkIyNDc4QjkxMjVBQTc4NDgwMTdBMzA5NUM4OTEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6E7tyIAAAAZklEQVR42uzQMREAAAgEILV/57eEkwcR6CTFnVEgVKhQhAoVilChQhEqVKhQhAoVilChQhEqVChChQoVilChQhEqVChChQpFqFChQhEqVChChQpFqFChCBUqVChChQpFqNAHVoABAFS/A3O3K7OxAAAAAElFTkSuQmCC";

        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[25];

        //        objParams[0] = new SqlParameter("@CodCli", Rapportini.CodCliente);
        //        objParams[1] = new SqlParameter("@Società", Rapportini.Società);
        //        objParams[2] = new SqlParameter("@PIva", Rapportini.PIva);
        //        objParams[3] = new SqlParameter("@Indirizzo", Rapportini.Indirizzo);
        //        objParams[4] = new SqlParameter("@Cap", Rapportini.Cap);
        //        objParams[5] = new SqlParameter("@Località", Rapportini.Località);
        //        objParams[6] = new SqlParameter("@Provincia", Rapportini.Provincia);
        //        objParams[7] = new SqlParameter("@Telefono", Rapportini.Telefono);
        //        objParams[8] = new SqlParameter("@Fax", Rapportini.Fax);
        //        objParams[9] = new SqlParameter("@Email", Rapportini.Email);
        //        objParams[10] = new SqlParameter("@PersonaDaContattare", Rapportini.PersonaDaContattare);

        //        objParams[11] = new SqlParameter("@TCK_TipoRichiesta", Rapportini.TCK_TipoRichiesta);
        //        objParams[12] = new SqlParameter("@TCK_AreaCompetenza", Rapportini.TCK_AreaCompetenza);
        //        objParams[13] = new SqlParameter("@TCK_TipoEsecuzionePresunta", Rapportini.TCK_TipoEsecuzionePresunta);
        //        objParams[14] = new SqlParameter("@TCK_TipoEsecuzione", Rapportini.TCK_TipoEsecuzione);
        //        objParams[15] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);

        //        objParams[16] = new SqlParameter("@MotivoChiamata", Rapportini.MotivoChiamata);
        //        objParams[17] = new SqlParameter("@NomePersonaRiferimento", Rapportini.NomePersonaRiferimento);
        //        objParams[18] = new SqlParameter("@TelPersonaRiferimento", Rapportini.TelPersonaRiferimento);
        //        objParams[19] = new SqlParameter("@MailPersonaRiferimento", Rapportini.MailPersonaRiferimento);

        //        objParams[20] = new SqlParameter("@InsertUser", Rapportini.EditUser);

        //        objParams[21] = new SqlParameter("@TCK_PrioritaRichiesta", Rapportini.TCK_PrioritaRichiesta);
        //        objParams[22] = new SqlParameter("@InterventoPresso", Rapportini.InterventoPresso);
        //        objParams[23] = new SqlParameter("@FirmaVuota", firmavuota);
        //        objParams[24] = new SqlParameter("@NoteTecnico", Rapportini.NoteTecnico);
        //        int LastId = objSqlHelper.ExecuteNonQueryForNews("TCK_Ticket_v2Testata_Insert", objParams);
        //        return LastId;
        //    }


        //    public void UpdateCOL_Rapportini(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[38];

        //        objParams[0] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[1] = new SqlParameter("@Società", Rapportini.Società);
        //        objParams[2] = new SqlParameter("@PIva", Rapportini.PIva);
        //        objParams[3] = new SqlParameter("@Indirizzo", Rapportini.Indirizzo);
        //        objParams[4] = new SqlParameter("@Cap", Rapportini.Cap);
        //        objParams[5] = new SqlParameter("@Località", Rapportini.Località);
        //        objParams[6] = new SqlParameter("@Provincia", Rapportini.Provincia);
        //        objParams[7] = new SqlParameter("@Telefono", Rapportini.Telefono);
        //        objParams[8] = new SqlParameter("@Fax", Rapportini.Fax);
        //        objParams[9] = new SqlParameter("@Email", Rapportini.Email);
        //        objParams[10] = new SqlParameter("@PersonaDaContattare", Rapportini.PersonaDaContattare);
        //        objParams[11] = new SqlParameter("@NomePersonaRiferimento", Rapportini.NomePersonaRiferimento);
        //        objParams[12] = new SqlParameter("@TelPersonaRiferimento", Rapportini.TelPersonaRiferimento);
        //        objParams[13] = new SqlParameter("@MailPersonaRiferimento", Rapportini.MailPersonaRiferimento);
        //        objParams[14] = new SqlParameter("@MotivoChiamata", Rapportini.MotivoChiamata);
        //        objParams[15] = new SqlParameter("@TCK_TipoEsecuzione", Rapportini.TCK_TipoEsecuzione);
        //        DateTime dateValue;
        //        if (DateTime.TryParse(Rapportini.DataIntervento, out dateValue)) { }

        //        else { Rapportini.DataIntervento = DateTime.Now.ToString(); }
        //        objParams[16] = new SqlParameter("@DataIntervento", Convert.ToDateTime(Rapportini.DataIntervento));
        //        objParams[17] = new SqlParameter("@LavoroEseguito", Rapportini.LavoroEseguito);
        //        objParams[18] = new SqlParameter("@Note", Rapportini.Note);
        //        objParams[19] = new SqlParameter("@DirittoFisso", Rapportini.DirittoFisso);
        //        objParams[20] = new SqlParameter("@TariffaOraria", Rapportini.TariffaOraria);
        //        objParams[21] = new SqlParameter("@SpeseViaggioKm", Rapportini.SpeseViaggioKm);
        //        objParams[22] = new SqlParameter("@SpeseViaggioEuro", Rapportini.SpeseViaggioEuro);
        //        objParams[23] = new SqlParameter("@TotaleEuroForfait", Rapportini.TotaleEuroForfait);
        //        objParams[24] = new SqlParameter("@EditUser", Rapportini.EditUser);
        //        objParams[25] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(Rapportini.UpdatedOn));
        //        objParams[26] = new SqlParameter("@TCK_StatusChiamataChiusura", Rapportini.TCK_StatusChiamataChiusura);
        //        objParams[27] = new SqlParameter("@TCK_TipoChiusuraChiamataFattura", Rapportini.TCK_TipoChiusuraChiamataFattura);
        //        objParams[28] = new SqlParameter("@InterventoChiuso", Rapportini.InterventoChiuso);
        //        objParams[29] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);
        //        objParams[30] = new SqlParameter("@TckInviatoA", Rapportini.TckInviatoA);
        //        objParams[31] = new SqlParameter("@FirmaCliente", Rapportini.FirmaCliente);
        //        objParams[32] = new SqlParameter("@TCK_AreaCompetenza", Rapportini.TCK_AreaCompetenza);
        //        objParams[33] = new SqlParameter("@TCK_PrioritaRichiesta", Rapportini.TCK_PrioritaRichiesta);
        //        objParams[34] = new SqlParameter("@InterventoPresso", Rapportini.InterventoPresso);
        //        objParams[35] = new SqlParameter("@OraInzioIntervento", Rapportini.OraInzioIntervento);
        //        objParams[36] = new SqlParameter("@OraFineIntervento", Rapportini.OraFineIntervento);
        //        objParams[37] = new SqlParameter("@TCK_TipoRichiesta", Rapportini.TCK_TipoRichiesta);

        //        //COL_Rapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_Ticket_v2Testata_Update", objParams);
        //    }

        //    public void TCK_TestataTicket_NoteTecnico_Update(string noteTecnico, string codRapp)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[2];

        //        objParams[0] = new SqlParameter("@NoteTecnico", noteTecnico);
        //        objParams[1] = new SqlParameter("@CodRapportino", codRapp);
        //        //COL_Rapportini_NoteTecnico_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_NoteTecnico_Update", objParams);

        //    }


        //    public void ChiusuraForzataRapportino_Update(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[5];


        //        //objParams[1] = new SqlParameter("@LavoroEseguito", Rapportini.LavoroEseguito);
        //        //objParams[2] = new SqlParameter("@Note", Rapportini.Note);
        //        objParams[0] = new SqlParameter("@InterventoChiuso", Rapportini.InterventoChiuso);
        //        objParams[1] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);
        //        objParams[2] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[3] = new SqlParameter("@NoteAnnullamentoTck", Rapportini.NoteAnnullamentoTck);
        //        objParams[4] = new SqlParameter("@TCK_StatusChiamataChiusura", Rapportini.TCK_StatusChiamataChiusura);

        //        //objParams[4] = new SqlParameter("@DataIntervento", Convert.ToDateTime(Rapportini.DataIntervento));
        //        //objParams[5] = new SqlParameter("@EditUser", Rapportini.EditUser);
        //        //objParams[6] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(Rapportini.UpdatedOn));
        //        //objParams[7] = new SqlParameter("@StatusRpt", StatusRpt);
        //        //objParams[8] = new SqlParameter("@IncaricatoCli", IncaricatoCli);
        //        //objParams[9] = new SqlParameter("@ImmagineTxt", ImmagineTxt);
        //        //objParams[10] = new SqlParameter("@PercorsoImmagine", PercorsoImmagine);
        //        //COL_Rapportini_Concludi

        //        objSqlHelper.ExecuteNonQueryForNews("ChiusuraForzataRapportino_Update", objParams);
        //    }


        //    public void TCK_TestataTicket_StatusChimata_Update(int CodRapportino, int TCK_StatusChiamata, int TCK_StatusChiamataChiusura)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];
        //        // valorizzo i due campi se 
        //        //TCK_StatusChiamata = 1 o 2 o 3 TCK_StatusChiamataChiusura è =1

        //        objParams[0] = new SqlParameter("@CodRapportino", CodRapportino);
        //        objParams[1] = new SqlParameter("@TCK_StatusChiamata", TCK_StatusChiamata);
        //        objParams[2] = new SqlParameter("@TCK_StatusChiamataChiusura", TCK_StatusChiamataChiusura);
        //        //COL_DetRapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_StatusChimata_Update", objParams);
        //    }
        //    public void TCK_TestataTicket_AvviaTicket(int CodRapportino, int TCK_StatusChiamata, string DataIntervento, string OraInzioIntervento)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[4];

        //        objParams[0] = new SqlParameter("@CodRapportino", CodRapportino);
        //        objParams[1] = new SqlParameter("@TCK_StatusChiamata", TCK_StatusChiamata);
        //        objParams[2] = new SqlParameter("@DataIntervento", Convert.ToDateTime(DataIntervento));
        //        objParams[3] = new SqlParameter("@OraInzioIntervento", Convert.ToDateTime(OraInzioIntervento));

        //        //COL_DetRapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_AvviaTicket", objParams);
        //    }
        //    public void TCK_Ticket_v2Testata_Update(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[10];

        //        objParams[0] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[1] = new SqlParameter("@LavoroEseguito", Rapportini.LavoroEseguito);
        //        objParams[2] = new SqlParameter("@Note", Rapportini.Note);
        //        objParams[11] = new SqlParameter("@TCK_TipoRichiesta", Rapportini.TCK_TipoRichiesta);
        //        objParams[12] = new SqlParameter("@TCK_AreaCompetenza", Rapportini.TCK_AreaCompetenza);
        //        objParams[13] = new SqlParameter("@TCK_TipoEsecuzionePresunta", Rapportini.TCK_TipoEsecuzionePresunta);
        //        objParams[14] = new SqlParameter("@TCK_TipoEsecuzione", Rapportini.TCK_TipoEsecuzione);
        //        objParams[15] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);
        //        objParams[16] = new SqlParameter("@TCK_StatusChiamataChiusura", Rapportini.TCK_StatusChiamataChiusura);
        //        objParams[17] = new SqlParameter("@TCK_TipoChiusuraChiamataFattura", Rapportini.TCK_TipoChiusuraChiamataFattura);
        //        objParams[3] = new SqlParameter("@InterventoChiuso", Rapportini.InterventoChiuso);
        //        objParams[5] = new SqlParameter("@EditUser", Rapportini.EditUser);
        //        objParams[6] = new SqlParameter("@UpdatedOn", Convert.ToDateTime(Rapportini.UpdatedOn));
        //        objParams[7] = new SqlParameter("@StatusRpt", StatusRpt);

        //        //COL_Rapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_Ticket_v2Testata_Update", objParams);
        //    }

        //    public void TCK_TestataTicket_FirmaUpdate(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[4];

        //        objParams[0] = new SqlParameter("@ImgFirmaCliente", Rapportini.ImgFirmaCliente);
        //        objParams[1] = new SqlParameter("@FirmaCliente", Rapportini.FirmaCliente);
        //        objParams[2] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[3] = new SqlParameter("@TicketFirmato", Rapportini.TicketFirmato);

        //        //COL_DetRapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_FirmaUpdate", objParams);
        //    }

        //    public void TCK_TestataTicket_TecnicoFirmaUpdate(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@ImgFirmaTecnico", Rapportini.ImgFirmaTecnico);
        //        objParams[1] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[2] = new SqlParameter("@FirmaTecnico", Rapportini.FirmaTecnico);
        //        //COL_DetRapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_TecnicoFirmaUpdate", objParams);
        //    }

        //    public void TCK_LinkTckPdf_Set(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[2];

        //        objParams[0] = new SqlParameter("@LinkTckPdf", Rapportini.LinkTckPdf);
        //        objParams[1] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);

        //        //COL_DetRapportini_Edit
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_LinkTckPdf_Set", objParams);
        //    }


        //    public void RiaperturaForzataRapportino_Update(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@InterventoChiuso", Rapportini.InterventoChiuso);
        //        objParams[1] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);
        //        objParams[2] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);

        //        objSqlHelper.ExecuteNonQueryForNews("RiaperturaForzataRapportino_Update", objParams);
        //    }

        //    public void InterventoChiusoFlag_Update(int TicketId, bool InterventoChiuso)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@InterventoChiuso", InterventoChiuso);
        //        objParams[1] = new SqlParameter("@CodRapportino", TicketId);

        //        objSqlHelper.ExecuteNonQueryForNews("InterventoChiusoFlag_Update", objParams);
        //    }

        //    public void TotOreTotTechTestata_Update(int IdTicket, int IdTipoEsecuzione, bool Empty)
        //    {
        //        // devo ottenere il totale in tempo dei tecnici

        //        TCK_DettTecniciTicket _detTec = new TCK_DettTecniciTicket();
        //        _detTec = _detTec.TotaleTempo_e_UM_Get(IdTicket);
        //        double TotaleTempoTck = 0;
        //        // quindi lancio la procedura di calcolo e arrotondamento 
        //        if (!Empty)
        //        {
        //            TotaleTempoTck = _detTec.CalcolaTotaleOre(_detTec.TotaleTempo, _detTec.UM, IdTipoEsecuzione);
        //        }
        //        else
        //        {
        //            TotaleTempoTck = 0;
        //            _detTec.TotTecnici = 0;
        //            _detTec.UM = "Ore";
        //        }
        //        //aggiorno la testata

        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[5];


        //        objParams[0] = new SqlParameter("@CodRapportino", IdTicket);
        //        objParams[1] = new SqlParameter("@TotTecnici", _detTec.TotTecnici);
        //        objParams[2] = new SqlParameter("@TempoInterventoTotale", (float)TotaleTempoTck);
        //        objParams[3] = new SqlParameter("@UM", _detTec.UM);
        //        objParams[4] = new SqlParameter("@TCK_TipoEsecuzione", IdTipoEsecuzione);
        //        objSqlHelper.ExecuteNonQueryForNews("TotOreTotTech_Testata_Update", objParams);
        //    }



        //    public void StatusControlloFatture_Update(TCK_Ticket_v2 Fatture)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[5];

        //        objParams[0] = new SqlParameter("@StatusCotrolloFatt", Fatture.StatusControlloFatt);
        //        objParams[1] = new SqlParameter("@CodRapportino", Fatture.CodRapportino);
        //        objParams[2] = new SqlParameter("@ApprovatoDa", Fatture.ApprovatoDa);
        //        objParams[3] = new SqlParameter("@NoteFatturazioneFinale", Fatture.NoteFatturazioneFinale);
        //        objParams[4] = new SqlParameter("@StatusControlloFatturazioneFinale", Fatture.StatusControlloFatturazioneFinale);

        //        objSqlHelper.ExecuteNonQueryForNews("TCK_StatusControlloFatture_Update", objParams);
        //    }

        //    public void InvioMailCliente_Insert(TCK_Ticket_v2 MailCliente)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@CodCli", MailCliente.CodCliente);
        //        objParams[1] = new SqlParameter("@GuastoRilevato", MailCliente.GuastoRilevato);
        //        objParams[2] = new SqlParameter("@MotivoChiamata", MailCliente.MotivoChiamata);
        //        objSqlHelper.ExecuteNonQueryForNews("InvioMailCliente_Insert", objParams);
        //    }

        //    //update pagina perfeziona_ticket
        //    public void TCK_UpdateCliente_Rapportino(TCK_Ticket_v2 Rapportini)
        //    {

        //        //string firmavuota = "data: image / jpeg; base64,/ 9j / 4AAQSkZJRgABAQAAAQABAAD//gA7Q1JFQVRPUjogZ2QtanBlZyB2MS4wICh1c2luZyBJSkcgSlBFRyB2NjIpLCBxdWFsaXR5ID0gOTAK/9sAQwADAgIDAgIDAwMDBAMDBAUIBQUEBAUKBwcGCAwKDAwLCgsLDQ4SEA0OEQ4LCxAWEBETFBUVFQwPFxgWFBgSFBUU/9sAQwEDBAQFBAUJBQUJFA0LDRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU/8AAEQgA4QEsAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/VKjNFFABmiijNABRRmjNABRR+VJ+VAC0Un5Uv5UAFFJ+VH5UAL/AJ6Uf56UlFAC/j+lH+elJRQAv+elH4/pSUUAL/npR/npSUUAL+P6Uf56UlFAC/56Ufj+lJRQAv8AnpR/npSUUAL/AJ6Uf56UlFAC/wCelH+elJRQAv8AnpR/npSUUAL/AJ6Uf56UlFAC/wCelH+elJRQAv8AnpR/npSUf560ALRR3oP+eKACik/z0paAE/z1paT/AD0paAD86PzoooAPzo/OiigA/Oj86KKAE/z1o/z1pf8APSj/AD0oAT/PWj/PWl/z0o/z0oAT/PWj/PWl/wA9KP8APSgBP89aP89aX/PSj/PSgBP89aP89aX/AD0o/wA9KAE/z1o/z1pf89KP89KAE/z1opf89KP89KAEo/z1pf8APSj/AD0oASil/wA9KP8APSgBP89aKX/PSj/PSgBKP89aX/PSj/PSgBKKX/PSj/PSgBP89aWj/PSj/PSgA70hpe9BoASiiloASij/AD1paACilpKACiiloASiiigA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAP8APWj/AD1o/Oj86AD/AD1o/wA9aPzo/OgA/wA9aP8APWj86PzoAKQ0tIaAClpKWgApaSigAooo/wA9KACiiigAoo/z0ooAWiiigAooooAKKKKACiiigAooooAKKKKAEpaSigAooooAWkoooAKWkooAKKKKAFpKKKAClpKWgBKQ0tIaAClpKWgAoopaAEo/z1oooAKKKKAD/PWiiigBaKKKACiiigAooooAKKKKACiiigAooooASiiloASiiigAopaSgAoopaAEooooAKKWkoAKWkpaAEpDS0hoAKWkpaACiiigAo/z0oo/z1oAKKKKAD/PSij/AD1ooAWiiigAooooAKKKKACiiigAooooAKKKKAEooooAKKKKACiiigAooooAKKKKACiiigApaSloAQ0lKetJQAtJS0UAJRR/nrS0AH+etH+etH50fnQAf560f560fnR+dAB/nrR/nrR+dH50AH+etFFFABR/nrRRQAUUUUAH+etFFFABR/nrRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAAetJSmkoAWiikoAP8APSlpKKAF/wA9KP8APSj/AD1o/wA9aAD/AD0o/wA9KP8APWj/AD1oAP8APSj/AD0o/wA9aP8APWgAoo/z1ooAKKKP89aACiiigAoo/wA9aKACiij/AD1oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAPWkpT1pKAFooooAT/PWlpP8APSloAPzo/Oj/AD0o/wA9KAD86Pzo/wA9KP8APSgA/Oj86P8APSj/AD0oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAA0lKetJQAtJS0UAJRR/nrS0AH+etH+etH50fnQAf560f560fnR+dAB/nrR/nrR+dH50AH+etFFFABR/nrRRQAUUUUAH+etFFFABR/nrRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAAetJSmkoAWiikoAP89KWkooAX/PSj/PSj/PWj/PWgA/z0o/z0o/z1o/z1oAP89KP89KP89aP89aACij/PWigAooo/z1oAKKKKACij/PWigAooo/z1oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAPWkpT1pKAFooooAT/PWlpP89KWgA/Oj86P89KP89KAD86Pzo/z0o/z0oAPzo/Oj/PSj/PSgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAQ/55oFKaQUALRRRQAUUf56UUALRRRQAUUUUAFFFFACUtJRQAUUUUALSUUUAFLSUUAFFFFAC0lFFACUUUf56UAFFFFABRR/npRQAUUUf56UAFFFFABRR/npRQAUf560Uf56UABoFB/zzQKAFooooAKKKKAFooooAKKKKACiiigBKKKWgBKKKKACilpKACiiloASiiigAopaSgBKKKKACiiigAooooAKKKKACiiigAooooAKKKP89aAFPWk7UUUAFFFFAB2ooooAdRRRQAUUUUAFFFFACUd6KKACiiigA70UUUAFHeiigAooooAO9FFFADaKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/9k=";
        //        string firmavuota = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFQAAAA7CAYAAADlya1OAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6Q0EyMkFGRUM3NUNCMTFFNjk3NzZDM0JDRTBFRjYyNjciIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6Q0EyMkFGRUI3NUNCMTFFNjk3NzZDM0JDRTBFRjYyNjciIHhtcDpDcmVhdG9yVG9vbD0iV2luZG93cyBQaG90byBFZGl0b3IgMTAuMC4xMDAxMS4xNjM4NCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ1dWlkOmZhZjViZGQ1LWJhM2QtMTFkYS1hZDMxLWQzM2Q3NTE4MmYxYiIgc3RSZWY6ZG9jdW1lbnRJRD0iMDRBNkIyNDc4QjkxMjVBQTc4NDgwMTdBMzA5NUM4OTEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6E7tyIAAAAZklEQVR42uzQMREAAAgEILV/57eEkwcR6CTFnVEgVKhQhAoVilChQhEqVKhQhAoVilChQhEqVChChQoVilChQhEqVChChQpFqFChQhEqVChChQpFqFChCBUqVChChQpFqNAHVoABAFS/A3O3K7OxAAAAAElFTkSuQmCC";

        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[26];

        //        objParams[0] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[1] = new SqlParameter("@Società", Rapportini.Società);
        //        objParams[2] = new SqlParameter("@PIva", Rapportini.PIva);
        //        objParams[3] = new SqlParameter("@Indirizzo", Rapportini.Indirizzo);
        //        objParams[4] = new SqlParameter("@Cap", Rapportini.Cap);
        //        objParams[5] = new SqlParameter("@Località", Rapportini.Località);
        //        objParams[6] = new SqlParameter("@Provincia", Rapportini.Provincia);
        //        objParams[7] = new SqlParameter("@Telefono", Rapportini.Telefono);
        //        objParams[8] = new SqlParameter("@Fax", Rapportini.Fax);
        //        objParams[9] = new SqlParameter("@Email", Rapportini.Email);
        //        objParams[10] = new SqlParameter("@PersonaDaContattare", Rapportini.PersonaDaContattare);

        //        objParams[11] = new SqlParameter("@TCK_TipoRichiesta", Rapportini.TCK_TipoRichiesta);
        //        objParams[12] = new SqlParameter("@TCK_AreaCompetenza", Rapportini.TCK_AreaCompetenza);
        //        objParams[13] = new SqlParameter("@TCK_TipoEsecuzionePresunta", Rapportini.TCK_TipoEsecuzionePresunta);
        //        objParams[14] = new SqlParameter("@TCK_TipoEsecuzione", Rapportini.TCK_TipoEsecuzione);
        //        objParams[15] = new SqlParameter("@TCK_StatusChiamata", Rapportini.TCK_StatusChiamata);


        //        objParams[16] = new SqlParameter("@MotivoChiamata", Rapportini.MotivoChiamata);
        //        objParams[17] = new SqlParameter("@NomePersonaRiferimento", Rapportini.NomePersonaRiferimento);
        //        objParams[18] = new SqlParameter("@TelPersonaRiferimento", Rapportini.TelPersonaRiferimento);
        //        objParams[19] = new SqlParameter("@MailPersonaRiferimento", Rapportini.MailPersonaRiferimento);

        //        objParams[20] = new SqlParameter("@EditUser", Rapportini.EditUser);

        //        objParams[21] = new SqlParameter("@TCK_PrioritaRichiesta", Rapportini.TCK_PrioritaRichiesta);
        //        objParams[22] = new SqlParameter("@InterventoPresso", Rapportini.InterventoPresso);
        //        objParams[23] = new SqlParameter("@FirmaVuota", firmavuota);
        //        objParams[24] = new SqlParameter("@TCK_StatusChiamataChiusura", Rapportini.TCK_StatusChiamataChiusura);
        //        objParams[25] = new SqlParameter("@InterventoChiuso", Rapportini.InterventoChiuso);
        //        objSqlHelper.ExecuteNonQueryForNews("TCK_UpdateCliente_Rapportino", objParams);


        //    }

        //    public void StatusControlloRegistrazione_Update(TCK_Ticket_v2 Registrazione)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@StatusControlloRegistrazione", Registrazione.StatusControlloRegistrazione);
        //        objParams[1] = new SqlParameter("@CodRapportino", Registrazione.CodRapportino);
        //        objParams[2] = new SqlParameter("@NumeroRegistrazione", Registrazione.NumeroRegistrazione);
        //        objSqlHelper.ExecuteNonQueryForNews("Tck_StatusControlloRegistrazione_Update", objParams);
        //    }

        //    public void UpdateCliente_Rapportini(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[12];

        //        objParams[0] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[1] = new SqlParameter("@Società", Rapportini.Società);
        //        objParams[2] = new SqlParameter("@PIva", Rapportini.PIva);
        //        objParams[3] = new SqlParameter("@Indirizzo", Rapportini.Indirizzo);
        //        objParams[4] = new SqlParameter("@Cap", Rapportini.Cap);
        //        objParams[5] = new SqlParameter("@Località", Rapportini.Località);
        //        objParams[6] = new SqlParameter("@Provincia", Rapportini.Provincia);
        //        objParams[7] = new SqlParameter("@Telefono", Rapportini.Telefono);
        //        objParams[8] = new SqlParameter("@Fax", Rapportini.Fax);
        //        objParams[9] = new SqlParameter("@Email", Rapportini.Email);
        //        objParams[10] = new SqlParameter("@PersonaDaContattare", Rapportini.PersonaDaContattare);
        //        objParams[11] = new SqlParameter("@CodCli", Rapportini.CodCli);

        //        objSqlHelper.ExecuteNonQueryForNews("TCK_TestataTicket_Cliente_Update", objParams);
        //    }

        //    public TCK_Ticket_v2 TCK_TestataTicket_Cliente_Get(string codCli)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[1];
        //        objParams[0] = new SqlParameter("@CodCli", codCli);

        //        //----------------



        //        TCK_Ticket_v2 TCK_TestataTicket_Cliente_Get_Istanza = new TCK_Ticket_v2();
        //        using (SqlDataReader reader = objSqlHelper.ExecuteReader("TCK_TestataTicket_Cliente_Get", objParams))
        //        {
        //            while (reader.Read())
        //            {



        //                TCK_TestataTicket_Cliente_Get_Istanza.Denom = reader.GetString(reader.GetOrdinal("Denom"));





        //                if (reader.IsDBNull(reader.GetOrdinal("Tel"))) { TCK_TestataTicket_Cliente_Get_Istanza.Tel = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Tel = reader.GetString(reader.GetOrdinal("Tel")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("Fax"))) { TCK_TestataTicket_Cliente_Get_Istanza.Fax = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Fax = reader.GetString(reader.GetOrdinal("Fax")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("Riferim"))) { TCK_TestataTicket_Cliente_Get_Istanza.Riferim = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Riferim = reader.GetString(reader.GetOrdinal("Riferim")); }

        //                if (reader.IsDBNull(reader.GetOrdinal("PIva"))) { TCK_TestataTicket_Cliente_Get_Istanza.PIva = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.PIva = reader.GetString(reader.GetOrdinal("PIva")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("EMail"))) { TCK_TestataTicket_Cliente_Get_Istanza.EMail = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.EMail = reader.GetString(reader.GetOrdinal("EMail")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("Loc"))) { TCK_TestataTicket_Cliente_Get_Istanza.Loc = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Loc = reader.GetString(reader.GetOrdinal("Loc")); }

        //                if (reader.IsDBNull(reader.GetOrdinal("Prov"))) { TCK_TestataTicket_Cliente_Get_Istanza.Prov = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Prov = reader.GetString(reader.GetOrdinal("Prov")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("Cap"))) { TCK_TestataTicket_Cliente_Get_Istanza.Cap = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Cap = reader.GetString(reader.GetOrdinal("Cap")); }
        //                if (reader.IsDBNull(reader.GetOrdinal("Ind"))) { TCK_TestataTicket_Cliente_Get_Istanza.Ind = ""; } else { TCK_TestataTicket_Cliente_Get_Istanza.Ind = reader.GetString(reader.GetOrdinal("Ind")); }


        //            }
        //            reader.Close();
        //        }
        //        return TCK_TestataTicket_Cliente_Get_Istanza;
        //    }

        //    public void TCK_PartiSost_King_Update(TCK_Ticket_v2 Rapportini)
        //    {
        //        Sql4Helper objSqlHelper = new Sql4Helper();
        //        SqlParameter[] objParams = new SqlParameter[3];

        //        objParams[0] = new SqlParameter("@CodRapportino", Rapportini.CodRapportino);
        //        objParams[1] = new SqlParameter("@CodArt_King", Rapportini.CodArt_King);
        //        objParams[2] = new SqlParameter("@IdIntervento_King", Rapportini.IdIntervento_King);


        //        objSqlHelper.ExecuteNonQueryForNews("TCK_PartiSost_King_Update", objParams);
        //    }

    }
}