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
    public partial class Category : System.Web.UI.Page
    {
        public string category_ctr;
        public string category;
        public string sequence;
        public Dictionary<string, string> parameters;

        protected void Page_Load(object sender, EventArgs e)
        {
            parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);
            category_ctr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(category_ctr))
            {
                String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_Category", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@category_ctr", SqlDbType.Int).Value = category_ctr;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        category = dr["category"].ToString();
                        sequence = dr["sequence"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

     

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string category_ctr = Request.Form["category_ctr"];
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_Category";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@category_ctr", SqlDbType.VarChar).Value = category_ctr;
            cmd.Parameters.Add("@category", SqlDbType.VarChar).Value = Request.Form["category"];
            cmd.Parameters.Add("@sequence", SqlDbType.VarChar).Value = Request.Form["sequence"];

            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                dr.Read();
                category_ctr = dr["category_ctr"].ToString();
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
            
            Response.Redirect("CategoryList.aspx");
        }
    }
}