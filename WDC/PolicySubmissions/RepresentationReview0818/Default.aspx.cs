﻿using System;
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

namespace Online.PolicySubmissions.RepresentationReview0818
{
    public partial class _default : System.Web.UI.Page
    {

        #region Class Parameters
        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };
        public string[] agegroups = new string[6] { "Under 18 years", "18 - 29 years", "30 - 39 years", "40 - 49 years", "50 - 59 years", "60 years or over" };
        public string[] ratings1 = new string[5] { "Strongly<br />agree", "Agree", "Neither<br />agree<br />nor<br />disagree", "Disagree", "Strongly<br />disagree" };
        public string[] locations = new string[13]
        {
            "Aramoho (Lower Aramoho, Upper Aramoho)",
            "Bastia Hill / Durie Hill",
            "Blueskin- Maxwell",
            "Castlecliff  (Castlecliff North, Castlecliff South, Mosston)",
            "Fordell-Kakatahi",
            "Gonville (Balgownie, Tawhero, Gonville South, Gonville East, Gonville West)",
            "Marybank-Gordon Park",
            "Putiki",
            "St Johns Hill / Otamatea",
            "Springvale (Springvale West, Springvale East, Mosston)",
            "Whanganui Central (Laird Park,  Whanganui Central, Whanganui Collegiate)",
            "Whanganui East (Williams Domain, Wembley Park, Kowhai Park)",
            "Other"
        };

        public string administration = "";
        public DateTime closes;
        public string closesfull;
        public string form;
        public string formlink;
        public string title;
        public string shorttitle;
        public string submissionshearing;
        public string bylawpolicy;
        public string SP;
        public string shortname;
        public string specificemailsubject;



        public Dictionary<string, string> documentvalues = new Dictionary<string, string>();


        #endregion

        #region fields
        public string reference;
        public string tb_firstname;
        public string tb_lastname;
        public string tb_emailaddress;
        public string tb_postaladdress;
        public string tb_daytimephonenumber;
        public string dd_organisation;
        public string tb_organisationname;
        public string tb_organisationrole;
        //public string opt_q1;
        public string opt_q2;
        public string opt_q3;
        //public string opt_q4;
        public string opt_q5;
        public string opt_q6;
        public string opt_q7;
        //public string opt_q8;
        public string opt_q9;
        public string rb_location;
        public string tb_otherlocation;

        public string tb_furthercomments;
        public string cb_speak;
        public string dd_panel;
        public string dd_previoussubmission;
        public string dd_gender;
        public string dd_agegroup;
        public string cb_ethnicity;
        public string tb_otherethnicity;

        public string speak;
        public string ethnicity;
        public string location;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Submission: Representation Review";
            title = "Submission: Representation Review";
            shorttitle = "Representation Review";
            closes = new DateTime(2018, 8, 3, 16, 0, 0);
            closesfull = closes.ToString("h:mmtt dddd d MMMM yyyy");
            formlink = "http://www.whanganui.govt.nz/our-district/have-your-say/proposed-trade-waste-bylaw/Documents/Submission form Trade Waste Bylaw FINAL.pdf";
            form = ""; // "<p>Written submissions may be made by downloading the <a href=\"" + formlink + "\"</a>, completing it and posting or delivering it to:  </p>";
            submissionshearing = "DAY DATE MONTH 2018";
            bylawpolicy = "bylaw";
            SP = "PS_Update_RepresentationReview0818";
            shortname = "RepresentationReview0818";
            specificemailsubject = "Submission: Representation Review";

            if (Request.QueryString["administration"] == "0n11n3")
            {
                administration = "True";
            }
            else
            {
                if (DateTime.Now >= closes)
                {
                    Session["policysubmissions_closed"] = shorttitle;
                    Session["policysubmissions_datetime"] = closesfull;
                    Response.Redirect("../Closed.aspx");

                }
            }

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string wdcscripts = "";
            if (Request.QueryString["populate"] != null)
            {
                wdcscripts += "$.getScript('../../scripts/wdc/populate.js');";
            }
            if (Request.QueryString["showfields"] != null)
            {
                wdcscripts += "$.getScript('../../scripts/wdc/showfields.js');";
            }
            if (wdcscripts != "")
            {
                wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
            }


            reference = WDCFunctions.getReference("datetime");

            documentvalues["q1"] = "<b>COUNCIL STATUS QUO</b>";
            documentvalues["q2"] = "<b>Representation by a Mayor and 12 councillors</b> - this would mean the Whanganui District will continue to be represented by a Mayor and 12 councillors as per the current arrangement. ";
            documentvalues["q3"] = "<b>‘At large’ basis for election</b> - this would mean that the Mayor and councillors will continue to be elected by the electors of the Whanganui District as a whole (‘at large’) rather than through a ward system.  ";
            documentvalues["q4"] = "<b>RURAL COMMUNITY BOARD CHANGES</b>";
            documentvalues["q5"] = "<b>Changing the name of the ‘Wanganui Rural Community Board’ to the ‘Whanganui Rural Community Board’</b> - this would mean that the Board’s name would be consistent with the spelling of the district. ";
            documentvalues["q6"] = "<b>Boundary change for the Whanganui subdivision</b> - this would mean that the boundary for the Whanganui subdivision will be adjusted to bring the Whanganui subdivision <i>closer in line</i> with the Local Electoral Act’s population equality rule.  The Whanganui subdivision would become larger.  ";
            documentvalues["q7"] = "<b>Boundary change for the Kaitoke subdivision</b> - this would mean that the boundary for the Kaitoke subdivision will be adjusted to enable the Kaitoke subdivision to <i>meet</i> the Local Electoral Act’s population equality rule. The Kaitoke subdivision would become smaller. ";
            documentvalues["q8"] = "<b>RURAL COMMUNITY BOARD STATUS QUO</b>";
            documentvalues["q9"] = "<b>Status quo retained for all other Rural Community Board representation arrangements</b> - this would mean that the Rural Community Board will continue to consist of the following three subdivisions, with the same number of elected members: <ul><li>Kai Iwi subdivision: Three members</li><li>Whanganui subdivision: Three members</li><li>Kaitoke subdivision: Two members</li></ul>There would also continue to be two councillor appointments to the Rural Community Board.";


            lit_questions1.Text = "";
            lit_questions1.Text += "<div class=\"table-responsive\">";
            lit_questions1.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            lit_questions1.Text += "<tr>";
            lit_questions1.Text += "<td><b>KEY ISSUES</b><br />Please indicate your level of agreement for the following key issues.</td>";

            foreach (string rating in ratings1)
            {
                lit_questions1.Text += "<th class=\"tdcenter\">" + rating + "</th>";
            }
            lit_questions1.Text += "</tr>";


            for (int f1 = 1; f1 <= 9; f1++)
            {
                lit_questions1.Text += "<tr>";

                if ((f1 == 1) || (f1 == 4) || (f1 == 8))
                {
                    lit_questions1.Text += "<td colspan=\"6\" class=\"tdbold\">" + documentvalues["q" + f1.ToString()] + "</td>";
                }
                else
                {
                    lit_questions1.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                    for (int f2 = 1; f2 <= 5; f2++)
                    {
                        lit_questions1.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings1[f2 - 1].Replace("<br />", " ") + "\" /></td>";
                    }
                }
            }

            lit_questions1.Text += "</table>";
            lit_questions1.Text += "</div>";

            lit_locations.Text = "";

            int c1 = 0;
            foreach (string location in locations)
            {
                c1++;
                lit_locations.Text += "<input id=\"rb_location_" + c1 + "\" name=\"rb_location\" type=\"radio\" value=\"" + location + "\" /> " + location + "<br />";
            }

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region parameters
            /*
            <add key="PolicySubmissions.emailBCC" value="greg.tichbon@whanganui.govt.nz"></add>
            <add key="PolicySubmissions.emailSubject" value="Policy Submission Acknowledgment"></add>
            <add key="PolicySubmissions.submissionpath" value="c:\\inetpub\\onlineSubmissions\\PolicySubmissions\\"></add>
            <add key="PolicySubmissions.submissionurl" value="/onlineTEST/onlinesubmissions/PolicySubmissions/"></add>
            */


            string submissionpath = WebConfigurationManager.AppSettings["PolicySubmissions" + ".submissionpath"] + shortname + "\\";
            string submissionurl = WebConfigurationManager.AppSettings["PolicySubmissions" + ".submissionurl"] + shortname + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["PolicySubmissions.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["PolicySubmissions.emailSubject"] + " - " + specificemailsubject;
            string screenTemplate = "Screen.html";
            string emailbodyTemplate = "Email.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            #region fields
            //tb_reference = Request.Form["tb_reference"].Trim();
            //reference = tb_reference.Text;
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_daytimephonenumber = Request.Form["tb_daytimephonenumber"].Trim();
            dd_organisation = Request.Form["dd_organisation"].Trim();
            tb_organisationname = Request.Form["tb_organisationname"].Trim();
            tb_organisationrole = Request.Form["tb_organisationrole"].Trim();
            //opt_q1 = Request.Form["opt_q1"] + "";
            opt_q2 = Request.Form["opt_q2"] + "";
            opt_q3 = Request.Form["opt_q3"] + "";
            //opt_q4 = Request.Form["opt_q4"] + "";
            opt_q5 = Request.Form["opt_q5"] + "";
            opt_q6 = Request.Form["opt_q6"] + "";
            opt_q7 = Request.Form["opt_q7"] + "";
            //opt_q8 = Request.Form["opt_q8"] + "";
            opt_q9 = Request.Form["opt_q9"] + "";
            rb_location = Request.Form["rb_location"] + "";
            tb_otherlocation = Request.Form["tb_otherlocation"].Trim();

            tb_furthercomments = Request.Form["tb_furthercomments"].Trim();
            cb_speak = Request.Form["cb_speak"] + "";
            dd_panel = Request.Form["dd_panel"].Trim();
            dd_previoussubmission = Request.Form["dd_previoussubmission"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_agegroup = Request.Form["dd_agegroup"].Trim();
            cb_ethnicity = Request.Form["cb_ethnicity"] + "";
            tb_otherethnicity = Request.Form["tb_otherethnicity"].Trim();

            if (cb_speak == "")
            {
                speak = "No";
            }
            else
            {
                speak = "Yes";
            }

            ethnicity = cb_ethnicity;

            if (cb_ethnicity != "" && tb_otherethnicity != "")
            {
                ethnicity = cb_ethnicity + "," + tb_otherethnicity;
            }
            else
            {
                ethnicity = cb_ethnicity + tb_otherethnicity;
            }

            location = rb_location;

            if (tb_otherlocation != "")
            {
                location += ": " + tb_otherlocation;
            }
            

            #endregion
            string submitter_ctr = "";

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "PS_Update_Submitter";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@daytimephonenumber", SqlDbType.VarChar).Value = tb_daytimephonenumber;
            cmd.Parameters.Add("@organisationname", SqlDbType.VarChar).Value = tb_organisationname;
            cmd.Parameters.Add("@organisationrole", SqlDbType.VarChar).Value = tb_organisationrole;
            cmd.Parameters.Add("@panel", SqlDbType.VarChar).Value = dd_panel;
            cmd.Parameters.Add("@previoussubmission", SqlDbType.VarChar).Value = dd_previoussubmission;
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@agegroup", SqlDbType.VarChar).Value = dd_agegroup;
            cmd.Parameters.Add("@ethnicity", SqlDbType.VarChar).Value = ethnicity;
      

                //cmd.Parameters.Add("@otherethnicity", SqlDbType.VarChar).Value = tb_otherethnicity;
                #endregion

                #region save data (Standard)
                cmd.Connection = con;
            try
            {
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    submitter_ctr = dr["ctr"].ToString();
                }
                dr.Close();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //con.Close();
                //con.Dispose();
            }
            #endregion

            string documents = "";
            string documentslinks = "";
            string documents_delim = "";
            string documents_display = "";
            string documents_display_delim = "";

            if (fu_documents.HasFiles)
            {
                //to do should pass back an object/class ???

                string[] resultSplit;

                documents = documents + documents_delim + WDCFunctions.saveattachments(submissionpath + reference, "", fu_documents, webprotocol + "://" + webserver + submissionurl + reference, Request.RawUrl);
                string[] results = documents.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (results[0] != "File(s) not provided")
                {
                    foreach (string result in results)
                    {
                        resultSplit = result.Split(fieldDelim);
                        documentslinks = documentslinks + documents_delim + fu_documents.FileName + "\x00FD" + resultSplit[4] + "/" + resultSplit[2];
                        documents_display = documents_display + documents_display_delim + "<a href=\"" + resultSplit[4] + "/" + resultSplit[2] + "\" target=\"_Blank\">" + resultSplit[0] + "</a> - " + resultSplit[1];
                        documents_delim = "\x00FE";
                        documents_display_delim = "<br />";

                    }
                }

            }
            else
            {
                documents_display = documents_display + documents_delim + "File(s) not provided";
                //documents_delim = "\x00FE";
            }

            System.Web.HttpBrowserCapabilities browser = Request.Browser;
            string browserdetails = WDCFunctions.BrowserDetails(browser);

            #region setup specific data
            cmd.CommandText = SP;
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
            cmd.Parameters.Add("@ps_submitter_ctr", SqlDbType.VarChar).Value = submitter_ctr;
            //cmd.Parameters.Add("@q1", SqlDbType.VarChar).Value = opt_q1;
            cmd.Parameters.Add("@q2", SqlDbType.VarChar).Value = opt_q2;
            cmd.Parameters.Add("@q3", SqlDbType.VarChar).Value = opt_q3;
            //cmd.Parameters.Add("@q4", SqlDbType.VarChar).Value = opt_q4;
            cmd.Parameters.Add("@q5", SqlDbType.VarChar).Value = opt_q5;
            cmd.Parameters.Add("@q6", SqlDbType.VarChar).Value = opt_q6;
            cmd.Parameters.Add("@q7", SqlDbType.VarChar).Value = opt_q7;
            //cmd.Parameters.Add("@q8", SqlDbType.VarChar).Value = opt_q8;
            cmd.Parameters.Add("@q9", SqlDbType.VarChar).Value = opt_q9;
            cmd.Parameters.Add("@location", SqlDbType.VarChar).Value = location;

            cmd.Parameters.Add("@furthercomments", SqlDbType.VarChar).Value = tb_furthercomments;
            cmd.Parameters.Add("@speak", SqlDbType.VarChar).Value = speak;
            cmd.Parameters.Add("@previoussubmission", SqlDbType.VarChar).Value = dd_previoussubmission;
            cmd.Parameters.Add("@documents", SqlDbType.VarChar).Value = documentslinks;
            cmd.Parameters.Add("@browserdetails", SqlDbType.VarChar).Value = browserdetails;

            #endregion

            #region save data (Standard)
            //cmd.Connection = con;
            try
            {
                //con.Open();

                //SqlDataReader dr = cmd.ExecuteReader();

                //if (dr.HasRows)
                //{
                //    dr.Read();
                //    submitter_ctr = dr["ctr"].ToString();
                //}
                cmd.ExecuteScalar();

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


            //Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["title"] = title;
            documentvalues["reference"] = reference;
            documentvalues["ethnicity"] = ethnicity;
            documentvalues["speak"] = speak;
            documentvalues["documents_display"] = documents_display;
            documentvalues["location"] = location;

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
            path = Server.MapPath("..\\..");
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


            Response.Redirect("../completed.aspx?module=" + "PolicySubmissions" + "&id=" + shortname + "\\" + reference);
        }
    }
}