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

namespace DataInnovations.MeetingScheduler
{
    public partial class Notify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //1st submit show data with send text and send email check boxes
            //second submit do the actual sending
            Functions funcs = new Functions();

            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Meeting_Entity", con);
            cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = tb_meeting.Text;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    if (btn_submit.Text != "Send")
                    {
                        Lit_html.Text = "<tr><td>Send Email</td><td>Send Text</td><td>Social</td><td>URL</td><td>Email Address</td><td>Mobile</td></tr>";
                    }
                    while (dr.Read())
                    {
                        string id = dr["entity_ctr"].ToString();
                        string greeting = dr["greeting"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string meetingguid = dr["meeting_guid"].ToString();
                        string entityguid = dr["entity_guid"].ToString();
                        string link = "http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + meetingguid + "&entity=" + entityguid;
                        string emailaddress = dr["emailaddress"].ToString();
                        string title = dr["title"].ToString();
                        string description = dr["description"].ToString();

                        string sendemail = "";

                        if (btn_submit.Text == "Send")
                        {
                            if (Request.Form["cb_email_" + id] == "on")
                            {
                                string emailtext = tb_textbody.Text;
                                emailtext = emailtext.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailtext = emailtext.Replace("||greeting||", greeting);
                                emailtext = emailtext.Replace("||title||", title);
                                emailtext = emailtext.Replace("||description||", description);


                                string emailhtml = tb_htmlbody.Text;
                                emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                                emailhtml = emailhtml.Replace("||greeting||", greeting);
                                emailhtml = emailhtml.Replace("||title||", title);
                                emailhtml = emailhtml.Replace("||description||", description);
                                emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";


                                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                                message.To.Add(emailaddress);

                                message.ReplyToList.Add(new System.Net.Mail.MailAddress("greg@stonesoup.org.nz", "Greg Tichbon"));
                                message.From = new System.Net.Mail.MailAddress("meetingscheduler@datainn.co.nz", "Meeting Scheduler");

                                string emailsubject = tb_subject.Text;
                                emailsubject = emailsubject.Replace("||greeting||", greeting);
                                emailsubject = emailsubject.Replace("||title||", title);



                                message.Subject = emailsubject;
                                message.IsBodyHtml = false;
                                message.Body = emailtext;
                                System.Net.Mime.ContentType mimeType = new System.Net.Mime.ContentType("text/html");
                                AlternateView alternate = AlternateView.CreateAlternateViewFromString(emailhtml, mimeType);

                                message.AlternateViews.Add(alternate);


                                System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("datainn.co.nz", 25);
                                client.UseDefaultCredentials = false;
                                client.Credentials = new System.Net.NetworkCredential("meetingscheduler@datainn.co.nz", "m33t1ng");
                                client.Send(message);



                            }
                            if (Request.Form["cb_text_" + id] == "on")
                            {
                                string textmessage = tb_txt.Text;
                                textmessage = textmessage.Replace("||link||", link);
                                textmessage = textmessage.Replace("||greeting||", greeting);
                                textmessage = textmessage.Replace("||title||", title);
                                funcs.SendMessage(mobile, textmessage);

                            }

                            if (Request.Form["cb_social_" + id] == "on")
                            {
                                string socialmessage = tb_htmlbody.Text;
                                socialmessage = socialmessage.Replace("||link||", link);
                                socialmessage = socialmessage.Replace("||greeting||", greeting);
                                socialmessage = socialmessage.Replace("||title||", title);
                                socialmessage = socialmessage.Replace("||description||", description);
                                Lit_social.Text += socialmessage;
                            }
                        }
                        else
                        {
                            if (emailaddress != "")
                            {
                                sendemail = "<input id=\"cb_email_" + id + "\" name =\"cb_email_" + id + "\" type=\"checkbox\" />";
                            }
                            string sendtext = "";
                            if (mobile != "")
                            {
                                sendtext = "<input id=\"cb_text_" + id + "\" name =\"cb_text_" + id + "\" type=\"checkbox\" />";
                            }
                            string social = "<input id=\"cb_social_" + id + "\" name =\"cb_social_" + id + "\" type=\"checkbox\" />";

                            Lit_html.Text += "<tr>";
                            Lit_html.Text += "<td>" + sendemail + "</td><td>" + sendtext + "</td><td>" + social + "</td><td><a href=\"" + link + "\">" + link + "</a></td><td><a href=\"mailto:" + emailaddress + "\"</a>" + emailaddress + "</td><td>" + dr["mobile"];
                            Lit_html.Text += "</tr>";
                        }
                    }

                    dr.Close();
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
            btn_submit.Text = "Send";
        }

        protected void tb_body_TextChanged(object sender, EventArgs e)
        {

        }
    }
}