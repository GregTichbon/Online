using System;
using System.Collections.Generic;
/*
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
*/

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;
using System.IO;

namespace Online.WMC
{
    public partial class Feedback : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        public string[] yesno_values = new string[2] { "Yes", "No" };
        #endregion

        #region fields
        public string reference;
        public string tb_event;
        public string dd_bookingease;
        public string tb_bookingease;
        public string dd_communications;
        public string tb_communications;
        public string dd_staffknowledge;
        public string tb_staffknowledge;
        public string dd_overallexperience;
        public string tb_overallexperience;
        public string tb_othercomments;
        public string tb_name;
        public string tb_contactdetails;
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
            string submissionpath = WebConfigurationManager.AppSettings["WMCFeedback" + ".submissionpath"] + "\\";
            string submissionurl = WebConfigurationManager.AppSettings["WMCFeedback" + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["WMCFeedback.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["WMCFeedback.emailSubject"];
            string screenTemplate = "FeedbackScreen.html";
            string emailbodyTemplate = "FeedbackEmail.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            #region fields
            //tb_reference = Request.Form["tb_reference"].Trim();
            reference = tb_reference.Text;
            tb_event = Request.Form["tb_event"].Trim();
            dd_bookingease = Request.Form["dd_bookingease"].Trim();
            tb_bookingease = Request.Form["tb_bookingease"].Trim();
            dd_communications = Request.Form["dd_communications"].Trim();
            tb_communications = Request.Form["tb_communications"].Trim();
            dd_staffknowledge = Request.Form["dd_staffknowledge"].Trim();
            tb_staffknowledge = Request.Form["tb_staffknowledge"].Trim();
            dd_overallexperience = Request.Form["dd_overallexperience"].Trim();
            tb_overallexperience = Request.Form["tb_overallexperience"].Trim();
            tb_othercomments = Request.Form["tb_othercomments"].Trim();
            tb_name = Request.Form["tb_name"].Trim();
            tb_contactdetails = Request.Form["tb_contactdetails"].Trim();


            #endregion

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "Update_WMC_Feedback";
            cmd.Parameters.Add("@feedback_CTR", SqlDbType.Int).Value = 0; // hf_booking_ctr.Value;
            cmd.Parameters.Add("@entity_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;

            cmd.Parameters.Add("@event", SqlDbType.VarChar).Value = tb_event;
            cmd.Parameters.Add("@bookingease", SqlDbType.VarChar).Value = dd_bookingease;
            cmd.Parameters.Add("@bookingease_comment", SqlDbType.VarChar).Value = tb_bookingease;
            cmd.Parameters.Add("@communications", SqlDbType.VarChar).Value = dd_communications;
            cmd.Parameters.Add("@communications_comment", SqlDbType.VarChar).Value = tb_communications;
            cmd.Parameters.Add("@staffknowledge", SqlDbType.VarChar).Value = dd_staffknowledge;
            cmd.Parameters.Add("@staffknowledge_comment", SqlDbType.VarChar).Value = tb_staffknowledge;
            cmd.Parameters.Add("@overallexperience", SqlDbType.VarChar).Value = dd_overallexperience;
            cmd.Parameters.Add("@overallexperience_comment", SqlDbType.VarChar).Value = tb_overallexperience;
            cmd.Parameters.Add("@othercomments", SqlDbType.VarChar).Value = tb_othercomments;
            cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = tb_name;
            cmd.Parameters.Add("@contactdetails", SqlDbType.VarChar).Value = tb_contactdetails;

        #endregion

        #region save data (Standard)
        cmd.Connection = con;
            try
            {
                con.Open();
                //hf_booking_ctr.Value = cmd.ExecuteScalar().ToString();
                string temp = cmd.ExecuteScalar().ToString();
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
            #endregion

            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = reference;

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

            path = Server.MapPath("~");
            try
            {
                using (StreamWriter outfile = new StreamWriter(submissionpath + reference + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            // THE EMAIL
            path = Server.MapPath(".");
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

            emailbodydocument = WDCFunctions.documentfillwithRF(emailbodydocument, documentvalues, Request.Form);

            //THE EMAIL TEMPLATE
            path = Server.MapPath("..");
            string emailtemplate = path + "\\EmailTemplate\\wmc_standard.html";
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
            WDCFunctions.sendemail(emailSubject, emaildocument, "", emailBCC);
            #endregion

            Response.Redirect("completed.aspx?module=" + "WMCFeedback" + "&id=" + reference);
        }
    }
    
}