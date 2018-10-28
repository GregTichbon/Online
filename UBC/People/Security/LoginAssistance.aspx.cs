using Generic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Security
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
            Generic.Functions functions = new Functions();

            #region fields
            //cb_password = Request.Form["cb_password"]; //.Trim();
            cb_sendpasswordreset = Request.Form["cb_sendpasswordreset"]; //.Trim();
            cb_sendusername = Request.Form["cb_sendusername"]; //.Trim();
            tb_username = Request.Form["tb_username"];
            tb_emailaddress = Request.Form["tb_emailaddress"];
            #endregion

            string actionreference = "";
            string emailaddress = "";
            string username = "";
            string return_error = "";
            string return_message = "";
            string mode = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "loginAssistance";

            if (cb_sendpasswordreset != null)
            {
                mode = "Password Reset Request";
                actionreference = functions.getReference();
            }
            else
            {
                mode = "Send username";
            }

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;
            cmd.Parameters.Add("@actionreference", SqlDbType.VarChar).Value = actionreference;
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = "";

            /*
     @mode varchar(50),
     @actionreference varchar(50),
     @username varchar(50),
     @emailaddress varchar(100),
     @reference varchar(50),
     @entity_ctr int,
     @password varchar(50)
     */


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();

                    emailaddress = dr["emailaddress"].ToString();
                    username = dr["username"].ToString();
                    return_error = dr["error"].ToString();
                    return_message = dr["message"].ToString();

                    if (return_error != "")
                    {
                        Session["loginassistance_message"] = return_message;
                    }
                    else
                    {
                        Dictionary<string, string> documentvalues = new Dictionary<string, string>();

                        if (mode == "Password Reset Request")
                        {
                            documentvalues["reference"] = actionreference;
                            documentvalues["username"] = username;

                            string host = Request.Url.Scheme + "://" + Request.Url.Authority;
                            documentvalues["host"] = host;

                            string folder = "";
                            if (Request.Url.Host != "localhost")
                            {
                                folder = "OnlineTest";
                                string webconfig = ConfigurationManager.AppSettings["ConfigName"];
                                if (webconfig == "")
                                {
                                    folder = "Online";
                                }
                            }
                            documentvalues["folder"] = folder;

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
                                functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");

                            }

                            //emailbodydocument = functions.documentfill(emailbodydocument, documentvalues);

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
                                functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");

                            }

                            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
                            functions.sendemail("Union Boat Club Password Reset", emaildocument, "", emailaddress,"");
                            functions.sendemailV2("HostName","Email from","password","Union Boat Club Password Reset", "emailText", emaildocument, "", emailaddress, "Email BCC","");

                            Session["message_title"] = "";
                            Session["message_head"] = "Password reset";
                            Session["message_message"] = "An email has been sent to " + emailaddress + ".";
                            Session["message_redirect"] = "security/login.aspx";
                            Response.Redirect("../message.aspx");
                        }
                        else
                        {
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
                                functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");

                            }

                            //emailbodydocument = functions.documentfill(emailbodydocument, documentvalues);

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
                                functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");

                            }

                            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

                            functions.sendemail("Whanganui District Council - xxxxxx Request", emaildocument, emailaddress, "","");
                            functions.sendemailV2("HostName", "Email from", "password", "Union Boat Club Password Reset", "emailText", emaildocument, "", emailaddress, "Email BCC", "");
                        }
                    }
                }
                else
                {
                    Session["message_title"] = "";
                    Session["message_head"] = "Incorrect information submitted";
                    Session["message_message"] = "";
                    Session["message_redirect"] = "loginassistance.aspx";
                    Response.Redirect("../message.aspx");
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
