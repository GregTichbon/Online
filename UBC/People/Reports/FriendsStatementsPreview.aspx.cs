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

namespace UBC.People.Reports
{
    public partial class FriendsStatementsPreview : System.Web.UI.Page
    {
        ReportDocument rpt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string report;
            DataSet ds = new DataSet();
            rpt = new ReportDocument();

            SqlConnection con1 = new SqlConnection(strConnString);
            SqlDataAdapter adp1 = new SqlDataAdapter("Report_Person_Transactions", con1);
            //SqlDataAdapter adp1 = new SqlDataAdapter("Report_RegattaTransactions", con1);
            string person_id = Request.QueryString["id"].ToString();
            if (person_id != "")
            {
                adp1.SelectCommand.Parameters.Add("@person_id", SqlDbType.VarChar,10).Value = person_id;
            }

            adp1.Fill(ds);
            report = Server.MapPath("~/people/reports/crystal/FriendsStatements.rpt");
            //report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
            rpt.Load(report);
            rpt.SetDataSource(ds.Tables["Table"]);

            crv_report.ReportSource = rpt;
            int PageCount = rpt.FormatEngine.GetLastPageNumber(new ReportPageRequestContext());

            ExportOptions CrExportOptions;
            DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
            PdfRtfWordFormatOptions CrFormatTypeOptions = new PdfRtfWordFormatOptions();
            CrDiskFileDestinationOptions.DiskFileName = "C:\\inetpub\\ubc.org.nz\\people\\test.pdf";
            CrExportOptions = rpt.ExportOptions;

            CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
            CrExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
            CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
            CrFormatTypeOptions.UsePageRange = true;

            CrFormatTypeOptions.FirstPageNumber = 1;
            CrFormatTypeOptions.LastPageNumber = 1;

            CrExportOptions.FormatOptions = CrFormatTypeOptions;

            rpt.Export();


        }
    }
}