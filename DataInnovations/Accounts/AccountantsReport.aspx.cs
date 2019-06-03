using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Accounts
{
    public partial class AccountantsReport : System.Web.UI.Page
    {
        ReportDocument rpt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string report;
            DataSet ds = new DataSet();
            rpt = new ReportDocument();

            SqlConnection con1 = new SqlConnection(strConnString);
            SqlDataAdapter adp1 = new SqlDataAdapter("Report_Transactions", con1);

            adp1.Fill(ds);
            report = Server.MapPath("~/Accounts/Accountant.rpt");
            rpt.Load(report);
            rpt.SetDataSource(ds.Tables["Table"]);

            crv_report.ReportSource = rpt;
            int PageCount = rpt.FormatEngine.GetLastPageNumber(new ReportPageRequestContext());

            


        }
    }
}