using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Online.Facilities
{
    public partial class EnquiryFeedback : System.Web.UI.Page
    {
        #region Class Parameters
        static Boolean inhibit_hubble = false;
        #endregion

        #region fields
        /*
        public string cb_venue;
        public string tb_highlight;
        public string tb_number1factor;
        public string tb_tailoring;
        public string tb_references;
        public string tb_team;
        public string tb_venue;
        public string tb_services;
        public string tb_advise;
        public string tb_additional;
        public string tb_name;
        */
        public string tb_emailaddress;
        //public string tb_phonedetails;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

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

            #region parameters
            /*
            <add key="FacilitiesEnquiryFeedback.emailBCC" value="greg.tichbon@whanganui.govt.nz"></add>
            <add key="FacilitiesEnquiryFeedback.emailSubject" value="Facilities Enquiry Feedback"></add>
            <add key="FacilitiesEnquiryFeedback.submissionpath" value="c:\\inetpub\\onlineSubmissions\\PolicySubmissions\\"></add>
            <add key="FacilitiesEnquiryFeedback.submissionurl" value="/onlineTEST/onlinesubmissions/PolicySubmissions/"></add>
            */

            string moduleName = "FacilitiesEnquiryFeedback";

            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"];

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];
            string screenTemplate = "EnquiryFeedbackScreen.html";
            string emailbodyTemplate = "EnquiryFeedbackEmail.html";
            #endregion

            #region fields
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            #endregion

            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_" + moduleName + "XML", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            cmd.Parameters.Add("@module_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard
            // Not required cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = Entity_CTR;  //Standard
            // Not requiredcmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;  //Standard
            #endregion //setup specific data

            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            WDCFunctions.createXMLStructure(repeatertable, Request.Form, rootXml);
            WDCFunctions.populateXML(repeatertable, rootXml);
            #endregion //BuildXML

            cmd.Parameters.Add("@xml", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());

            #region save data (Standard)
            Int32 ctr = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    ctr = Convert.ToInt32(dr["ctr"].ToString());
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

            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = tb_reference.Text;

            #region set up email, redirection, final processing (Standard)
            string path = Server.MapPath(".");

            // THE SUMMARY DISPLAYED ON THE SCREEN
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

            screendocument = WDCFunctions.documentfillwithRF(screendocument, documentvalues, Request.Form);

           // path = Server.MapPath("~");
            try
            {
                System.IO.Directory.CreateDirectory(submissionpath);
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            // THE EMAIL
            //path = Server.MapPath(".");
            string emailbodypath = path + "\\" + emailbodyTemplate;
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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            string useEmailaddress;
            string useemailBCC;

            if (tb_emailaddress != "")
            {
                useEmailaddress = tb_emailaddress;
                useemailBCC = emailBCC;
            }
            else
            {
                useEmailaddress = emailBCC;
                useemailBCC = "";
            }


            emailbodydocument = WDCFunctions.documentfillwithRF(emailbodydocument, documentvalues, Request.Form);

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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);
            #endregion

            #region create smart list item in hubble
            if (!inhibit_hubble)
            {
                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
                Dictionary<string, string> metaAllFields = new Dictionary<string, string>(2);
                metaAllFields.Add("DocumentType", "CORRESPONDENCE, Email, Memo, Survey");
                metaAllFields.Add("Narrative", "Online Enquiry Feedback");
                //metaAllFields.Add("PropertyNo", Request.Form["hf_property_number"]);
                string hubbleurl = WebConfigurationManager.AppSettings["hubbleurl"];

                HF.UploadFile(hubbleurl + "team/venue/", "Team Administration", "admin/", "Online Enquiry Feedback - Reference " + tb_reference.Text + ".html", Encoding.ASCII.GetBytes(emaildocument), metaAllFields);
            }
            #endregion


            Session["body"] = screendocument;
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");
        }
    }
}