using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace Online.CommunityContract
{
    public partial class register : System.Web.UI.Page
    {
        #region fields
        public string tb_username;
        public string tb_password;
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            #region fields
            tb_username = Request.Form["tb_username"].Trim();
            tb_password = Request.Form["tb_password"].Trim();
            #endregion


            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_CC_Users";
            cmd.Parameters.Add("@CC_users_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = tb_password;

            cmd.Connection = con;
            try
            {
                con.Open();
                Session["communitycontracts_users_ctr"] = cmd.ExecuteScalar().ToString();
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


            Response.Redirect("groupdetails.aspx");

        }
    }
}