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

namespace Online.Entity
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("online_entity_ctr");
            Session.Remove("online_name");
            Session.Remove("online_emailaddress");
            
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("login", con);
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
                    Session["online_entity_ctr"] = dr["entity_CTR"].ToString();
                    Session["online_name"] = dr["name"].ToString();
                    Session["online_emailaddress"] = dr["emailaddress"].ToString();
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
            if (Session["online_entity_ctr"] != null)
            {
                string folder = Request.QueryString["folder"];
                string form = Request.QueryString["form"];
                string redirect = "~/" + folder + "/" + form + ".aspx";
                if (folder != null)
                {
                    Response.Redirect(redirect);
                }
                else
                {
                    Response.Redirect("account.aspx");
                }
            }
            else
            {
                string message = "Invalid email address / password compination";
            }
           
        }
    }
}