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
    public partial class UserItemsBidOn : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            string item_ctr;
            string title;
            string created;

            string user_ctr = Request.QueryString["user"];

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_UserItemsBidOn", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@user_ctr", SqlDbType.Int).Value = user_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        item_ctr = dr["item_ctr"].ToString();
                        title = dr["title"].ToString();
                        created = dr["created"].ToString();

                        html += "<tr><td><a target=\"_blank\" href=\"item.aspx?id=" + item_ctr + "\">" + title + "</a><td>" + created + "</td><td class=\"itembids\" id=\"item_" + item_ctr + "\">View</a></td></tr>";
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