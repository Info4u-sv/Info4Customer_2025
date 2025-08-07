using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descrizione di riepilogo per FatturazioneFinale
/// </summary>
public class FatturazioneFinale
{
    public string CodRapportino { get; set; }
    public string DescrizioneArea { get; set; }
    public string Società { get; set; }
    public string OggettoTCK { get; set; }
    public string Tecnico { get; set; }
    public DateTime CreatedOn { get; set; }
    public string Stato { get; set; }
    public string TempoTotale { get; set; }
    public string UM { get; set; }
}