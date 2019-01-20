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
    public partial class Communicate2 : System.Web.UI.Page
    {
        public string html;
        public string html_facebook;
        public string categories;

        public string categories_values;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
            {
                Response.Redirect("~/default.aspx");
            }
            */

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
            categories = "";
            functionoptions.Clear();
            functionoptions.Add("storedprocedure", "");
            functionoptions.Add("usevalues", "");
            categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Communications", con);
            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = tb_event_id.Text;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            //try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<tr><td colspan=\"2\">Person</td><td>Send Text</td><td>Send Email</td><td>Facebook</td><td>Relations</td><td>Attendance</td>"; //<td>Send mobile</td><td>Send Email</td><td>Facebook</td><td>Link</td><td>Coming</td><td>Modified</td></tr>";

                    while (dr.Read())
                    {
                        string id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string facebook = dr["facebook"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string email = dr["email"].ToString();
                        string category = dr["category"].ToString();
                        string categories = dr["categories"].ToString();
                        string person_guid = dr["person_guid"].ToString();
                        string attendance = dr["attendance"].ToString();
                        string role = dr["role"].ToString();
                        string relationships = dr["relationships"].ToString();


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

                        string sendfacebook = "";
                        string facebooklink = "";
                        if (facebook != "")
                        {
                            sendfacebook = "<input id=\"cb_facebook_" + id + "\" name =\"cb_facebook_" + id + "\" type=\"checkbox\" />";
                            facebooklink = "<a href=\"" + facebook + "\" target=\"Facebook\">Facebook</a>";
                        }

 
                        string rline = "";
                        if (relationships != "")
                        {
                            foreach (string relation in relationships.Split('\\'))
                            {
                                string rid = relation.Split('^')[0];
                                string rrelationship = relation.Split('^')[1];
                                string rname = relation.Split('^')[2];
                                string rfirstname = relation.Split('^')[3];
                                string rnote = relation.Split('^')[4];
                                if (rnote != "")
                                {
                                    rnote = " - " + rnote;
                                }
                                rline += "<b>" + rname + "</b> " + rrelationship + rnote + "<br />";

                                string rphones = relation.Split('^')[5];
                                if (rphones != "")
                                {
                                    foreach (string rphone in rphones.Split('|'))
                                    {
                                        string rphonenumber = rphone.Split('~')[0];
                                        string rphonenote = rphone.Split('~')[1];
                                        if (rphonenote != "")
                                        {
                                            rphonenote = " - " + rphonenote;
                                        }
                                        rline += "<input name =\"cb_rtext_" + id + "\" type=\"checkbox\"  value=\"" + rphonenumber + "\" /> <a href=\"tel:" + rphonenumber + "\">" + rphonenumber + "</a>" + rphonenote + "<br />";
                                    }
                                }
                                string remails = relation.Split('^')[6];
                                if (remails != "")
                                {
                                    foreach (string remail in remails.Split('|'))
                                    {
                                        string remailaddress = remail.Split('~')[0];
                                        string remailnote = remail.Split('~')[1];
                                        if (remailnote != "")
                                        {
                                            remailnote = " - " + remailnote;
                                        }
                                        rline += "<input name =\"cb_remail_" + id + "\" type=\"checkbox\"  value=\"" + remailaddress + "\" /> <a href=\"mailto:" + remailaddress + "\">" + remailaddress + "</a>" + remailnote + "<br />";
                                    }
                                }
                            }
                        }


                        html += "<tr class=\"tr_person\" data-category=\"" + categories + "\">";
                        html += "<td>" + image + "</td>";
                        html += "<td>" + person + "</td><td>" + sendtext + "</td><td>" + sendemail + "</td><td>" + sendfacebook + " " + facebooklink + "</td>";
                        html += "<td>" + rline + "</td>";
                        html += "<td>" + attendance + "</td>";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (1 == 1)
            {
                foreach (string key in Request.Form.Keys)
                {
                    if (key.StartsWith("cb_"))
                    {
                        Response.Write(key + "=" + Request.Form[key] + "<br />");
                    }
                }
            }
            if (1 == 2)
            {
                Functions funcs = new Functions();

                string emailbodyTemplate = "RegisterEmail.xslt";
                string emailBCC = "";
                string remailBCC = "";
                string screenTemplate = "RegisterScreen.xslt";
                //string host = "datainn.co.nz";
                string host = "70.35.207.87";
                string emailfrom = "ltr@datainn.co.nz";
                string emailfromname = "Union Boat Club";
                string password = "m33t1ng";

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497;MultipleActiveResultSets=True";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Get_Communications", con);
                cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = tb_event_id.Text;

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
                            string facebook = dr["facebook"].ToString();
                            //string mobile = dr["mobile"].ToString();
                            //string email = dr["email"].ToString();
                            //string category = dr["category"].ToString();
                            //string categories = dr["categories"].ToString();
                            string person_guid = dr["person_guid"].ToString();
                            string event_guid = dr["event_guid"].ToString();
                            string username = dr["username"].ToString();
                            string tempphrase = dr["tempphrase"].ToString();
                            string attendance = dr["attendance"].ToString();
                            string role = dr["role"].ToString();
                            string relationships = dr["relationships"].ToString();


                            string emailtext = "";
                            string emailhtml = "";
                            string textmessage = "";
                            string facebookmessage = "";

                            string link = "<a href=\"http://private.unionboatclub.co.nz/person/maint.aspx?id=" + person_guid + "\" target=\"link\">Link</a>";

                            if (Request.Form["cb_email_" + id] + "" != "")
                            {

                                string emailRecipient = Request.Form["cb_email_" + id];

                                emailtext = tb_textbody.Text;
                                emailtext = emailtext.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailtext = emailtext.Replace("||firstname||", firstname);

                                emailtext = emailtext.Replace("||accesscode||", person_guid.Substring(0, 5));
                                emailtext = emailtext.Replace("||username||", username);
                                emailtext = emailtext.Replace("||tempphrase||", tempphrase);
                                emailtext = emailtext.Replace("||attendance||", attendance);
                                emailtext = emailtext.Replace("||role||", role);
                                emailtext = emailtext.Replace("||folder||", "Folder" + id);
                                emailtext = emailtext.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                emailhtml = tb_htmlbody.Text;
                                emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailhtml = emailhtml.Replace("||firstname||", firstname);

                                emailhtml = emailhtml.Replace("||accesscode||", person_guid.Substring(0, 5));
                                emailhtml = emailhtml.Replace("||username||", username);
                                emailhtml = emailhtml.Replace("||tempphrase||", tempphrase);
                                emailhtml = emailhtml.Replace("||attendance||", attendance);
                                emailhtml = emailhtml.Replace("||role||", role);
                                emailhtml = emailhtml.Replace("||folder||", "Folder" + id);
                                emailhtml = emailhtml.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";

                                /*

                                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                                message.To.Add(email);

                                message.ReplyToList.Add(new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club"));
                                message.From = new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club");

                                string emailsubject = tb_subject.Text;
                                emailsubject = emailsubject.Replace("||firstname||", firstname);fol

                                message.Subject = emailsubject;
                                message.IsBodyHtml = false;
                                message.Body = emailtext;
                                System.Net.Mime.ContentType mimeType = new System.Net.Mime.ContentType("text/html");
                                AlternateView alternate = AlternateView.CreateAlternateViewFromString(emailhtml, mimeType);

                                message.AlternateViews.Add(alternate);

                                System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("datainn.co.nz", 25);
                                client.UseDefaultCredentials = false;
                                client.Credentials = new System.Net.NetworkCredential("ltr@datainn.co.nz", "m33t1ng");
                                client.Send(message);
                                */

                                funcs.sendemailV2(host, emailfrom, emailfromname, password, tb_subject.Text, emailtext, emailhtml, emailRecipient, emailBCC, "");


                            }
                            if (Request.Form["cb_text_" + id] + "" != "")
                            {
                                string mobiles = Request.Form["cb_text_" + id];

                                textmessage = tb_txt.Text;
                                textmessage = textmessage.Replace("||link||", link);
                                textmessage = textmessage.Replace("||firstname||", firstname);
                                textmessage = textmessage.Replace("||accesscode||", person_guid.Substring(0, 5));
                                textmessage = textmessage.Replace("||username||", username);
                                textmessage = textmessage.Replace("||tempphrase||", tempphrase);
                                textmessage = textmessage.Replace("||attendance||", attendance);
                                textmessage = textmessage.Replace("||role||", role);
                                textmessage = textmessage.Replace("||folder||", "Folder" + id);
                                textmessage = textmessage.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);
                                foreach (string mobile in mobiles.Split(';'))
                                {
                                    funcs.SendMessage(mobile, textmessage);
                                }
                            }

                            if (Request.Form["cb_facebook_" + id] == "on")
                            {
                                facebookmessage = tb_textbody.Text;
                                facebookmessage = facebookmessage.Replace("||link||", link);
                                facebookmessage = facebookmessage.Replace("||firstname||", firstname);

                                facebookmessage = facebookmessage.Replace("||accesscode||", person_guid.Substring(0, 5));
                                facebookmessage = facebookmessage.Replace("||username||", username);
                                facebookmessage = facebookmessage.Replace("||tempphrase||", tempphrase);
                                facebookmessage = facebookmessage.Replace("||attendance||", attendance);
                                facebookmessage = facebookmessage.Replace("||role||", role);
                                facebookmessage = facebookmessage.Replace("||folder||", "Folder" + id);
                                facebookmessage = facebookmessage.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                html_facebook += "<button data-link=\"" + facebook + "\" type=\"button\" class=\"fb_clipboard\"> GO </button><textarea>" + facebookmessage + "</textarea>";
                            }



                            if (emailtext != "" || emailhtml != "" || textmessage != "" || facebookmessage != "")
                            {
                                SqlCommand cmd2 = new SqlCommand("Insert_Person_communication", con);
                                cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = id;
                                cmd2.Parameters.Add("@emailtext", SqlDbType.VarChar).Value = Request.Form["cb_email_" + id] + "<br />" + emailtext;
                                cmd2.Parameters.Add("@emailhtml", SqlDbType.VarChar).Value = Request.Form["cb_email_" + id] + "<br />" + emailhtml;
                                cmd2.Parameters.Add("@textmessage", SqlDbType.VarChar).Value = Request.Form["cb_text_" + id] + "<br />" + textmessage;
                                cmd2.Parameters.Add("@facebookmessage", SqlDbType.VarChar).Value = Request.Form["cb_facebook_" + id] + "<br />" + facebookmessage;

                                cmd2.CommandType = CommandType.StoredProcedure;
                                cmd2.Connection = con;

                                //con.Open();
                                string result = cmd2.ExecuteScalar().ToString();
                                //SqlDataReader dr2 = cmd1.ExecuteReader();

                                cmd2.Dispose();
                            }

                            //-------------------------------------------------------------RELATIONSHIPS START-----------------------------
                            #region relationships

                            string remailtext = "";
                            string remailhtml = "";
                            string rtextmessage = "";
                            string rfacebookmessage = "";


                            if (Request.Form["cb_remail_" + id] + "" != "")
                            {

                                string remailRecipient = Request.Form["cb_remail_" + id];

                                emailtext = tb_rtextbody.Text;
                                emailtext = remailtext.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailtext = remailtext.Replace("||firstname||", firstname);

                                emailtext = remailtext.Replace("||folder||", "Folder" + id);
                                emailtext = remailtext.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                emailhtml = tb_rhtmlbody.Text;
                                emailhtml = remailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailhtml = remailhtml.Replace("||firstname||", firstname);

                                emailhtml = remailhtml.Replace("||folder||", "Folder" + id);
                                emailhtml = remailhtml.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                emailhtml = "<html><head></head><body>" + remailhtml + "</body></html>";

                                /*

                                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                                message.To.Add(email);

                                message.ReplyToList.Add(new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club"));
                                message.From = new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club");

                                string emailsubject = tb_subject.Text;
                                emailsubject = emailsubject.Replace("||firstname||", firstname);fol

                                message.Subject = emailsubject;
                                message.IsBodyHtml = false;
                                message.Body = emailtext;
                                System.Net.Mime.ContentType mimeType = new System.Net.Mime.ContentType("text/html");
                                AlternateView alternate = AlternateView.CreateAlternateViewFromString(emailhtml, mimeType);

                                message.AlternateViews.Add(alternate);

                                System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("datainn.co.nz", 25);
                                client.UseDefaultCredentials = false;
                                client.Credentials = new System.Net.NetworkCredential("ltr@datainn.co.nz", "m33t1ng");
                                client.Send(message);
                                */

                                funcs.sendemailV2(host, emailfrom, emailfromname, password, tb_subject.Text, remailtext, remailhtml, remailRecipient, remailBCC, "");
                            }
                            /*
                            if (Request.Form["cb_text_" + id] + "" != "")
                            {
                                string mobiles = Request.Form["cb_text_" + id];

                                textmessage = tb_txt.Text;
                                textmessage = textmessage.Replace("||link||", link);
                                textmessage = textmessage.Replace("||firstname||", firstname);
                                textmessage = textmessage.Replace("||accesscode||", person_guid.Substring(0, 5));
                                textmessage = textmessage.Replace("||username||", username);
                                textmessage = textmessage.Replace("||tempphrase||", tempphrase);
                                textmessage = textmessage.Replace("||attendance||", attendance);
                                textmessage = textmessage.Replace("||role||", role);
                                textmessage = textmessage.Replace("||folder||", "Folder" + id);
                                textmessage = textmessage.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);
                                foreach (string mobile in mobiles.Split(';'))
                                {
                                    funcs.SendMessage(mobile, textmessage);
                                }
                            }

                            if (Request.Form["cb_facebook_" + id] == "on")
                            {
                                facebookmessage = tb_textbody.Text;
                                facebookmessage = facebookmessage.Replace("||link||", link);
                                facebookmessage = facebookmessage.Replace("||firstname||", firstname);

                                facebookmessage = facebookmessage.Replace("||accesscode||", person_guid.Substring(0, 5));
                                facebookmessage = facebookmessage.Replace("||username||", username);
                                facebookmessage = facebookmessage.Replace("||tempphrase||", tempphrase);
                                facebookmessage = facebookmessage.Replace("||attendance||", attendance);
                                facebookmessage = facebookmessage.Replace("||role||", role);
                                facebookmessage = facebookmessage.Replace("||folder||", "Folder" + id);
                                facebookmessage = facebookmessage.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                                html_facebook += "<button data-link=\"" + facebook + "\" type=\"button\" class=\"fb_clipboard\"> GO </button><textarea>" + facebookmessage + "</textarea>";
                            }

                            */
                            /*
                            if (remailtext != "" || remailhtml != "" || rtextmessage != "" || rfacebookmessage != "")
                            {
                                SqlCommand cmd2 = new SqlCommand("Insert_Person_communication", con);
                                cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = id;
                                cmd2.Parameters.Add("@emailtext", SqlDbType.VarChar).Value = Request.Form["cb_remail_" + id] + "<br />" + remailtext;
                                cmd2.Parameters.Add("@emailhtml", SqlDbType.VarChar).Value = Request.Form["cb_remail_" + id] + "<br />" + remailhtml;
                                cmd2.Parameters.Add("@textmessage", SqlDbType.VarChar).Value = Request.Form["cb_rtext_" + id] + "<br />" + rtextmessage;
                                cmd2.Parameters.Add("@facebookmessage", SqlDbType.VarChar).Value = Request.Form["cb_rfacebook_" + id] + "<br />" + rfacebookmessage;

                                cmd2.CommandType = CommandType.StoredProcedure;
                                cmd2.Connection = con;

                                //con.Open();
                                string result = cmd2.ExecuteScalar().ToString();
                                //SqlDataReader dr2 = cmd1.ExecuteReader();

                                cmd2.Dispose();
                            }
                            */

                            //-------------------------------------------------------------RELATIONSHIPS END-----------------------------
                            #endregion

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
