using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction.Administration
{
    public partial class ItemBids : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            string item_ctr;
            string created;
            double amount;
            double autobid;
            string fullname;

            item_ctr = Request.QueryString["item"];

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_ItemBids", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@item_ctr", SqlDbType.Int).Value = item_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //B.created, B.amount, B.autobid, U.user_ctr, U.fullname, U.EmailAddress, U.MobileNumber
                        created = dr["created"].ToString();
                        amount = Convert.ToDouble(dr["amount"]);
                        autobid = Convert.ToDouble(dr["autobid"]);
                        fullname = dr["fullname"].ToString();

                        html += "<tr><td>" + created + "</td><td>" + fullname + "</td><td>" + amount.ToString("0.00") + "</td><td>" + autobid.ToString("0.00") + "</td></tr>";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Close();
                con.Close();
                con.Dispose();
            }
        }
    }
}