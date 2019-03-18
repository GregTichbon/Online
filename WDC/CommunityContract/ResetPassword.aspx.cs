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
    public partial class ResetPassword : System.Web.UI.Page
    {
        public string actionreference;
        public string legalname;
        public string users_ctr;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["reference"] != null)
                {
                    actionreference = Request.QueryString["reference"];
                    String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                    SqlConnection con = new SqlConnection(strConnString);

                    SqlCommand cmd = new SqlCommand("CC_loginAssistance", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Get Legal Name";
                    cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = actionreference;
                    cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@cc_users_ctr", SqlDbType.BigInt).Value = 0;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = "";

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();
                            users_ctr = dr["cc_users_ctr"].ToString();
                            legalname = dr["legalname"].ToString();
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
                else
                {
                    if (Session["communitycontracts_users_ctr"] != null) {
                        users_ctr = Session["communitycontracts_users_ctr"].ToString();
                        legalname = Session["communitycontractsgroup_legalname"].ToString();
                        actionreference = "N/A";
                    }
                    else
                    {
                        Response.Redirect("default.aspx");
                    }

                }
                if (users_ctr == null)
                {
                    Session["message_title"] = "Community Contracts";
                    Session["message_head"] = "Password reset";
                    Session["message_message"] = "The password reset request has already been actioned.";
                    Session["message_redirect"] = "communitycontract/default.aspx";
                    Response.Redirect("../message.aspx");

                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("CC_loginAssistance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Update Password";
            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@cc_users_ctr", SqlDbType.BigInt).Value = Convert.ToInt64(Request.Form["hf_users_ctr"]);
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = Request.Form["tb_password"].Trim();
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = "";


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

            Response.Redirect("default.aspx");
        }
    }
}