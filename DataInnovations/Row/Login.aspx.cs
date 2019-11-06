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
using System.Text.RegularExpressions;

namespace DataInnovations.Row
{
    public partial class Login : System.Web.UI.Page
    {
        public string url;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("Row_User_CTR");
            Session.Remove("Row_User_name");
            Session.Remove("Row_AccessString");

            url = Request.QueryString["return"] ?? "";
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            /*
            Functions functions = new Functions();

            System.Web.HttpBrowserCapabilities browser = Request.Browser;

            string browserdetails = functions.BrowserDetails(browser);
            */
            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("login", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = Request.Form["tb_username"].Trim();
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = Request.Form["tb_password"].Trim();
            //cmd.Parameters.Add("@browserdetails", SqlDbType.VarChar).Value = browserdetails;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    Session["Row_User_CTR"] = dr["user_ctr"].ToString();
                    Session["Row_User_name"] = dr["name"].ToString();
                    Session["Row_AccessString"] = dr["AccessString"].ToString();
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
            if (Session["Row_User_CTR"] != null)
            {
                string redirect = "default.aspx";
                if (url != "")
                {
                    redirect = url;
                }
                Response.Redirect(redirect);
            }
            else
            {
                Session["message_title"] = "Log in";
                Session["message_head"] = "Access denied";
                Session["message_message"] = "Invalid user name and password combination";
                Session["message_redirect"] = "login.aspx";
                Response.Redirect("../message.aspx");
            }

        }
    }
}