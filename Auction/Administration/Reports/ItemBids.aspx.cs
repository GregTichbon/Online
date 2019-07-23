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


namespace Auction.Administration.Reports
{
    public partial class ItemBids : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            String ConnectionString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            ReportDocument rpt = new ReportDocument();
            rpt.Load(MapPath(".") + "\\CR_itembids.rpt");

            SqlConnection con = new SqlConnection(ConnectionString);

            DataSet ds = new DataSet();


            SqlCommand cmd1 = new SqlCommand("get_AllItem_bids", con);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd1.Parameters.Add("@order", SqlDbType.VarChar).Value = "-1";
           
            SqlDataAdapter adp1 = new SqlDataAdapter();
            adp1.SelectCommand = cmd1;

            DataTable dataTable1 = new DataTable();
            dataTable1.TableName = "get_AllItem_bids";

            adp1.Fill(dataTable1);
            ds.Tables.Add(dataTable1);
            /*
            SqlCommand cmd2 = new SqlCommand("get_AllItem_bids", con);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd2.Parameters.Add("@order", SqlDbType.VarChar).Value = "-1";

            SqlDataAdapter adp2 = new SqlDataAdapter();
            adp2.SelectCommand = cmd2;

            DataTable dataTable2 = new DataTable();
            dataTable2.TableName = "xxxxxxx";

            adp2.Fill(dataTable2);
            ds.Tables.Add(dataTable2);
            */

            //int x10 = dataTable2.Rows.Count;
            //string x5 = ds.Tables[0].TableName;
            //string x6 = ds.Tables[1].TableName;

            rpt.SetDataSource(ds);

            crv_report.ReportSource = rpt;
            //crv_report.Refresh();
        }
    }
}