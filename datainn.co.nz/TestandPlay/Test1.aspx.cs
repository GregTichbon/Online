using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace datainn.co.nz.TestandPlay
{
    public partial class Test1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReportDocument rpt = new ReportDocument();
            rpt.Load(MapPath(".") + "\\CrystalReport1.rpt");
            crv_report.ReportSource = rpt;

        }
    }
}