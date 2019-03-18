using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Facilities
{
    public partial class BookingEnquiry : System.Web.UI.Page
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
        public string tb_eventfrom;
        public string tb_eventto;
        
        /*
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

        */

        /*
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
        */
        public string tb_otherinformation;

        /*
        public string cb_wmc_fullcomplex;
        public string cb_wmc_main;
        public string cb_wmc_pioneer;
        public string cb_wmc_concert;
        public string cb_wmc_kitchen;

        public string cb_cg_fullcomplex;
        public string cb_cg_corporatebox;
        public string cb_cg_functioncentre;
        public string cb_cg_mainfield;
        public string cb_cg_velodrome;

        public string cb_oh_fulltheatre;
        public string cb_oh_auditorium;
        public string cb_oh_annex;
        */

        public string cb_venue;

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
            string submissionpath = WebConfigurationManager.AppSettings["FacilityBookingEnquiry" + ".submissionpath"] + "\\";
            string submissionurl = WebConfigurationManager.AppSettings["FacilityBookingEnquiry" + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["FacilityBookingEnquiry.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["FacilityBookingEnquiry.emailSubject"];
            string screenTemplate = "BookingEnquiryScreen.html";
            string emailbodyTemplate = "BookingEnquiryEmail.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            //WDCFunctions.Log(Request.RawUrl, "Test1", "greg.tichbon@whanganui.govt.nz");


            #region fields
            //tb_reference = Request.Form["tb_reference"].Trim();
            reference = tb_reference.Text;
            tb_applicant = Request.Form["tb_applicant"].Trim();
            tb_organisation = Request.Form["tb_organisation"].Trim();
            //tb_charityregistration = Request.Form["tb_charityregistration"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            //tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            //tb_invoiceaddress = Request.Form["tb_invoiceaddress"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            tb_homephone = Request.Form["tb_homephone"].Trim();
            tb_workphone = Request.Form["tb_workphone"].Trim();
            tb_eventfrom = Request.Form["tb_eventfrom"].Trim();
            tb_eventto = Request.Form["tb_eventto"].Trim();
            dd_eventtype = Request.Form["dd_eventtype"].Trim();
            tb_description = Request.Form["tb_description"].Trim();
            tb_overallnumbers = Request.Form["tb_overallnumbers"].Trim();

            /*
            cb_wmc_fullcomplex = Request.Form["cb_wmc_fullcomplex"] + "";
            cb_wmc_main = Request.Form["cb_wmc_main"] + "";
            cb_wmc_pioneer = Request.Form["cb_wmc_pioneer"] + "";
            cb_wmc_concert = Request.Form["cb_wmc_concert"] + "";
            cb_wmc_kitchen = Request.Form["cb_wmc_kitchen"] + "";

            cb_cg_fullcomplex = Request.Form["cb_cg_fullcomplex"] + "";
            cb_cg_corporatebox = Request.Form["cb_cg_corporatebox"] + "";
            cb_cg_functioncentre = Request.Form["cb_cg_functioncentre"] + "";
            cb_cg_mainfield = Request.Form["cb_cg_mainfield"] + "";
            cb_cg_velodrome = Request.Form["cb_cg_velodrome"] + "";

            cb_oh_fulltheatre = Request.Form["cb_oh_fulltheatre"] + "";
            cb_oh_auditorium = Request.Form["cb_oh_auditorium"] + "";
            cb_oh_annex = Request.Form["cb_oh_annex"] + "";
            */
            cb_venue = Request.Form["cb_venue"] + "";

            tb_otherinformation = Request.Form["tb_otherinformation"].Trim();
            //dd_termsandconditions = Request.Form["dd_termsandconditions"];
            #endregion

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "facilities_update_event";
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Enquiry"; // hf_booking_ctr.Value;

            cmd.Parameters.Add("@facilities_event_ctr", SqlDbType.VarChar).Value = "0"; // hf_booking_ctr.Value;
            cmd.Parameters.Add("@entity_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;

            cmd.Parameters.Add("@applicant", SqlDbType.VarChar).Value = tb_applicant;
            cmd.Parameters.Add("@organisation", SqlDbType.VarChar).Value = tb_organisation;
            //cmd.Parameters.Add("@charityregistration", SqlDbType.VarChar).Value = tb_charityregistration;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            //cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress.Replace(Environment.NewLine, "<br />")
            //cmd.Parameters.Add("@invoiceaddress", SqlDbType.VarChar).Value = tb_invoiceaddress.Replace(Environment.NewLine, "<br />")
            cmd.Parameters.Add("@mobilephone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@homephone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@workphone", SqlDbType.VarChar).Value = tb_workphone;

            cmd.Parameters.Add("@eventtype", SqlDbType.VarChar).Value = dd_eventtype;
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = tb_description.Replace(Environment.NewLine, "<br />");
            cmd.Parameters.Add("@overallnumbers", SqlDbType.VarChar).Value = tb_overallnumbers;
            /*
                        cmd.Parameters.Add("@wmc_fullcomplexfullcomplex", SqlDbType.VarChar).Value = cb_wmc_fullcomplex;
                        cmd.Parameters.Add("@wmc_mainfullcomplex", SqlDbType.VarChar).Value = cb_wmc_main;
                        cmd.Parameters.Add("@wmc_pioneerfullcomplex", SqlDbType.VarChar).Value = cb_wmc_pioneer;
                        cmd.Parameters.Add("@wmc_concertfullcomplex", SqlDbType.VarChar).Value = cb_wmc_concert;
                        cmd.Parameters.Add("@wmc_kitchenfullcomplex", SqlDbType.VarChar).Value = cb_wmc_kitchen;

                        cmd.Parameters.Add("@cg_fullcomplexfullcomplex", SqlDbType.VarChar).Value = cb_cg_fullcomplex;
                        cmd.Parameters.Add("@cg_corporateboxfullcomplex", SqlDbType.VarChar).Value = cb_cg_corporatebox;
                        cmd.Parameters.Add("@cg_functioncentrefullcomplex", SqlDbType.VarChar).Value = cb_cg_functioncentre;
                        cmd.Parameters.Add("@cg_mainfieldfullcomplex", SqlDbType.VarChar).Value = cb_cg_mainfield;
                        cmd.Parameters.Add("@cg_velodromefullcomplex", SqlDbType.VarChar).Value = cb_cg_velodrome;

                        cmd.Parameters.Add("@oh_fulltheatrefullcomplex", SqlDbType.VarChar).Value = cb_oh_fulltheatre;
                        cmd.Parameters.Add("@oh_auditoriumfullcomplex", SqlDbType.VarChar).Value = cb_oh_auditorium;
                        cmd.Parameters.Add("@oh_annexfullcomplex", SqlDbType.VarChar).Value = cb_oh_annex;
            */
            cmd.Parameters.Add("@venue", SqlDbType.VarChar).Value = cb_venue;

            cmd.Parameters.Add("@eventfrom", SqlDbType.VarChar).Value = tb_eventfrom;
            cmd.Parameters.Add("@eventto", SqlDbType.VarChar).Value = tb_eventto;
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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion

            Dictionary<string, string> facilities = new Dictionary<string, string>();
            facilities["WMC"] = "War Memorial Centre";
            facilities["WMC-Full"] = "Full complex";
            facilities["WMC-MH"] = "Main hall";
            facilities["WMC-PR"] = "Pioneer room";
            facilities["WMC-CC"] = "Concert chamber";
            facilities["WMC-K"] = "Kitchen";
            facilities["WMC-DF"] = "Downstairs foyer";
            facilities["WMC-UF"] = "Upstairs foyer";
            facilities["WMC-FC"] = "Forecourt";
            facilities["CG"] = "Cooks Gardens";
            facilities["CG-Full"] = "Full complex";
            facilities["CG-CB"] = "Corporate Box(es)";
            facilities["CG-FC"] = "Function Centre";
            facilities["CG-MF"] = "Main Field";
            facilities["CG-K"] = "Kitchen";
            facilities["CG-GS"] = "Whiskas Grandstand & Changing Rooms";
            facilities["CG-V"] = " Velodrome";
            facilities["OH"] = "Royal Whanganui Opera House";
            facilities["OH-Full"] = "Full theatre";
            facilities["OH-AU"] = "Auditorium";
            facilities["OH-AN"] = "Annex";
            facilities["OH-LB"] = "Lounge/Bar";

            string venuedetail = "";
            string lastvenue = "";
            Boolean subvenue = false;
            Boolean fullflag = false;

            if (cb_venue != "")
            {
                string[] venues = cb_venue.Split(',');
                foreach (string venue in venues)
                {
                    if (venue.Substring(0, 2) != lastvenue)
                    {
                        if (fullflag)
                        {
                            venuedetail += "</ul>";
                            fullflag = false;
                        }

                        if (lastvenue != "")
                        {
                            venuedetail += "</ul>";
                            subvenue = false;
                        }
                        venuedetail += "<b>" + facilities[venue] + "</b>";
                        lastvenue = venue.Substring(0, 2);
                    }
                    else
                    {
                        if (!subvenue)
                        {
                            venuedetail += "<ul>";
                            subvenue = true;
                        }
                        venuedetail += "<li>" + facilities[venue] + "</li>";
                        if (venue.EndsWith("-Full"))
                        {
                            venuedetail += "<ul>";
                            fullflag = true;
                        }
                    }
                }
                if (subvenue)
                {
                    venuedetail += "</ul>";
                }
                if (fullflag)
                {
                    venuedetail += "</ul>";
                }
            }



            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = reference;
            documentvalues["venues"] = venuedetail;

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
                System.IO.Directory.CreateDirectory(submissionpath);
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
            string emailtemplate = path + "\\EmailTemplate\\facilities_standard.html";
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

            Response.Redirect("completed.aspx?module=" + "FacilityBookingEnquiry" + "&id=" + reference);

        }
    }
}