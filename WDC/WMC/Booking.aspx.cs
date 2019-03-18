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
    public partial class Booking : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        public string[] yesno_values = new string[2] { "Yes", "No" };
        #endregion

        #region fields
        public string reference;
        public string tb_applicant;
        public string tb_organisation;
        public string tb_charityregistration;
        public string tb_emailaddress;
        public string tb_postaladdress;
        public string tb_invoiceaddress;
        public string tb_mobilephone;
        public string tb_homephone;
        public string tb_workphone;
        public string dd_eventtype;
        public string tb_description;
        public string tb_overallnumbers;
        public string dd_feecharged;
        public string dd_liquor;
        public string dd_liquorsales;
        public string dd_liquorlicence;
        public string dd_music;
        public string dd_publicinformation;
        public string tb_publictext;
        public string dd_photos;
        public string cb_fullcomplex;
        public string cb_main;
        public string cb_pioneer;
        public string cb_concert;
        public string cb_kitchen;
        public string tb_datefrom;
        public string tb_dateto;

        //public string tb_datetimein_main_1;
        //public string tb_datetimeout_main_1;
        //public string tb_datetimecomments_main_1;
        public string tb_main_projectorscreenlaptop;
        public string tb_main_soundsystem;
        public string tb_main_curtains;
        //public string tb_datetimein_pioneer_1;
        //public string tb_datetimeout_pioneer_1;
        //public string tb_datetimecomments_pioneer_1;
        public string tb_pioneer_projectorscreenlaptop;
        public string tb_pioneer_soundsystem;
        //public string tb_datetimein_concert_1;
        //public string tb_datetimeout_concert_1;
        //public string tb_datetimecomments_concert_1;
        public string tb_concert_projectorscreenlaptop;
        public string tb_concert_soundsystem;
        public string dd_concert_piano;
        public string dd_concert_pianotuning;
        //public string tb_datetimein_kitchen_1;
        //public string tb_datetimeout_kitchen_1;
        //public string tb_datetimecomments_kitchen_1;
        public string tb_general_teacoffee;
        public string tb_general_glasses;
        public string tb_general_cupssaucers;
        public string tb_general_milkjugs;
        public string tb_general_hotwaterurns;
        public string tb_general_chaircovers;
        public string tb_general_chairsaches;
        public string tb_general_tablecloths;
        public string tb_general_whiteboard;
        public string tb_general_lectern;
        public string tb_general_smokebeamisolation;
        public string tb_general_projectorscreenlaptop;
        public string tb_general_soundsystem;
        public string tb_general_partitions;
        public string tb_general_snorkellift;
        public string dd_emptyskipbin;
        public string tb_otherinformation;
        public string dd_termsandconditions;
        //public string tb_datetimein_;
        //public string tb_datetimeout_;
        //public string tb_datetimecomments_;



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

            string html_venues = "";

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_WMC_Venues", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                string id = "";
                string link = "";

                while (reader.Read())
                {
                    ID = reader["WMC_Venue_CTR"].ToString();
                    link = reader["Link"].ToString();
                    if (link != "")
                    {
                        link = " <a href='" + reader["Link"].ToString() + "' target='WMCVenue'>See detail</a>";
                    }


                    html_venues = html_venues + "<tr>";
                    html_venues = html_venues + "<td>" + reader["Name"].ToString() + link + "</td>";
                    html_venues = html_venues + "<td><input id=\"required_" + id + "\" type=\"checkbox\" /></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"accessfrom_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"accessto_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"attendanceaccessfrom_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"attendanceaccessto_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "</tr>";

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

            lit_venues.Text = html_venues;

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region parameters
            string submissionpath = WebConfigurationManager.AppSettings["WMCBooking" + ".submissionpath"] + "\\";
            string submissionurl = WebConfigurationManager.AppSettings["WMCBooking" + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["WMCBooking.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["WMCBooking.emailSubject"];
            string screenTemplate = "BookingScreen.html";
            string emailbodyTemplate = "BookingEmail.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            #region fields
            //tb_reference = Request.Form["tb_reference"].Trim();
            reference = tb_reference.Text;
            tb_applicant = Request.Form["tb_applicant"].Trim();
            tb_organisation = Request.Form["tb_organisation"].Trim();
            tb_charityregistration = Request.Form["tb_charityregistration"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_invoiceaddress = Request.Form["tb_invoiceaddress"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            tb_homephone = Request.Form["tb_homephone"].Trim();
            tb_workphone = Request.Form["tb_workphone"].Trim();
            tb_datefrom = Request.Form["tb_datefrom"].Trim();
            tb_dateto = Request.Form["tb_dateto"].Trim();
            dd_eventtype = Request.Form["dd_eventtype"].Trim();
            tb_description = Request.Form["tb_description"].Trim();
            tb_overallnumbers = Request.Form["tb_overallnumbers"].Trim();
            cb_fullcomplex = Request.Form["cb_fullcomplex"] + "";
            cb_main = Request.Form["cb_main"] + "";
            cb_pioneer = Request.Form["cb_pioneer"] + "";
            cb_concert = Request.Form["cb_concert"] + "";
            cb_kitchen = Request.Form["cb_kitchen"] + "";
            tb_otherinformation = Request.Form["tb_otherinformation"].Trim();
            dd_termsandconditions = Request.Form["dd_termsandconditions"];

            dd_feecharged = Request.Form["dd_feecharged"].Trim();
            dd_liquor = Request.Form["dd_liquor"].Trim();
            dd_liquorsales = Request.Form["dd_liquorsales"].Trim();
            dd_liquorlicence = Request.Form["dd_liquorlicence"].Trim();
            dd_music = Request.Form["dd_music"].Trim();
            dd_publicinformation = Request.Form["dd_publicinformation"].Trim();
            tb_publictext = Request.Form["tb_publictext"].Trim();
            dd_photos = Request.Form["dd_photos"].Trim();

            //tb_datetimein_main_1 = Request.Form["tb_datetimein_main_1"].Trim();
            //tb_datetimeout_main_1 = Request.Form["tb_datetimeout_main_1"].Trim();
            //tb_datetimecomments_main_1 = Request.Form["tb_datetimecomments_main_1"].Trim();
            tb_main_projectorscreenlaptop = Request.Form["tb_main_projectorscreenlaptop"].Trim();
            tb_main_soundsystem = Request.Form["tb_main_soundsystem"].Trim();
            tb_main_curtains = Request.Form["tb_main_curtains"].Trim();
            //tb_datetimein_pioneer_1 = Request.Form["tb_datetimein_pioneer_1"].Trim();
            //tb_datetimeout_pioneer_1 = Request.Form["tb_datetimeout_pioneer_1"].Trim();
            //tb_datetimecomments_pioneer_1 = Request.Form["tb_datetimecomments_pioneer_1"].Trim();
            tb_pioneer_projectorscreenlaptop = Request.Form["tb_pioneer_projectorscreenlaptop"].Trim();
            tb_pioneer_soundsystem = Request.Form["tb_pioneer_soundsystem"].Trim();
            //tb_datetimein_concert_1 = Request.Form["tb_datetimein_concert_1"].Trim();
            //tb_datetimeout_concert_1 = Request.Form["tb_datetimeout_concert_1"].Trim();
            //tb_datetimecomments_concert_1 = Request.Form["tb_datetimecomments_concert_1"].Trim();
            tb_concert_projectorscreenlaptop = Request.Form["tb_concert_projectorscreenlaptop"].Trim();
            tb_concert_soundsystem = Request.Form["tb_concert_soundsystem"].Trim();
            dd_concert_piano = Request.Form["dd_concert_piano"].Trim();
            dd_concert_pianotuning = Request.Form["dd_concert_pianotuning"].Trim();
            //tb_datetimein_kitchen_1 = Request.Form["tb_datetimein_kitchen_1"].Trim();
            //tb_datetimeout_kitchen_1 = Request.Form["tb_datetimeout_kitchen_1"].Trim();
            //tb_datetimecomments_kitchen_1 = Request.Form["tb_datetimecomments_kitchen_1"].Trim();
            tb_general_teacoffee = Request.Form["tb_general_teacoffee"].Trim();
            tb_general_glasses = Request.Form["tb_general_glasses"].Trim();
            tb_general_cupssaucers = Request.Form["tb_general_cupssaucers"].Trim();
            tb_general_milkjugs = Request.Form["tb_general_milkjugs"].Trim();
            tb_general_hotwaterurns = Request.Form["tb_general_hotwaterurns"].Trim();
            tb_general_chaircovers = Request.Form["tb_general_chaircovers"].Trim();
            tb_general_chairsaches = Request.Form["tb_general_chairsaches"].Trim();
            tb_general_tablecloths = Request.Form["tb_general_tablecloths"].Trim();
            tb_general_whiteboard = Request.Form["tb_general_whiteboard"].Trim();
            tb_general_lectern = Request.Form["tb_general_lectern"].Trim();
            tb_general_smokebeamisolation = Request.Form["tb_general_smokebeamisolation"].Trim();
            tb_general_projectorscreenlaptop = Request.Form["tb_general_projectorscreenlaptop"].Trim();
            tb_general_soundsystem = Request.Form["tb_general_soundsystem"].Trim();
            tb_general_partitions = Request.Form["tb_general_partitions"].Trim();
            tb_general_snorkellift = Request.Form["tb_general_snorkellift"].Trim();
            dd_emptyskipbin = Request.Form["dd_emptyskipbin"].Trim();
            //tb_datetimein_ = Request.Form["tb_datetimein_"].Trim();
            //tb_datetimeout_ = Request.Form["tb_datetimeout_"].Trim();
            //tb_datetimecomments_ = Request.Form["tb_datetimecomments_"].Trim();



            #endregion

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "Update_WMC_Booking";
            cmd.Parameters.Add("@Booking_CTR", SqlDbType.Int).Value = 0; // hf_booking_ctr.Value;
            cmd.Parameters.Add("@entity_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;

            cmd.Parameters.Add("@applicant", SqlDbType.VarChar).Value = tb_applicant;
            cmd.Parameters.Add("@organisation", SqlDbType.VarChar).Value = tb_organisation;
            cmd.Parameters.Add("@charityregistration", SqlDbType.VarChar).Value = tb_charityregistration;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@invoiceaddress", SqlDbType.VarChar).Value = tb_invoiceaddress;
            cmd.Parameters.Add("@mobilephone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@homephone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@workphone", SqlDbType.VarChar).Value = tb_workphone;
            cmd.Parameters.Add("@eventtype", SqlDbType.VarChar).Value = dd_eventtype;
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = tb_description;
            cmd.Parameters.Add("@overallnumbers", SqlDbType.VarChar).Value = tb_overallnumbers;
            cmd.Parameters.Add("@fullcomplex", SqlDbType.VarChar).Value = cb_fullcomplex;
            cmd.Parameters.Add("@main", SqlDbType.VarChar).Value = cb_main;
            cmd.Parameters.Add("@pioneer", SqlDbType.VarChar).Value = cb_pioneer;
            cmd.Parameters.Add("@concert", SqlDbType.VarChar).Value = cb_concert;
            cmd.Parameters.Add("@kitchen", SqlDbType.VarChar).Value = cb_kitchen;
            cmd.Parameters.Add("@datefrom", SqlDbType.VarChar).Value = tb_datefrom;
            cmd.Parameters.Add("@dateto", SqlDbType.VarChar).Value = tb_dateto;

            cmd.Parameters.Add("@feecharged", SqlDbType.VarChar).Value = dd_feecharged;
            cmd.Parameters.Add("@liquor", SqlDbType.VarChar).Value = dd_liquor;
            cmd.Parameters.Add("@liquorsales", SqlDbType.VarChar).Value = dd_liquorsales;
            cmd.Parameters.Add("@liquorlicence", SqlDbType.VarChar).Value = dd_liquorlicence;
            cmd.Parameters.Add("@music", SqlDbType.VarChar).Value = dd_music;
            cmd.Parameters.Add("@publicinformation", SqlDbType.VarChar).Value = dd_publicinformation;
            cmd.Parameters.Add("@publictext", SqlDbType.VarChar).Value = tb_publictext;
            cmd.Parameters.Add("@photos", SqlDbType.VarChar).Value = dd_photos;

            //cmd.Parameters.Add("@datetimein_main_1", SqlDbType.VarChar).Value = tb_datetimein_main_1;
            //cmd.Parameters.Add("@datetimeout_main_1", SqlDbType.VarChar).Value = tb_datetimeout_main_1;
            //cmd.Parameters.Add("@datetimecomments_main_1", SqlDbType.VarChar).Value = tb_datetimecomments_main_1;
            //cmd.Parameters.Add("@main_projectorscreenlaptop", SqlDbType.VarChar).Value = tb_main_projectorscreenlaptop;
            cmd.Parameters.Add("@main_soundsystem", SqlDbType.VarChar).Value = tb_main_soundsystem;
            cmd.Parameters.Add("@main_curtains", SqlDbType.VarChar).Value = tb_main_curtains;
            //cmd.Parameters.Add("@datetimein_pioneer_1", SqlDbType.VarChar).Value = tb_datetimein_pioneer_1;
            //cmd.Parameters.Add("@datetimeout_pioneer_1", SqlDbType.VarChar).Value = tb_datetimeout_pioneer_1;
            //cmd.Parameters.Add("@datetimecomments_pioneer_1", SqlDbType.VarChar).Value = tb_datetimecomments_pioneer_1;
            cmd.Parameters.Add("@pioneer_projectorscreenlaptop", SqlDbType.VarChar).Value = tb_pioneer_projectorscreenlaptop;
            cmd.Parameters.Add("@pioneer_soundsystem", SqlDbType.VarChar).Value = tb_pioneer_soundsystem;
            //cmd.Parameters.Add("@datetimein_concert_1", SqlDbType.VarChar).Value = tb_datetimein_concert_1;
            //cmd.Parameters.Add("@datetimeout_concert_1", SqlDbType.VarChar).Value = tb_datetimeout_concert_1;
            //cmd.Parameters.Add("@datetimecomments_concert_1", SqlDbType.VarChar).Value = tb_datetimecomments_concert_1;
            cmd.Parameters.Add("@concert_projectorscreenlaptop", SqlDbType.VarChar).Value = tb_concert_projectorscreenlaptop;
            cmd.Parameters.Add("@concert_soundsystem", SqlDbType.VarChar).Value = tb_concert_soundsystem;
            cmd.Parameters.Add("@concert_piano", SqlDbType.VarChar).Value = dd_concert_piano;
            cmd.Parameters.Add("@concert_pianotuning", SqlDbType.VarChar).Value = dd_concert_pianotuning;
            //cmd.Parameters.Add("@datetimein_kitchen_1", SqlDbType.VarChar).Value = tb_datetimein_kitchen_1;
            //cmd.Parameters.Add("@datetimeout_kitchen_1", SqlDbType.VarChar).Value = tb_datetimeout_kitchen_1;
            //cmd.Parameters.Add("@datetimecomments_kitchen_1", SqlDbType.VarChar).Value = tb_datetimecomments_kitchen_1;
            cmd.Parameters.Add("@general_teacoffee", SqlDbType.VarChar).Value = tb_general_teacoffee;
            cmd.Parameters.Add("@general_glasses", SqlDbType.VarChar).Value = tb_general_glasses;
            cmd.Parameters.Add("@general_cupssaucers", SqlDbType.VarChar).Value = tb_general_cupssaucers;
            cmd.Parameters.Add("@general_milkjugs", SqlDbType.VarChar).Value = tb_general_milkjugs;
            cmd.Parameters.Add("@general_hotwaterurns", SqlDbType.VarChar).Value = tb_general_hotwaterurns;
            cmd.Parameters.Add("@general_chaircovers", SqlDbType.VarChar).Value = tb_general_chaircovers;
            cmd.Parameters.Add("@general_chairsaches", SqlDbType.VarChar).Value = tb_general_chairsaches;
            cmd.Parameters.Add("@general_tablecloths", SqlDbType.VarChar).Value = tb_general_tablecloths;
            cmd.Parameters.Add("@general_whiteboard", SqlDbType.VarChar).Value = tb_general_whiteboard;
            cmd.Parameters.Add("@general_lectern", SqlDbType.VarChar).Value = tb_general_lectern;
            cmd.Parameters.Add("@general_smokebeamisolation", SqlDbType.VarChar).Value = tb_general_smokebeamisolation;
            cmd.Parameters.Add("@general_projectorscreenlaptop", SqlDbType.VarChar).Value = tb_general_projectorscreenlaptop;
            cmd.Parameters.Add("@general_soundsystem", SqlDbType.VarChar).Value = tb_general_soundsystem;
            cmd.Parameters.Add("@general_partitions", SqlDbType.VarChar).Value = tb_general_partitions;
            cmd.Parameters.Add("@general_snorkellift", SqlDbType.VarChar).Value = tb_general_snorkellift;
            cmd.Parameters.Add("@emptyskipbin", SqlDbType.VarChar).Value = dd_emptyskipbin;
            cmd.Parameters.Add("@termsandconditions", SqlDbType.VarChar).Value = dd_termsandconditions;

            cmd.Parameters.Add("@otherinformation", SqlDbType.VarChar).Value = tb_otherinformation;
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
            WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);
            #endregion

            Response.Redirect("completed.aspx?module=" + "WMCBooking" + "&id=" + reference);

        }
    }
}