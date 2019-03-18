using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Contractor
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("online_contractor_ctr");
            Session.Remove("online_contractorname");
            Session.Remove("online_contractoremailaddress");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("contractor_login", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@usernameemailaddress", SqlDbType.VarChar).Value = Request.Form["tb_usernameemailaddress"].Trim();
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = Request.Form["tb_password"].Trim();


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    Session["online_contractor_ctr"] = dr["contractor_CTR"].ToString();
                    Session["online_contractorname"] = dr["name"].ToString();
                    Session["online_contractoremailaddress"] = dr["emailaddress"].ToString();
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
            if (Session["online_contractor_ctr"] != null)
            {
                string folder = Request.QueryString["folder"];
                if (folder != null)
                {
                    string form = Request.QueryString["form"];
                    string redirect = "~/" + folder + "/" + form + ".aspx";

                    string rq = "";
                    if (Request.QueryString["showfields"] != null)
                    {
                        rq += "&showfields=" + Request.QueryString["showfields"];
                    }
                    if (Request.QueryString["populate"] != null)
                    {
                        rq += "&populate=" + Request.QueryString["populate"];
                    }

                    var regex = new Regex(Regex.Escape("&"));
                    rq = regex.Replace(rq, "?", 1);

                    Response.Redirect(redirect + rq);
                }
                else
                {
                    Response.Redirect("contractor.aspx");
                }
            }
            else
            {
                //string message = "Invalid user name / email address and password combination";
                Session["message_title"] = "Log in";
                Session["message_head"] = "Access denied";
                Session["message_message"] = "Invalid user name / email address and password combination";
                Session["message_redirect"] = "contractor/login.aspx";
                Response.Redirect("../message.aspx");
            }

        }
    }
}