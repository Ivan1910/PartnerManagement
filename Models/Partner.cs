using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Partner
/// </summary>
public class Partner
{
    public int Partner_ID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Address { get; set; }
    public string PartnerNumber { get; set; }
    public string CroatianPIN { get; set; }
    public int PartnerType_ID { get; set; }
    public DateTime CreatedAtUtc { get; set; }
    public string CreatedByUser { get; set; }
    public Boolean IsForeign { get; set; }
    public string ExternalCode { get; set; }
    public char Gender { get; set; }

    public Partner()
    {

    }
}