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
    public partial class Details : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        static string moduleName = "Appointment";

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
                hf_newreference.Value = WDCFunctions.getReference("guid");
                hf_startdatetime.Value = Request.QueryString["start"];
                hf_enddatetime.Value = Request.QueryString["end"];

                tb_reference.Text = Request.QueryString["reference"];
                tb_appointment.Text = Request.QueryString["appointment"];
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
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

            //WDCFunctions.createXMLStructure(repeatertable, Request.Form, rootXml);
            //WDCFunctions.populateXML(repeatertable, rootXml);

            WDCFunctions.createXMLStructureWithFiles(repeatertable, Request.Form, FileList, rootXml);

            #endregion //BuildXML

            /*

            XslCompiledTransform myXslTrans1 = new XslCompiledTransform();
            myXslTrans1.Load(@"C:\Users\gregt\Source\Workspaces\OnlineServices\Online\Online\General\DataCorrection_Screen.xslt");

            XmlDocument myXPathDoc = new XmlDocument();
            myXPathDoc.LoadXml(rootXml.ToString());

            XmlTextWriter myWriter = new XmlTextWriter(@"c:\temp\result.html", null);
            myXslTrans1.Transform(myXPathDoc, null, myWriter);

            */

            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_" + moduleName + "XML", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            //cmd.Parameters.Add("@module_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard

            cmd.Parameters.Add("@responder_name", SqlDbType.VarChar).Value = Request.Form["tb_name"];  
            cmd.Parameters.Add("@responder_emailaddress", SqlDbType.VarChar).Value = Request.Form["tb_emailaddress"];
            cmd.Parameters.Add("@responder_phonedetails", SqlDbType.VarChar).Value = Request.Form["tb_contactphone"].Replace(Environment.NewLine, "<br />");
            cmd.Parameters.Add("@responder_otherinformation", SqlDbType.VarChar).Value = Request.Form["tb_information"].Replace(Environment.NewLine, "<br />");
            cmd.Parameters.Add("@Responder_Header", SqlDbType.VarChar).Value = Request.Form["tb_property"];

            cmd.Parameters.Add("@newreference", SqlDbType.VarChar).Value = hf_newreference.Value;

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


            rootXml.Add(new XElement("newreference", hf_newreference.Value)); // What if response returns someone else has grabbed this?????
            //string x = HttpContext.Current.Request.Url.AbsolutePath.ToLower();

            //var y = HttpContext.Current.Request.Url;

            //string scheme = HttpContext.Current.Request.Url.Scheme + "://";
            //string authority = HttpContext.Current.Request.Url.Authority + "/";
            //string basefolder = "onlinetest"; // blank, online, or onlinetest

            string emaillink = webprotocol + "://" + webserver + "/" + "/Appointments/Maintenance.aspx?reference=" + hf_newreference.Value;
            rootXml.Add(new XElement("emaillink", emaillink)); // What if response returns someone else has grabbed this?????
            rootXml.Add(new XElement("screenlink", "../Appointments/Maintenance.aspx?reference=" + hf_newreference.Value)); // What if response returns someone else has grabbed this?????


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

            /*

            //THE CALENDAR TEMPLATE
            string calendartemplate = Server.MapPath("~") + "\\calendarTemplate.txt";
            string calendardocument = "";


            try
            {
                using (StreamReader sr = new StreamReader(calendartemplate))
                {
                    calendardocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, "CalendarTemplate: " + ex.Message, "");
            }
            */
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);


            if (1==2) { 

                string UID = hf_newreference.Value + "@wdc.whanganui.govt.nz";
                string DTSTAMP = DateTime.UtcNow.ToString("yyyyMMdd'T'HHmmss'Z'");

                StringBuilder calendardocument = new StringBuilder();
                calendardocument.AppendLine("BEGIN:VCALENDAR");                                    //BEGIN:VCALENDAR
                calendardocument.AppendLine("METHOD:REQUEST");
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
                calendardocument.AppendLine("SUMMARY:" + "Whanganui District Council Rates Rebate Appointment");
                //calendardocument.AppendLine("DESCRIPTION;LANGUAGE=en-NZ:" + @"http://wdc.whanganui.govt.nz/onlineTEST/appointments/ratesrebates.aspx");
                //calendardocument.AppendLine(@" \n\n\n\n http://wdc.whanganui.govt.nz/onlinetest/Finance/RatesRebate.aspx\n");
                calendardocument.AppendLine("DESCRIPTION;LANGUAGE=en-NZ:" + emaillink);
                calendardocument.AppendLine("LOCATION:" + "Whanganui District Council ground floor");
                calendardocument.AppendLine("BEGIN:VALARM");                                               //BEGIN:VALARM
                calendardocument.AppendLine("ACTION:DISPLAY");
                calendardocument.AppendLine("DESCRIPTION:" + "Your appointment for a rates rebate is in 1 hours time");
                calendardocument.AppendLine("TRIGGER:-PT1H");
                calendardocument.AppendLine("END:VALARM");                                                 //END:VALARM
                calendardocument.AppendLine("END:VEVENT");                                             //END:VEVENT
                calendardocument.AppendLine("END:VCALENDAR");                                      //END:VCALENDAR


                WDCFunctions.sendemailwithAttachments(emailSubject, emaildocument, Request.Form["tb_emailaddress"], emailBCC, calendardocument.ToString());

            } else
            {
                WDCFunctions.sendemail(emailSubject, emaildocument, Request.Form["tb_emailaddress"], emailBCC);

            }

            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);

            //"<pre><code>" + HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) + "</code></pre><br />" + 
            Session["body"] = ScreenOutput.ToString();


            Response.Redirect("../Completed/noMaster.aspx");
        }
    }
}