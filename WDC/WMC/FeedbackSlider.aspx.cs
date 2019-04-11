using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;
using System.IO;

namespace Online.WMC
{
    public partial class FeedbackSlider : System.Web.UI.Page
    {
 #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        public string[] yesno_values = new string[2] { "Yes", "No" };
        #endregion

        #region fields
        public string reference;
        public string tb_bookingease;
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
            string module = "WMCFeedback";

            string submissionpath = WebConfigurationManager.AppSettings[module + ".submissionpath"] + "\\";
            string submissionurl = WebConfigurationManager.AppSettings[module + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings[module + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[module + ".emailSubject"];
            string screenTemplate = "FeedbackScreen.html";
            string emailbodyTemplate = "FeedbackEmail.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            #region fields

            tb_bookingease = Request.Form["tb_bookingease"].Trim();



            #endregion

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "Update_WMC_Feedback";
            cmd.Parameters.Add("@Booking_CTR", SqlDbType.Int).Value = 0; // hf_booking_ctr.Value;
            cmd.Parameters.Add("@entity_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;


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
            documentvalues["mode"] = "enquiry";

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
            WDCFunctions.sendemail(emailSubject, emaildocument, emailBCC, "");
            #endregion

            Response.Redirect("completed.aspx?id=" + reference);



        }
    }
}