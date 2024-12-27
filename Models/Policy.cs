using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Policy
/// </summary>
public class Policy
{

    public int Policy_ID { get; set; }
    public string PolicyNumber { get; set; }
    public decimal PolicyAmount { get; set; }
    public int Partner_ID { get; set; }

    public Policy()
    {
    
    }
}