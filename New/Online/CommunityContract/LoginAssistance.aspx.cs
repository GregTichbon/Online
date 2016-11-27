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
    public partial class LoginAssistance : System.Web.UI.Page
    {
        #region fields
        //public string cb_password;
        public string cb_sendpasswordreset;
        public string cb_sendusername;
        public string tb_username;
        public string tb_emailaddress;
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region fields
            //cb_password = Request.Form["cb_password"]; //.Trim();
            cb_sendpasswordreset = Request.Form["cb_sendpasswordreset"]; //.Trim();
            cb_sendusername = Request.Form["cb_sendusername"]; //.Trim();
            tb_username = Request.Form["tb_username"]; //.Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"];
            #endregion

            string reference = "";
            string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];
            string actionreference = "";
            string emailaddress = "";
            string legalname = "";
            string username = "";
            string return_error = "";
            string return_message = "";
            string mode = "";

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "cc_loginAssistance";

            if (cb_sendpasswordreset != null)
            {
                mode = "Password Reset Request";
                actionreference = WDCFunctions.getReference();
            }
            else
            {
                mode = "Send username";
            }

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;
            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;
            cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = actionreference;
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@cc_users_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();

                    emailaddress = dr["emailaddress"].ToString();
                    legalname = dr["legalname"].ToString();
                    username = dr["username"].ToString();
                    return_error = dr["error"].ToString();
                    return_message = dr["message"].ToString();

                    if (return_error == "")
                    {
                        Session["communitycontracts_loginassistance_message"] = "An email has been sent to: " + emailaddress;
                    }
                    else
                    {
                        Session["communitycontracts_loginassistance_message"] = return_message;
                    }


                    Dictionary<string, string> documentvalues = new Dictionary<string, string>();

                    if (mode == "Password Reset Request")
                    {
                        documentvalues["reference"] = actionreference;
                        documentvalues["legalname"] = legalname;

                        string path = Server.MapPath(".");
                        string emailbodypath = path + "\\LoginAssistancePasswordResetEmail.html";
                        string emailbodydocument = "";

                        try
                        {
                            using (StreamReader sr = new StreamReader(emailbodypath))
                            {
                                emailbodydocument = sr.ReadToEnd();
                            }
                        }
                        catch (Exception ex)
                        {
                            WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                        }

                        //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill email", "");
                        WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
                        emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

                        //THE EMAIL TEMPLATE
                        path = Server.MapPath("..");
                        string emailtemplate = path + "\\EmailTemplate\\standard.html";
                        string emaildocument = "";

                        try
                        {
                            using (StreamReader sr = new StreamReader(emailtemplate))
                            {
                                emaildocument = sr.ReadToEnd();
                            }
                        }
                        catch (Exception ex)
                        {
                            WDCFunctions.Log(Request.RawUrl, ex.Message, "");
                        }

                        WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
                        emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

                        WDCFunctions.sendemail("Whanganui District Council Community Contracts - Password Reset", emaildocument, emailaddress, "");
                    }
                    else
                    {
                        documentvalues["legalname"] = legalname;
                        documentvalues["username"] = username;

                        string path = Server.MapPath(".");
                        string emailbodypath = path + "\\LoginAssistanceSendUsernameEmail.html";
                        string emailbodydocument = "";

                        try
                        {
                            using (StreamReader sr = new StreamReader(emailbodypath))
                            {
                                emailbodydocument = sr.ReadToEnd();
                            }
                        }
                        catch (Exception ex)
                        {
                            WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                        }

                        //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill email", "");
                        WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
                        emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

                        //THE EMAIL TEMPLATE
                        path = Server.MapPath("..");
                        string emailtemplate = path + "\\EmailTemplate\\standard.html";
                        string emaildocument = "";

                        try
                        {
                            using (StreamReader sr = new StreamReader(emailtemplate))
                            {
                                emaildocument = sr.ReadToEnd();
                            }
                        }
                        catch (Exception ex)
                        {
                            WDCFunctions.Log(Request.RawUrl, ex.Message, "");
                        }

                        WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
                        emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

                        WDCFunctions.sendemail("Whanganui District Council Community Contracts - Username Request", emaildocument, emailaddress, "");
                    }




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




            //Response.Redirect("resetpassword.aspx?reference=" + reference);

        }

    }
}