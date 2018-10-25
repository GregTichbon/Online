using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Security
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        public string actionreference;
        public string name;
        public string entity_ctr;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["reference"] != null)
                {
                    actionreference = Request.QueryString["reference"];
                    string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                    SqlConnection con = new SqlConnection(strConnString);

                    SqlCommand cmd = new SqlCommand("loginAssistance", con);
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Get User Details";
                    cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = actionreference;
                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@entity_ctr", SqlDbType.Int).Value = 0;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = "";

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();
                            entity_ctr = dr["entity_ctr"].ToString();
                            name = dr["FirstName"].ToString() + " " + dr["Lastname"].ToString() + " (" + dr["Username"].ToString() + ")";
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

                    if (entity_ctr == null)
                    {
                        Session["message_title"] = "";
                        Session["message_head"] = "Password reset";
                        Session["message_message"] = "The password reset request has already been actioned.";
                        Session["message_redirect"] = "entity/login.aspx";
                        Response.Redirect("../message.aspx");

                    }
                }

                /*
                    Session["online_entity_ctr"] = dr["entity_CTR"].ToString();
                    Session["online_name"] = dr["name"].ToString();
                    Session["online_emailaddress"] = dr["emailaddress"].ToString();
                 */
                else
                {
                    if (Session["online_entity_ctr"] != null)
                    {
                        Response.Redirect("account.aspx");
                    }
                    else
                    {
                        Response.Redirect("login.aspx");
                    }

                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("loginAssistance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Update Password";
            cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@entity_ctr", SqlDbType.BigInt).Value = Convert.ToInt64(Request.Form["hf_entity_ctr"]);
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = Request.Form["tb_password"].Trim();


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //Needs to verify done
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

            Session["message_title"] = "";
            Session["message_head"] = "Password reset";
            Session["message_message"] = "Your password has been reset.";
            Session["message_redirect"] = "entity/login.aspx";
            Response.Redirect("../message.aspx");
        }
    }
}