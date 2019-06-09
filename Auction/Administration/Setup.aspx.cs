using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction.Administration
{
    public partial class Setup : System.Web.UI.Page
    {

        public static string auction_ctr;
        public string auction;
        public string message;
        public string increment;
        public string openfrom;
        public string closeat;
        public string termsandconditions;
        public string url;
        public string auctiontype;
        public string emailalerts;
        public string textalerts;

        public string[] auctiontype_values = new string[2] { "Silent", "Live" };

        public Dictionary<string, string> parameters;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

                auction_ctr = parameters["Auction_CTR"];
                auction = parameters["Auction"];
                message = parameters["Message"];
                increment = parameters["Increment"];
                openfrom = parameters["OpenFrom"];
                closeat = parameters["Closeat"];
                termsandconditions = parameters["TermsAndConditions"];
                url = parameters["URL"];
                auctiontype = parameters["AuctionType"];
                emailalerts = parameters["emailalerts"];
                textalerts = parameters["textalerts"];
            }


        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_Auction";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = auction_ctr;
            cmd.Parameters.Add("@auction", SqlDbType.VarChar).Value = Request.Form["auction"];
            cmd.Parameters.Add("@message", SqlDbType.VarChar).Value = Request.Form["message"];
            cmd.Parameters.Add("@increment", SqlDbType.VarChar).Value = Request.Form["increment"];
            cmd.Parameters.Add("@openfrom", SqlDbType.VarChar).Value = Request.Form["openfrom"];
            cmd.Parameters.Add("@closeat", SqlDbType.VarChar).Value = Request.Form["closeat"];
            cmd.Parameters.Add("@termsandconditions", SqlDbType.VarChar).Value = Request.Form["termsandconditions"];
            cmd.Parameters.Add("@url", SqlDbType.VarChar).Value = Request.Form["url"];
            cmd.Parameters.Add("@auctiontype", SqlDbType.VarChar).Value = Request.Form["auctiontype"];
            cmd.Parameters.Add("@emailalerts", SqlDbType.VarChar).Value = Request.Form["emailalerts"];
            cmd.Parameters.Add("@textalerts", SqlDbType.VarChar).Value = Request.Form["textalerts"];


            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                dr.Read();
                //item_ctr = dr["item_ctr"].ToString();
            }
            //}
            //catch (Exception ex)
            //{
            //    General.Functions.Functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");
            //}
            //finally
            //{
            con.Close();
            con.Dispose();
            //}
            Response.Redirect(Request.RawUrl);
        }
    }
}