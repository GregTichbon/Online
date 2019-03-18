using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using System.Xml;
using System.Text;
using System.IO;
using System.Web.Configuration;
using Online.Models;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace Online.Appointments
{
    public partial class Maintenance : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        static string moduleName = "Appointment";

        /*
title
startdatetime
enddatetime
Status
notes, Responder_Name, Responder_EmailAddress, Responder_PhoneDetails, Responder_OtherInformation
*/

        //public string tb_reference;
        //public string tb_appointment;
        public string title;
        public string startdatetime;
        public string enddatetime;
        public string Responder_Name;
        public string Responder_EmailAddress;
        public string Responder_PhoneDetails;
        public string Responder_OtherInformation;
        public string Responder_Header;


        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

                tb_reference.Text = Request.QueryString["reference"];

                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                //string strConnString = "Data Source=192.168.1.149;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
                SqlConnection con = new SqlConnection(strConnString);

                con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Appointments_Get_Appointment", con);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();


                #region setup specific data
                //cmd.Parameters.Add("@module_ctr", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard

                #endregion
                Boolean found = false;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        found = true;
                        dr.Read();
                        title = dr["title"].ToString();
                        startdatetime = dr["startdatetime"].ToString();
                        enddatetime = dr["enddatetime"].ToString();
                        Responder_Name = dr["Responder_Name"].ToString();
                        Responder_EmailAddress = dr["Responder_EmailAddress"].ToString();
                        Responder_PhoneDetails = dr["Responder_PhoneDetails"].ToString();
                        Responder_OtherInformation = dr["Responder_OtherInformation"].ToString();
                        Responder_Header = dr["Responder_Header"].ToString();
                        tb_appointment.Text = Convert.ToDateTime(startdatetime).ToString("dd MMM yyyy HH:mm") + " - " + Convert.ToDateTime(enddatetime).ToString("HH:mm");
                        hf_name.Value = Responder_Name;
                        hf_emailaddress.Value = Responder_EmailAddress;
                        hf_header.Value = Responder_Header;
                        hf_startdatetime.Value = startdatetime;
                        hf_enddatetime.Value = enddatetime;


                    }
                }
                catch (Exception ex)
                {
                    WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                if(!found)
                {
                    string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
                    string webserver = WebConfigurationManager.AppSettings["webserver"];

                    Session["message_title"] = "Appointment";
                    Session["message_head"] = "Invalid appointment details.";
                    Session["message_message"] = "";
                    string redirect = webprotocol + "://" + webserver + "appointments/ratesrebates.aspx";
                    Session["message_redirect"] = redirect;


                    Response.Redirect("~/message.aspx");
                }


            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string newreference = "";
            string oldappointment = "";
            if (Request.Form["hf_newappointmentreference"] != "")
            {
                newreference = WDCFunctions.getReference("guid");
                oldappointment = tb_appointment.Text;
                tb_appointment.Text = Request.Form["hf_newappointment"];
            } else
            {
                newreference = tb_reference.Text;
            }

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];

            string submissionfolder = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + tb_reference.Text + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
            submissionurl = webprotocol + "://" + webserver + "//" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = moduleName + "Screen.xslt";
            string emailbodyTemplate = moduleName + "Email.xslt";

            #endregion

            if (!Directory.Exists(submissionpath))
            {
                Directory.CreateDirectory(submissionpath);
            }

            List<FileClass> FileList = new List<FileClass>();
            WDCFunctions.upload(submissionfolder, submissionurl, Request.Files, FileList);

            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            rootXml.Add(new XElement("tb_reference", tb_reference.Text));
            rootXml.Add(new XElement("tb_appointment", tb_appointment.Text));

            WDCFunctions.createXMLStructureWithFiles(repeatertable, Request.Form, FileList, rootXml);

            //if(newreference != tb_reference.Text) { 
                rootXml.Add(new XElement("newreference", tb_reference.Text)); // What if response returns someone else has grabbed this?????
                                                                         //}

            if(oldappointment != "") { 
                rootXml.Add(new XElement("oldappointment", oldappointment)); 
            }


            //string x = HttpContext.Current.Request.Url.AbsolutePath.ToLower();

            //var y = HttpContext.Current.Request.Url;

            //string scheme = HttpContext.Current.Request.Url.Scheme + "://";
            //string authority = HttpContext.Current.Request.Url.Authority + "/";
            //string basefolder = ""; // blank, online, or onlinetest

            rootXml.Add(new XElement("emaillink", webprotocol + "://" + webserver + "/Appointments/Maintenance.aspx?reference=" + tb_reference.Text)); // What if response returns someone else has grabbed this?????
            rootXml.Add(new XElement("screenlink", "../Appointments/Maintenance.aspx?reference=" + tb_reference.Text)); // What if response returns someone else has grabbed this?????

            #endregion //BuildXML

            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_" + moduleName + "XML", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data

            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard

            cmd.Parameters.Add("@responder_name", SqlDbType.VarChar).Value = Request.Form["tb_name"];
            cmd.Parameters.Add("@responder_emailaddress", SqlDbType.VarChar).Value = Request.Form["tb_emailaddress"];
            cmd.Parameters.Add("@responder_phonedetails", SqlDbType.VarChar).Value = Request.Form["tb_contactphone"];
            cmd.Parameters.Add("@responder_otherinformation", SqlDbType.VarChar).Value = Request.Form["tb_information"];
            cmd.Parameters.Add("@newreference", SqlDbType.VarChar).Value = newreference;
            cmd.Parameters.Add("@Responder_Header", SqlDbType.VarChar).Value = Request.Form["tb_property"];
            cmd.Parameters.Add("@newappointmentreference", SqlDbType.VarChar).Value = Request.Form["hf_newappointmentreference"];
            //cmd.Parameters.Add("@responder_attachments", SqlDbType.VarChar).Value = ????;   
            cmd.Parameters.Add("@xml", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());
            #endregion

            #region save data (Standard)

            string response = "";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    response = dr["response"].ToString();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion





            string path = Server.MapPath(".");
            XmlDocument reader = new XmlDocument();
            reader.LoadXml(rootXml.ToString());

            #region email
            XslCompiledTransform EmailXslTrans = new XslCompiledTransform();
            EmailXslTrans.Load(path + "\\" + emailbodyTemplate);

            StringBuilder EmailOutput = new StringBuilder();
            TextWriter EmailWriter = new StringWriter(EmailOutput);

            EmailXslTrans.Transform(reader, null, EmailWriter);
            string emailbodydocument = EmailOutput.ToString();

            //THE EMAIL TEMPLATE
            string emailtemplate = Server.MapPath("..") + "\\EmailTemplate\\standard.html";
            string emaildocument = "";
            #endregion

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

            #region set up email



            /*
             * IF the appointment date/time has changed cancel original, send new one.
             * 
            string UID = hf_newreference.Value + "@wdc.whanganui.govt.nz";
            string DTSTAMP = DateTime.UtcNow.ToString("yyyyMMdd'T'HHmmss'Z'");

            StringBuilder calendardocument = new StringBuilder();
            calendardocument.AppendLine("BEGIN:VCALENDAR");                                    //BEGIN:VCALENDAR
            calendardocument.AppendLine("METHOD:CANCEL");
            calendardocument.AppendLine("VERSION:2.0");
            calendardocument.AppendLine("PRODID:-//wdc.whanganui.govt.nz");
            calendardocument.AppendLine("BEGIN:VTIMEZONE");                                        //BEGIN:VTIMEZONE
            calendardocument.AppendLine("TZID:New Zealand Standard Time");                             //BEGIN:DAYLIGHT
            calendardocument.AppendLine("BEGIN:DAYLIGHT");
            calendardocument.AppendLine("TZOFFSETFROM:+1200");
            calendardocument.AppendLine("TZOFFSETTO:+1300");
            calendardocument.AppendLine("TZNAME:NZDT");
            calendardocument.AppendLine("DTSTART:19700927T020000");
            calendardocument.AppendLine("END:DAYLIGHT");                                               //END:DAYLIGHT
            calendardocument.AppendLine("BEGIN:STANDARD");                                             //BEGIN:STANDARD
            calendardocument.AppendLine("TZOFFSETFROM:+1300");
            calendardocument.AppendLine("TZOFFSETTO:+1200");
            calendardocument.AppendLine("TZNAME:NZST");
            calendardocument.AppendLine("DTSTART:19700405T030000");
            calendardocument.AppendLine("END:STANDARD");                                               //END:STANDARD
            calendardocument.AppendLine("END:VTIMEZONE");                                          //END:VTIMEZONE
            calendardocument.AppendLine("BEGIN:VEVENT");                                           //BEGIN:VEVENT
            calendardocument.AppendLine("DTSTAMP:" + DTSTAMP);
            calendardocument.AppendLine("UID:" + UID);
            calendardocument.AppendLine("DTSTART;TZID=New Zealand Standard Time:" + hf_startdatetime.Value);
            calendardocument.AppendLine("DTEND;TZID=New Zealand Standard Time:" + hf_enddatetime.Value);
            calendardocument.AppendLine("SUMMARY:" + "Cancelled: Whanganui District Council Rates Rebate Appointment");
            calendardocument.AppendLine("DESCRIPTION;LANGUAGE=en-NZ:" + @"http://wdc.whanganui.govt.nz/onlineTEST/appointments/ratesrebates.aspx");
            calendardocument.AppendLine("END:VEVENT");                                             //END:VEVENT
            calendardocument.AppendLine("END:VCALENDAR");                                      //END:VCALENDAR
*/


            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion //email

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, Request.Form["tb_emailaddress"], emailBCC);
            #endregion

            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);

            //"<pre><code>" + HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) + "</code></pre><br />" + 
            Session["body"] = ScreenOutput.ToString();


            Response.Redirect("../Completed");
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];

            string submissionfolder = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + tb_reference.Text + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
            submissionurl = webprotocol + "://" + webserver + "//" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = "CancelledScreen.html";
            //string emailbodyTemplate = moduleName + "Email.xslt";

            #endregion

            if (!Directory.Exists(submissionpath))
            {
                Directory.CreateDirectory(submissionpath);
            }
            
            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Cancel_" + moduleName, con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard
            #endregion

            #region save data (Standard)
            string response = "";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    response = dr["response"].ToString();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion
           

            string path = Server.MapPath(".");
            string screenpath = path + "\\" + screenTemplate;
            string screendocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(screenpath))
                {
                    screendocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            screendocument = screendocument.Replace("||reference||", tb_reference.Text);
            screendocument = screendocument.Replace("||datetime||", tb_appointment.Text);
            screendocument = screendocument.Replace("||Name||", hf_name.Value);
            screendocument = screendocument.Replace("||Header||", hf_header.Value);
            screendocument = screendocument.Replace("||href||", webprotocol + "://" + webserver + "/");


            #region email
            string emailtemplate = Server.MapPath("..") + "\\EmailTemplate\\standard.html";
            string emaildocument = "";
            #endregion

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

            #region set up email

            emaildocument = emaildocument.Replace("||Content||", screendocument);
            #endregion //email

            if(1 == 2) {
                string UID = tb_reference.Text + "@wdc.whanganui.govt.nz";
                string DTSTAMP = DateTime.UtcNow.ToString("yyyyMMdd'T'HHmmss'Z'");

                string startdatetimeformatted = Convert.ToDateTime(hf_startdatetime.Value).ToString("yyyyMMdd'T'HHmmss");
                string enddatetimeformatted = Convert.ToDateTime(hf_enddatetime.Value).ToString("yyyyMMdd'T'HHmmss");


                StringBuilder calendardocument = new StringBuilder();
                calendardocument.AppendLine("BEGIN:VCALENDAR");                                    //BEGIN:VCALENDAR
                calendardocument.AppendLine("METHOD:CANCEL");
                calendardocument.AppendLine("VERSION:2.0");
                calendardocument.AppendLine("PRODID:-//wdc.whanganui.govt.nz");
                calendardocument.AppendLine("BEGIN:VTIMEZONE");                                        //BEGIN:VTIMEZONE
                calendardocument.AppendLine("TZID:New Zealand Standard Time");                             //BEGIN:DAYLIGHT
                calendardocument.AppendLine("BEGIN:DAYLIGHT");
                calendardocument.AppendLine("TZOFFSETFROM:+1200");
                calendardocument.AppendLine("TZOFFSETTO:+1300");
                calendardocument.AppendLine("TZNAME:NZDT");
                calendardocument.AppendLine("DTSTART:19700927T020000");
                calendardocument.AppendLine("END:DAYLIGHT");                                               //END:DAYLIGHT
                calendardocument.AppendLine("BEGIN:STANDARD");                                             //BEGIN:STANDARD
                calendardocument.AppendLine("TZOFFSETFROM:+1300");
                calendardocument.AppendLine("TZOFFSETTO:+1200");
                calendardocument.AppendLine("TZNAME:NZST");
                calendardocument.AppendLine("DTSTART:19700405T030000");
                calendardocument.AppendLine("END:STANDARD");                                               //END:STANDARD
                calendardocument.AppendLine("END:VTIMEZONE");                                          //END:VTIMEZONE
                calendardocument.AppendLine("BEGIN:VEVENT");                                           //BEGIN:VEVENT
                calendardocument.AppendLine("DTSTAMP:" + DTSTAMP);
                calendardocument.AppendLine("UID:" + UID);
                calendardocument.AppendLine("DTSTART;TZID=New Zealand Standard Time:" + startdatetimeformatted);
                calendardocument.AppendLine("DTEND;TZID=New Zealand Standard Time:" + enddatetimeformatted);
                calendardocument.AppendLine("SUMMARY:" + "Cancelled: Whanganui District Council Rates Rebate Appointment");
                calendardocument.AppendLine("DESCRIPTION;LANGUAGE=en-NZ:" + @"http://wdc.whanganui.govt.nz/onlineTEST/appointments/ratesrebates.aspx");
                calendardocument.AppendLine("END:VEVENT");                                             //END:VEVENT
                calendardocument.AppendLine("END:VCALENDAR");                                      //END:VCALENDAR

                WDCFunctions.sendemailwithAttachments(emailSubject, emaildocument, hf_emailaddress.Value, emailBCC, calendardocument.ToString());
            } else
            {
                WDCFunctions.sendemail(emailSubject, emaildocument, hf_emailaddress.Value, emailBCC);
            }

            Session["body"] = screendocument;

            Response.Redirect("../Completed");
        }
    }
}
 