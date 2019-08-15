using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class MastersCommunicate : System.Web.UI.Page
    {
        public string html;
        public string response = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                if (Session["UBC_person_id"] == null)
                {
                    Response.Redirect("~/people/security/login.aspx");
                }
                if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1000001"))
                {
                    Response.Redirect("~/default.aspx");
                }

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                Functions genericfunctions = new Functions();

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Get_MastersCommunications", con);

                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = con;
                //try
                {
                    con.Open();
                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {

                        html = "<tr><td colspan=\"2\">Person</td><td>Send Text</td><td>Send Email</td>"; 

                        while (dr.Read())
                        {
                            string id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string firstname = dr["firstname"].ToString();
                            string mobile = dr["mobile"].ToString();
                            string email = dr["email"].ToString();
                            string person_guid = dr["person_guid"].ToString();


                            string person = "<a href=\"http://private.unionboatclub.co.nz/people/maint.aspx?id=" + person_guid + "\" target=\"link\">" + name + "</a>";
                            string image = "<img src=\"Images/" + id + ".jpg\" style=\"height: 50px\" />";

                            string sendemail = "";
                            //string sendemaillink = "";
                            if (email != "")
                            {
                                string delim = "";
                                //string[] emailsplit = email.Split('|');
                                foreach (string emailsplit in email.Split('|'))
                                {
                                    string address = emailsplit.Split('~')[0];
                                    string note = emailsplit.Split('~')[1];
                                    if (note != "")
                                    {
                                        note = " - " + note;
                                    }
                                    sendemail += delim + "<input name =\"cb_email_" + id + "\" type=\"checkbox\"  value=\"" + address + "\" /> <a href=\"mailto:" + address + "\">" + address + "</a>" + note;
                                    //sendemaillink += "<a href=\"mailto:" + address + "\">" + address + note + "</a>" + delim;
                                    delim = "<br />";
                                }
                            }
                            string sendtext = "";
                            if (mobile != "")
                            {
                                string delim = "";
                                //string[] mobilesplit = mobile.Split('|');
                                foreach (string mobilesplit in mobile.Split('|'))
                                {
                                    string number = mobilesplit.Split('~')[0];
                                    string note = mobilesplit.Split('~')[1];
                                    if (note != "")
                                    {
                                        note = " - " + note;
                                    }
                                    sendtext = delim + "<input name =\"cb_text_" + id + "\" type=\"checkbox\" value=\"" + number + "\" /><a href=\"tel:" + number + "\">" + number + "</a>" + note;
                                    //mobile = "<a href=\"tel:" + mobile + "\">" + mobile + "</>";
                                    delim = "<br />";
                                }
                            }
                            html += "<tr class=\"tr_person\">";
                            html += "<td>" + image + "</td>";
                            html += "<td>" + person + "</td><td>" + sendtext + "</td><td>" + sendemail + "</td>";

                            html += "</tr>" + "\r\n";


                        }
                    }

                    dr.Close();
                }

                //catch (Exception ex)
                {
                    //throw ex;
                }
                //finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
           
            if (1 == 1)
            {
                //Functions funcs = new Functions();
                Generic.Functions gFunctions = new Generic.Functions();

                //string emailbodyTemplate = "RegisterEmail.xslt";
                string emailBCC = "";
                //string screenTemplate = "RegisterScreen.xslt";
                //string host = "datainn.co.nz";
                string host = "70.35.207.87";
                string emailfrom = "UnionBoatClub@datainn.co.nz";
                string emailfromname = "Union Boat Club";
                string password = "39%3Zxon";

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497;MultipleActiveResultSets=True";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Get_MastersCommunications", con);

                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {
                        //html = "<tr><td>Student</td><td>Send Text</td><td>Send Email</td><td>Facebook</td><td>Caregiver</td><td>Send mobile</td><td>Send Email</td><td>Facebook</td><td>Link</td><td>Coming</td><td>Modified</td></tr>";
                        while (dr.Read())
                        {
                            string id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string firstname = dr["firstname"].ToString();
                            //string mobile = dr["mobile"].ToString();
                            //string email = dr["email"].ToString();
                            //string category = dr["category"].ToString();
                            //string categories = dr["categories"].ToString();
                            string person_guid = dr["person_guid"].ToString();
                            string emailhtml = "";
                            string textmessage = "";

                            string link = "<a href=\"http://private.unionboatclub.co.nz/person/maint.aspx?id=" + person_guid + "\" target=\"link\">Link</a>";

                            if (Request.Form["cb_email_" + id] + "" != "")
                            {
                                string emailRecipient = Request.Form["cb_email_" + id];


                                emailhtml = tb_htmlbody.Text;
                                emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailhtml = emailhtml.Replace("||firstname||", firstname);
                                emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";

                                gFunctions.sendemailV3(host, emailfrom, emailfromname, password, tb_subject.Text, emailhtml, emailRecipient, emailBCC, "");
                            }
                            if (Request.Form["cb_text_" + id] + "" != "")
                            {
                                string mobiles = Request.Form["cb_text_" + id];
                                textmessage = tb_txt.Text;
                                textmessage = textmessage.Replace("||link||", link);
                                textmessage = textmessage.Replace("||firstname||", firstname);
                                foreach (string mobile in mobiles.Split(';'))
                                {
                                    response += gFunctions.SendRemoteMessage(mobile, textmessage, "UBC Communications") + "<br />";
                                }
                            }

                            if (emailhtml != "" || textmessage != "")
                            {
                                SqlCommand cmd2 = new SqlCommand("Insert_Person_communication", con);
                                cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = id;
                                cmd2.Parameters.Add("@emailtext", SqlDbType.VarChar).Value = Request.Form["cb_email_" + id] + "<br />"; // + emailtext;
                                cmd2.Parameters.Add("@emailhtml", SqlDbType.VarChar).Value = Request.Form["cb_email_" + id] + "<br />" + emailhtml;
                                cmd2.Parameters.Add("@textmessage", SqlDbType.VarChar).Value = Request.Form["cb_text_" + id] + "<br />" + textmessage;
                                cmd2.Parameters.Add("@facebookmessage", SqlDbType.VarChar).Value = "";
                                cmd2.CommandType = CommandType.StoredProcedure;
                                cmd2.Connection = con;
                                //con.Open();
                                string result = cmd2.ExecuteScalar().ToString();
                                //SqlDataReader dr2 = cmd1.ExecuteReader();
                                cmd2.Dispose();
                            }
                        }
                    }

                    dr.Close();
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
        }

    }
}
