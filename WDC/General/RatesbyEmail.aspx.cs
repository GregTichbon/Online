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

namespace Online.General
{
    public partial class RatesbyEmail : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        static string moduleName = "RatesbyEmail";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            //tb_property.Text = Request.QueryString["property"];

            string wdcscripts = "";
            if (Request.QueryString["populate"] != null)
            {
                wdcscripts += "$.getScript('../scripts/wdc/populate.js');";
            }
            if (Request.QueryString["showfields"] != null)
            {
                wdcscripts += "$.getScript('../scripts/wdc/showfields.js');";
            }
            if (wdcscripts != "")
            {
                wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
            }


            tb_reference.Text = WDCFunctions.getReference("datetime");
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

            //WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
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


            //save a copy of formatdocument in submissions
            try
            {
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
                {
                    outfile.Write(ScreenOutput.ToString());
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }



            //"<pre><code>" + HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) + "</code></pre><br />" + 
            Session["body"] = ScreenOutput.ToString();

            Response.Redirect("../Completed");
        }
    }
}