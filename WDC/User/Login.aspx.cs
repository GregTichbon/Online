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

namespace Online.User
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("wdc_entity_ctr");
            Session.Remove("wdc_name"); 

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("CC_login", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = Request.Form["tb_emailaddress"].Trim();
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = Request.Form["tb_password"].Trim();


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    Session["wdc_entity_ctr"] = dr["entity_CTR"].ToString();
                    Session["wdc_name"] = dr["name"].ToString();
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
            if (Session["wdc_entity_ctr"] != null)
            {
                Response.Redirect("../home.aspx");
            }
            else
            {
                string message = "Invalid username / password compination";
            }
        }
    }
}