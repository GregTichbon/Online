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
    public partial class Resequence : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Items", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = parameters["Auction_CTR"];
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //Item.Item_CTR, Item.seq, Item.Title, AuctionType.AuctionType
                        string item_ctr = dr["item_ctr"].ToString();
                        string title = dr["title"].ToString();
                        string seq = dr["seq"].ToString();
                        string hide = dr["hide"].ToString();
                        string index = "<input class=\"index\" id=\"_item_index_" + item_ctr + "\" name=\"_item_index_" + item_ctr + "\" type=\"hidden\" value=\"" + seq + "\">";

                        html += "<tr><td>" + title + "<td>" + index + "<span>" + seq + "</span></td><td>" + hide + "</td></tr>";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Dispose();
                con.Close();
                con.Dispose();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            foreach (string fld in Request.Form)
            {
                if (fld.StartsWith("_item_index_"))
                {
                    string item_ctr = fld.Substring(12);
                    string seq = Request.Form[fld];
                    
                    con = new SqlConnection(strConnString);
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "update_item_sequence";
                    cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                    cmd.Parameters.Add("@seq", SqlDbType.VarChar).Value = seq;

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        General.Functions.Functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                     
                }
            }

            Response.Redirect("default.aspx");
        }
    }
}
