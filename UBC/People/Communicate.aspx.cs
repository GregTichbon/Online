﻿using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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
        public string html;
        public string SMSStatus = "";
        public string html_facebook;
        public string html_event;
        public string event_id = "";
        public string response = "";
        public string categories;

        public string categories_values;
        public string attendance_values;



        protected void Page_Load(object sender, EventArgs e)
        {
            /*
                    ||folder|| and ||redirect|| requires changes to web.config
                    <validation validateIntegratedModeConfiguration="false" />
                    <httpErrors existingResponse="Replace" errorMode="Custom">
                       <remove statusCode="404" subStatusCode="-1" />
                       <error statusCode="404" prefixLanguageFilePath="" path="/main.aspx" responseMode="ExecuteURL" />
                    </httpErrors>
             */


            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
            {
                Response.Redirect("~/default.aspx");
            }


            var url = "http://office.datainn.co.nz/sms/data.asmx/SMSPhoneStatus?options="; //|SendEmail|";
            var webrequest = (HttpWebRequest)System.Net.WebRequest.Create(url);

            using (var response = webrequest.GetResponse())
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                string result = reader.ReadToEnd();
                if(result.StartsWith("Error"))
                {
                    SMSStatus = "<h1>Warning! Texting may not be available</h1>";
                }
            }



            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
            categories = "";
            functionoptions.Clear();
            functionoptions.Add("storedprocedure", "");
            functionoptions.Add("usevalues", "");
            //categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
            categories_values = Functions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
            HashSet<string> attendance_list = new HashSet<string>();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Communications", con);
            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = Request.QueryString["id"];  //Request.Form["tb_event_id"];

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            //try) {
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    //html = "<tr><td colspan=\"2\">Person</td><td>Send Text</td><td>Send Email</td><td>Facebook</td><td>Relations</td><td>Attendance</td>"; //<td>Send mobile</td><td>Send Email</td><td>Facebook</td><td>Link</td><td>Coming</td><td>Modified</td></tr>";
                    html = "";
                    dr.Read();

                    if (Request.QueryString["id"] != null)
                    {
                        event_id = Request.QueryString["id"];
                        html_event = dr["event_datetime"].ToString() + " <a href=\"event.aspx?id=" + Request.QueryString["id"] + "\" target=\"_blank\">" + dr["event_title"].ToString() + "</a>";
                    }
                    do
                    //while (dr.Read())
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
                        string incategory = dr["incategory"].ToString();
                        string age = dr["age"].ToString();

                        if (attendance != "")
                        {
                            if (incategory == "0")
                            {
                                attendance = "*" + attendance;
                            }
                        }
                        else
                        {
                            if (incategory == "0")
                            {
                                attendance = "NA";
                            } else
                            {
                                attendance = "???";
                            }
                        }

                        attendance_list.Add(attendance);


                        string role = dr["role"].ToString();
                        string relationships = dr["relationships"].ToString();


                        string person = "<a href=\"maint.aspx?id=" + person_guid + "\" target=\"link\">" + name + "</a>";
                        string image = "<img src=\"Images/" + id + ".jpg\" style=\"height: 50px\" />";

                        string sendemail = "";
                        //string sendemaillink = "";
                        if (email != "")
                        {
                            string delim = "";
                            int c1 = 0;
                            //string[] emailsplit = email.Split('|');
                            foreach (string emailsplit in email.Split('|'))
                            {
                                string address = emailsplit.Split('~')[0];
                                string note = emailsplit.Split('~')[1];
                                if (note != "")
                                {
                                    note = " - " + note;
                                }
                                c1 ++;
                                sendemail += delim + "<div><input id=\"cb_email_" + id + "_" + c1 +"\" name =\"cb_email_" + id + "_" + c1 + "\" type=\"checkbox\"  value=\"" + address + "\" /> <a href=\"mailto:" + address + "\">" + address + "</a>" + note + "</div>";
                                //sendemaillink += "<a href=\"mailto:" + address + "\">" + address + note + "</a>" + delim;
                                delim = "<br />";
                            }
                        }
                        string sendtext = "";
                        if (mobile != "")
                        {
                            string delim = "";
                            int c1 = 0;
                            //string[] mobilesplit = mobile.Split('|');
                            foreach (string mobilesplit in mobile.Split('|'))
                            {
                                string number = mobilesplit.Split('~')[0];
                                string note = mobilesplit.Split('~')[1];
                                if (note != "")
                                {
                                    note = " - " + note;
                                }
                                c1++;
                                sendtext += delim + "<div><input id=\"cb_text_" + id + "_" + c1 + "\" name=\"cb_text_" + id + "_" + c1 + "\" type=\"checkbox\" value=\"" + number + "\" /> <a href=\"tel:" + number + "\">" + number + "</a>" + note + "</div>";

                                //sendtext = delim + "<input name =\"cb_text_" + id + "\" type=\"checkbox\" value=\"" + number + "\" /><a href=\"tel:" + number + "\">" + number + "</a>" + note;
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
                        /* ^Sibling^Ally Keenan^Ally^0278815431~^
                          \^Child^Pip Keenan^Pip^0276955901~^pip_chris@xtra.co.nz~
                          \^Child^Chris Keenan^Chris^0272187656~|Test~Test^pip_chris@xtra.co.nz~
                        */
                        //string rnote = "";
                        //string rrelationship = "";
                        //string rname = "";
                        string rline = "";
                        if (relationships != "")
                        {
                            rline += "<div class=\"age\" age=\"" + age + "\">";
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
                                string rguid = relation.Split('^')[5];

                                rline += "<b><a href=\"maint.aspx?id=" + rguid + "\" target=\"link\">" + rname + "</a></b> " + rrelationship + rnote + "<br />";

                                string rphones = relation.Split('^')[6];
                                if (rphones != "")
                                {
                                    int c1 = 0;
                                    foreach (string rphone in rphones.Split('|'))
                                    {
                                        string rphonenumber = rphone.Split('~')[0];
                                        string rphonenote = rphone.Split('~')[1];
                                        if (rphonenote != "")
                                        {
                                            rphonenote = " - " + rphonenote;
                                        }
                                        c1++;
                                        rline += "<input id=\"cb_rtext_" + rid + "_" + c1 + "\" name=\"cb_rtext_" + rid + "_" + c1 + "\" type=\"checkbox\"  value=\"" + id + "|" + firstname + "|" + rphonenumber + "\" /> <a href=\"tel:" + rphonenumber + "\">" + rphonenumber + "</a>" + rphonenote + "<br />";
                                    }
                                }
                                string remails = relation.Split('^')[7];
                                if (remails != "")
                                {
                                    int c1 = 0;
                                    foreach (string remail in remails.Split('|'))
                                    {
                                        string remailaddress = remail.Split('~')[0];
                                        string remailnote = remail.Split('~')[1];
                                        if (remailnote != "")
                                        {
                                            remailnote = " - " + remailnote;
                                        }
                                        c1++;
                                        rline += "<input id=\"cb_remail_" + rid + "_" + c1 + "\" name =\"cb_remail_" + rid + "_" + c1 + "\" type=\"checkbox\"  value=\"" + id + "|" + firstname + "|" + remailaddress + "\" /> <a href=\"mailto:" + remailaddress + "\">" + remailaddress + "</a>" + remailnote + "<br />";
                                    }
                                }
                            }
                            rline += "</div>";
                        }


                        html += "<tr id=\"tr_person_id_" + id + "\" class =\"tr_person " + attendance + "\" data-category=\"" + categories + "\">";
                        html += "<td>" + image + "</td>";
                        //html += "<td>" + sendemail + "</td><td>" + sendtext + "</td><td>" + sendfacebook + "</td><td>" + firstname + " " + lastname + " - " + school + " (" + schoolyear + ")</td><td>" + facebooklink + "</td><td><a href=\"mailto:" + email + "\"</a>" + email + "</td><td>" + dr["mobile"] + "</td><td>" + caregivername + "</td><td>" + sendcaregiveremail + "</td><td>" + sendcaregivertext + "</td><td>" + caregiversendfacebook + "</td><td>" + caregiver + "</td>";
                        //html += "<td>" + name + "</td><td>" + sendtext + " " + mobile + "</td><td>" + sendemail + " " + sendemaillink + "</td><td>" + sendfacebook + " " + facebooklink + "</td>";
                        html += "<td>" + person + "</td><td>" + sendtext + "</td><td>" + sendemail + "</td><td>" + sendfacebook + " " + facebooklink + "</td>";
                        html += "<td>" + rline + "</td>";

                        //<td>" + caregivername + "</td><td>" + sendcaregivertext + " " + caregivermobile + "</td><td>" + sendcaregiveremail + " " + sendcaregiveremaillink + "</td><td>" + sendcaregiverfacebook + " " + caregiverfacebooklink + "</td><td>" + coming + "</td><td>" + modified + "</td>";
                        if(event_id != "") { 
                            html += "<td>" + attendance + "</td>";
                        }
                        html += "</tr>" + "\r\n";

                    } while (dr.Read());

                    attendance_values = "";
                    foreach (string option in attendance_list)
                    {
                        attendance_values += "<option>" + option + "</option>";
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
}
