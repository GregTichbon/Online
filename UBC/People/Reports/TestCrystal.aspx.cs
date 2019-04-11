using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class TestCrystal : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";


            string r = Request.QueryString["id"]; 
            string report;
            DataSet ds = new DataSet();
            ReportDocument rpt = new ReportDocument();


            switch (r)
            {
                case "1":
                    SqlConnection con1 = new SqlConnection(strConnString);
                    SqlDataAdapter adp1 = new SqlDataAdapter("Report_RegattaTransactions", con1);
                    adp1.Fill(ds);
                    report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
                    rpt.Load(report);
                    rpt.SetDataSource(ds.Tables["Table"]);
                    break;
                case "2":
                    SqlConnection con2 = new SqlConnection(strConnString);
                    SqlDataAdapter adp2 = new SqlDataAdapter("select * from person", con2);
                    adp2.Fill(ds);
                    report = Server.MapPath("~/people/reports/crystal/Simple1.rpt");
                    rpt.Load(report);
                    rpt.SetDataSource(ds.Tables["Table"]);
                    break;
                case "3":
                    report = Server.MapPath("~/people/reports/crystal/testNoData.rpt");
                    rpt.Load(report);
                    break;
                default:
                    break;
            }

            //Response.Write(report);
          
            //int x = ds.Tables["Table"].Rows.Count;
            //Response.Write(x.ToString());

            crv_report.ReportSource = rpt;
        }

        protected void crv_report_Init(object sender, EventArgs e)
        {

        }
    }
}