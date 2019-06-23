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
    public partial class User : System.Web.UI.Page
    {

        string user_ctr;
        string fullname;
        string emailaddress;
        string mobilenumber;
        string passcode;
        string textnotifications;
        public Dictionary<string, string> parameters;

        protected void Page_Load(object sender, EventArgs e)
        {
            parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);
            user_ctr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(user_ctr))
            {
                String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_user", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@user_ctr", SqlDbType.Int).Value = user_ctr;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        fullname = dr["fullname"].ToString();
                        emailaddress = dr["emailaddress"].ToString();
                        mobilenumber = dr["mobilenumber"].ToString();
                        passcode = dr["passcode"].ToString();
                        textnotifications = dr["textnotifications"].ToString();
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
            string user_ctr = Request.Form["user_ctr"];
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_user";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@user_ctr", SqlDbType.VarChar).Value = user_ctr;
            //cmd.Parameters.Add("@user", SqlDbType.VarChar).Value = Request.Form["user"];
            //cmd.Parameters.Add("@sequence", SqlDbType.VarChar).Value = Request.Form["sequence"];

            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                dr.Read();
                user_ctr = dr["user_ctr"].ToString();
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

            Response.Redirect("userList.aspx");
        }
    }
}