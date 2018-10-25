﻿using Generic;
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
    public partial class Communicate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Communications", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    Lit_html.Text = "<tr><td>Name</td><td>Send Text</td><td>Send Email</td><td>Facebook</td><td>Link</td>"; //<td>Send mobile</td><td>Send Email</td><td>Facebook</td><td>Link</td><td>Coming</td><td>Modified</td></tr>";

                    while (dr.Read())
                    {
                        string id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string facebook = dr["facebook"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string email = dr["email"].ToString();
                        string category = dr["category"].ToString();
                        string guid = dr["guid"].ToString();

                        string link = "<a href=\"http://private.unionboatclub.co.nz/person/maint.aspx?id=" + guid + "\" target=\"link\">Link</a>";

                        string sendemail = "";
                        string sendemaillink = "";
                        if (email != "")
                        {
                            sendemail = "<input id=\"cb_email_" + id + "\" name =\"cb_email_" + id + "\" type=\"checkbox\" />";
                            sendemaillink = "<a href=\"mailto:" + email + "\">" + email + "</a>";
                        }
                        string sendtext = "";
                        if (mobile != "")
                        {
                            sendtext = "<input id=\"cb_text_" + id + "\" name =\"cb_text_" + id + "\" type=\"checkbox\" />";
                        }
                        string sendfacebook = "";
                        string facebooklink = "";
                        if (facebook != "")
                        {
                            sendfacebook = "<input id=\"cb_facebook_" + id + "\" name =\"cb_facebook_" + id + "\" type=\"checkbox\" />";
                            facebooklink = "<a href=\"" + facebook + "\" target=\"Facebook\">Facebook</a>";
                        }

                        /*
                    string sendcaregiveremail = "";
                    string sendcaregiveremaillink = "";


                    if (caregiveremail != "")
                    {
                        sendcaregiveremail = "<input id=\"cb_caregiveremail_" + id + "\" name =\"cb_caregiveremail_" + id + "\" type=\"checkbox\" />";
                        sendcaregiveremaillink = "<a href=\"mailto:" + caregiveremail + "\">" + caregiveremail + "</a>";
                    }
                    string sendcaregivertext = "";
                    if (caregivermobile != "")
                    {
                        sendcaregivertext = "<input id=\"cb_caregivertext_" + id + "\" name =\"cb_caregivertext_" + id + "\" type=\"checkbox\" />";
                    }
                    string sendcaregiverfacebook = "";
                    string caregiverfacebooklink = "";
                    if (caregiverfacebook != "")
                    {
                        sendcaregiverfacebook = "<input id=\"cb_caregiverfacebook_" + id + "\" name =\"cb_caregiverfacebook_" + id + "\" type=\"checkbox\" />";
                        caregiverfacebooklink = "<a href=\"" + caregiverfacebook + "\" target=\"Facebook\">Facebook</a>";
                    }

*/


                        Lit_html.Text += "<tr>";
                        //Lit_html.Text += "<td>" + sendemail + "</td><td>" + sendtext + "</td><td>" + sendfacebook + "</td><td>" + firstname + " " + lastname + " - " + school + " (" + schoolyear + ")</td><td>" + facebooklink + "</td><td><a href=\"mailto:" + email + "\"</a>" + email + "</td><td>" + dr["mobile"] + "</td><td>" + caregivername + "</td><td>" + sendcaregiveremail + "</td><td>" + sendcaregivertext + "</td><td>" + caregiversendfacebook + "</td><td>" + caregiver + "</td>";
                        Lit_html.Text += "<td>" + name + "</td><td>" + sendtext + " " + mobile + "</td><td>" + sendemail + " " + sendemaillink + "</td><td>" + sendfacebook + " " + facebooklink + "</td>";
                        //<td>" + caregivername + "</td><td>" + sendcaregivertext + " " + caregivermobile + "</td><td>" + sendcaregiveremail + " " + sendcaregiveremaillink + "</td><td>" + sendcaregiverfacebook + " " + caregiverfacebooklink + "</td><td>" + coming + "</td><td>" + modified + "</td>";
                        Lit_html.Text += "<td>" + link + "</td>";
                        Lit_html.Text += "</tr>";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            Functions funcs = new Functions();

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Communications", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    //Lit_html.Text = "<tr><td>Student</td><td>Send Text</td><td>Send Email</td><td>Facebook</td><td>Caregiver</td><td>Send mobile</td><td>Send Email</td><td>Facebook</td><td>Link</td><td>Coming</td><td>Modified</td></tr>";

                    while (dr.Read())
                    {
                        string id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string facebook = dr["facebook"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string email = dr["email"].ToString();
                        string category = dr["category"].ToString();
                        string guid = dr["guid"].ToString();

                        string link = "<a href=\"http://private.unionboatclub.co.nz/person/maint.aspx?id=" + guid + "\" target=\"link\">Link</a>";

                        if (Request.Form["cb_email_" + id] == "on")
                        {
                            string emailtext = tb_textbody.Text;
                            emailtext = emailtext.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                            emailtext = emailtext.Replace("||firstname||", firstname);

                            string emailhtml = tb_htmlbody.Text;
                            emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                            emailhtml = emailhtml.Replace("||firstname||", firstname);
                            emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";

                            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                            message.To.Add(email);

                            message.ReplyToList.Add(new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club"));
                            message.From = new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club");

                            string emailsubject = tb_subject.Text;
                            emailsubject = emailsubject.Replace("||firstname||", firstname);

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
                        }
                        if (Request.Form["cb_text_" + id] == "on")
                        {
                            string textmessage = tb_txt.Text;
                            textmessage = textmessage.Replace("||link||", link);
                            textmessage = textmessage.Replace("||firstname||", firstname);
                            funcs.SendMessage(mobile, textmessage);
                        }

                        if (Request.Form["cb_facebook_" + id] == "on")
                        {
                            string facebookmessage = tb_textbody.Text;
                            facebookmessage = facebookmessage.Replace("||link||", link);
                            facebookmessage = facebookmessage.Replace("||firstname||", firstname);
                            Lit_facebook.Text += "<button data-link=\"" + facebook + "\" type=\"button\" class=\"fb_clipboard\"> GO </button><textarea>" + facebookmessage + "</textarea>";
                        }

                        /*
                        //-----------------Caregiver---------------------//

                        if (Request.Form["cb_caregiveremail_" + id] == "on")
                        {
                            string emailtext = tb_textbody.Text;
                            emailtext = emailtext.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                            emailtext = emailtext.Replace("||firstname||", firstname);

                            string emailhtml = tb_htmlbody.Text;
                            emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                            emailhtml = emailhtml.Replace("||firstname||", firstname);
                            emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";

                            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                            message.To.Add(caregiveremail);

                            message.ReplyToList.Add(new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club"));
                            message.From = new System.Net.Mail.MailAddress("ltr@datainn.co.nz", "Union Boat Club");

                            string emailsubject = tb_subject.Text;
                            emailsubject = emailsubject.Replace("||firstname||", firstname);

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
                        }
                        if (Request.Form["cb_caregivertext_" + id] == "on")
                        {
                            string textmessage = tb_txt.Text;
                            textmessage = textmessage.Replace("||link||", link);
                            textmessage = textmessage.Replace("||firstname||", firstname);
                            funcs.SendMessage(caregivermobile, textmessage);
                        }

                        if (Request.Form["cb_caregiverfacebook_" + id] == "on")
                        {
                            string facebookmessage = tb_htmlbody.Text;
                            facebookmessage = facebookmessage.Replace("||link||", link);
                            facebookmessage = facebookmessage.Replace("||firstname||", firstname);
                            Lit_facebook.Text += facebookmessage;
                        }
                        */


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