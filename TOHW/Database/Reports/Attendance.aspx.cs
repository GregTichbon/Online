using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Database.Reports
{
    public partial class Attendance1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            ReportDocument rpt = new ReportDocument();


            SqlConnection sqlconn = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            SqlCommand sqlcmd = new SqlCommand("Report_Attendance_Summary", sqlconn);
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.AddWithValue("@fromdate", tb_fromdate.Text);
            sqlcmd.Parameters.AddWithValue("@todate", tb_todate.Text);

            sda.SelectCommand = sqlcmd;
            DataSet ds = new DataSet();
            sda.Fill(ds);

            string report = Server.MapPath("~/database/reports/Attendance.rpt");
            Response.Write(report);
            rpt.Load(report);
            rpt.SetDataSource(ds.Tables["Table"]);

            /*

            SqlConnection con1 = new SqlConnection(strConnString);
            SqlDataAdapter adp1 = new SqlDataAdapter("Report_Attendance_Summary", con1);
            adp1.CommandType = CommandType.StoredProcedure;
            adp1.SelectCommand.Parameters.AddWithValue("@fromdate", tb_fromdate.Text);
            adp1.SelectCommand.Parameters.AddWithValue("@todate", tb_todate.Text);

            adp1.Fill(ds);
            report = Server.MapPath("~/database/reports/Attendance.rpt");
            rpt.Load(report);
            rpt.SetDataSource(ds.Tables["Table"]);
            */

            /*
            ReportParameter[] rPrams = new ReportParameter[2];
            rPrams[0] = new ReportParameter("startDate", this.txtStartDate.Text);
            rPrams[1] = new ReportParameter("endDate", this.txtEndDate.Text);
            this.ReportViewer1.LocalReport.SetParameters(rPrams);

            this.ReportViewer1.LocalReport.Refresh();
            this.ReportViewer1.Visible = true;
            */

            //Response.Write(report);

            //int x = ds.Tables["Table"].Rows.Count;
            //Response.Write(x.ToString());

            crv_report.ReportSource = rpt;
        }
    }
}
 