
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
        string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Meetings", con);
            //cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = fld_meeting.SelectedValue;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();

                while (dr.Read())
                {
                    fld_meeting.Items.Add(new ListItem(dr["fullName"].ToString(), dr["meeting_ctr"].ToString()));
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
            btn_submit.Style.Add("display", "none");
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //1st submit show data with send text and send email check boxes
            //second submit do the actual sending
            Functions funcs = new Functions();

            string allemail = "";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Meeting_Entity", con);
            cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = fld_meeting.SelectedValue;

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
                        Lit_html.Text = "<tr><td>Send Email</td><td>Send Text</td><td>Social</td><td>Name</td><td>Greeting</td><td>URL</td><td>Email Address</td><td>Mobile</td></tr>";
                        allemail = "";
                        btn_submit.Style.Remove("display");
                    }
                    while (dr.Read())
                    {
                        string title = dr["title"].ToString();
                        string description = dr["description"].ToString();

                        lit_details.Text = "<b>Title</b>: " + title + "<br />";
                        lit_details.Text += "<b>Description</b>: " + description + "<br />";

                        string id = dr["entity_ctr"].ToString();
                        string greeting = dr["greeting"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string meetingguid = dr["meeting_guid"].ToString();
                        string entityguid = dr["entity_guid"].ToString();
                        string type = dr["type"].ToString();
                        string MeetingEntity_GUID = dr["MeetingEntity_GUID"].ToString();
                        string link = "";
                        if(type == "Options")
                        {
                            link = "http://office.datainn.co.nz/MeetingScheduler/select.aspx?id=" + MeetingEntity_GUID;
                        } else
                        {
                            link = "http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + meetingguid + "&entity=" + entityguid;
                        }

                        string emailaddress = dr["emailaddress"].ToString();
                        string name = dr["name"].ToString();

                        string sendemail = "";
                        if (emailaddress != "")
                        {
                            allemail += "; " + emailaddress;
                        }


                        if (btn_submit.Text == "Send")
                        {
                            string response = "";
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

                                Generic.Functions gFunctions = new Generic.Functions();
                                string[] attachments = new string[0];
                                Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                                //emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";


                                string host = "";
                                string emailfrom = "";
                                string password = "";
                                int port = 0;
                                Boolean enableSsl = false;

                                switch (fld_email.Text)
                                {
                                    case "meetingscheduler@datainn.co.nz":
                                        host = "datainn.co.nz";
                                        // host = "70.35.207.87";
                                        emailfrom = "UnionBoatClub@datainn.co.nz";
                                        password = "39%3Zxon";
                                        port = 25;
                                        enableSsl = false;
                                        break;
                                    case "info@unionboatclub.co.nz":
                                        host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
                                        emailfrom = "info@unionboatclub.co.nz";
                                        password = "R0wtheboat";
                                        port = 587; // 465; // 25;
                                        enableSsl = true;
                                        break;
                                    default:
                                        break;
                                }


                                string emailfromname = "Union Boat Club";
                                string emailBCC = emailfrom;

                                string emailsubject = tb_subject.Text;
                                emailsubject = emailsubject.Replace("||greeting||", greeting);
                                emailsubject = emailsubject.Replace("||title||", title);

                                gFunctions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailsubject, emailhtml, emailaddress, emailBCC, "", attachments, emailoptions);



                            }
                            if (Request.Form["cb_text_" + id] == "on")
                            {
                                string textmessage = tb_txt.Text;
                                textmessage = textmessage.Replace("||link||", link);
                                textmessage = textmessage.Replace("||greeting||", greeting);
                                textmessage = textmessage.Replace("||title||", title);
                                //funcs.SendMessage(mobile, textmessage);
                                response += funcs.SendRemoteMessage(mobile, textmessage, "Meeting Scheduler");
                                Response.Write(response);

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
                            Lit_html.Text += "<td>" + sendemail + "</td><td>" + sendtext + "</td><td>" + social + "</td><td>" + name + "</td><td>" + greeting + "</td><td><a href=\"" + link + "\" target_\"_Blank\">" + link + "</a></td><td><a href=\"mailto:" + emailaddress + "\"</a>" + emailaddress + "</td><td>" + dr["mobile"];
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
            Lit_html.Text += allemail.Substring(1);
            btn_submit.Text = "Send";
        }

    }
}