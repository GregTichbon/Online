using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction
{
    public partial class Register : System.Web.UI.Page
    {
        public string TermsAndConditions;
        Dictionary<string, string> parameters;

        protected void Page_Load(object sender, EventArgs e)
        {
           
            parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);
            TermsAndConditions = parameters["TermsAndConditions"];
        }
        /*
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_User", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];   //Should we allow users to access all auctions?
            cmd.Parameters.Add("@fullname", SqlDbType.VarChar).Value = Request.Form["fullname"];
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = Request.Form["emailaddress"];
            cmd.Parameters.Add("@passcode", SqlDbType.VarChar).Value = Request.Form["passcode"];
            cmd.Parameters.Add("@mobilenumber", SqlDbType.VarChar).Value = Request.Form["mobilenumber"];
            cmd.Parameters.Add("@textnotifications", SqlDbType.VarChar).Value = Request.Form["textnotifications"];
            cmd.Parameters.Add("@contactpermission", SqlDbType.VarChar).Value = Request.Form["contactpermission"];

            cmd.Connection = con;
            try
            {
                con.Open();
                string user_ctr = cmd.ExecuteScalar().ToString();
                
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
        */
    }
}