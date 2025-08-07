//namespace WebReference4u
//{
using INTRA.AppCode;
using System.Web.Services.Description;

/// <summary>
/// Descrizione di riepilogo per WS_TCK_Ticket
/// </summary>
/// 
public class WS_TCK_Ticket
{
    public WS_TCK_Ticket()
    {
        //
        // TODO: aggiungere qui la logica del costruttore
        //
    }
    public INTRA.Webservice_primo_online.TCK_Ticket_WS GetTicketConvertWebService(INTRA.Webservice_primo_online.TCK_Ticket_WS _obj)
    {
        //MembershipUser edtUsr = Membership.GetUser();
        INTRA.Webservice_primo_online.TCK_Ticket_WS _objWebS = new INTRA.Webservice_primo_online.TCK_Ticket_WS();
        _objWebS.CodRapportino = _obj.CodRapportino;
        _objWebS.Società = _obj.Società;
        _objWebS.CodCliente = _obj.CodCliente;
        _objWebS.Indirizzo = _obj.Indirizzo;
        _objWebS.Cap = _obj.Cap;
        _objWebS.Località = _obj.Località;
        _objWebS.Provincia = _obj.Provincia;
        _objWebS.PIva = _obj.PIva;
        _objWebS.Telefono = _obj.Telefono;
        _objWebS.Fax = _obj.Fax;
        _objWebS.Email = _obj.Email;
        _objWebS.PersonaDaContattare = _obj.PersonaDaContattare;
        _objWebS.TCK_PrioritaRichiesta_etichetta = _obj.TCK_PrioritaRichiesta_etichetta;
        _objWebS.TCK_AreaCompetenza_etichetta = _obj.TCK_AreaCompetenza_etichetta;
        _objWebS.TCK_TipoRichiesta_etichetta = _obj.TCK_TipoRichiesta_etichetta;
        _objWebS.TCK_TipoEsecuzionePresunta_etichetta = _obj.TCK_TipoEsecuzionePresunta_etichetta;
        _objWebS.TCK_TipoEsecuzione_etichetta = _obj.TCK_TipoEsecuzione_etichetta;
        _objWebS.TCK_StatusChiamataChiusura = _obj.TCK_StatusChiamataChiusura;
        _objWebS.TCK_StatusChiamataChiusura_Etichetta = _obj.TCK_StatusChiamataChiusura_Etichetta;
        _objWebS.InterventoChiuso = _obj.InterventoChiuso;
        _objWebS.NoteTecnico = _obj.NoteTecnico;

        _objWebS.TCK_TipoRichiesta = _obj.TCK_TipoRichiesta;
        _objWebS.TCK_AreaCompetenza = _obj.TCK_AreaCompetenza;
        _objWebS.TCK_TipoEsecuzionePresunta = _obj.TCK_TipoEsecuzionePresunta;
        _objWebS.TCK_TipoEsecuzione = _obj.TCK_TipoEsecuzione;
        _objWebS.TCK_StatusChiamata = _obj.TCK_StatusChiamata;
        _objWebS.TCK_PrioritaRichiesta = _obj.TCK_PrioritaRichiesta;
        _objWebS.MotivoChiamata = _obj.MotivoChiamata;
        _objWebS.NomePersonaRiferimento = _obj.NomePersonaRiferimento;
        _objWebS.TelPersonaRiferimento = _obj.TelPersonaRiferimento;
        _objWebS.MailPersonaRiferimento = _obj.MailPersonaRiferimento;

        _objWebS.EditUser = _obj.EditUser;
        _objWebS.InterventoPresso = _obj.InterventoPresso;
        _objWebS.OggettoTCK = _obj.OggettoTCK;
        _objWebS.Tecnici = _obj.Tecnici;
        _objWebS.AssegnatoCalendTecnico = _obj.AssegnatoCalendTecnico;
        _objWebS.DataIntervento = _obj.DataIntervento;
        _objWebS.InizioIntervento = _obj.InizioIntervento;
        _objWebS.FineIntervento = _obj.FineIntervento;
        _objWebS.LinkTckPdf = _obj.LinkTckPdf;

        _objWebS.FirmaTecnico = _obj.FirmaTecnico;

        return _objWebS;
    }

    public static void CapoAreaInvioEmail(INTRA.Webservice_primo_online.TCK_Ticket_WS _TicketWS, string NomeUtente, string nomeTecnici, string Tipo_allegato, int TckStatus)
    {
        // TCK_EmailGest.SendTicketMail(IdTicket, Inviato_CapoArea, NomeUtente, GetTicket, "Null", nomeTecnici, true);
        //INTRA.WebReference4u.WebService_primo _ObjService = new INTRA.WebReference4u.WebService_primo();
        //INTRA.WebReference4u.JsonEmail _JsonEmail = new INTRA.WebReference4u.JsonEmail();
        INTRA.Webservice_primo_online.WebService_primoSoapClient _ObjService = new INTRA.Webservice_primo_online.WebService_primoSoapClient("WebService_primoSoap");
        //WebReference4u.TCK_Ticket _TicketWS = new WebReference4u.TCK_Ticket();
        //_TicketWS = GetTicketConvertWebService(GetTicket);
        _ObjService.SendTicketMailAim(_TicketWS.CodRapportino, TckStatus, NomeUtente, _TicketWS, "Null", nomeTecnici, true, Tipo_allegato, _TicketWS.CodRapportino.ToString());
    }


}
//}