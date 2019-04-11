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

namespace Online.PolicySubmissions.RoadNaming0618
{
    public partial class Default : System.Web.UI.Page
    {

        #region Class Parameters
        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };
        public string[] agegroups = new string[6] { "Under 18 years", "18 - 29 years", "30 - 39 years", "40 - 49 years", "50 - 59 years", "60 years or over" };
        public string[] ratings1 = new string[5] { "Strongly<br />agree", "Agree", "Neither<br />agree<br />nor<br />disagree", "Disagree", "Strongly<br />disagree" };
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

        public string[] ratings2 = new string[4]; // { "<b>Option 1<br />Developer submits new road names</b><br />This would mean the developer is invited to submit up to three names in order of preference. This must include reasons for the suggestions, as well as details of any engagement undertaken (pg. 6).", "Agree", "Neither<br />agree<br />nor<br />disagree", "Disagree", "Strongly<br />disagree" };
        

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
        public string opt_q1;
        public string opt_q2;
        public string opt_q3;
        public string opt_q4;
        public string opt_q5;

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
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Submission: Road Naming and Number Policy 2018";
            title = "Submission: Road Naming and Number Policy 2018";
            shorttitle = "Road Naming and Number Policy 2018";
            closes = new DateTime(2018, 6, 15, 17, 0, 0);
            closesfull = closes.ToString("h:mmtt dddd d MMMM yyyy");
            formlink = "http://www.whanganui.govt.nz/our-district/have-your-say/proposed-trade-waste-bylaw/Documents/Submission form Trade Waste Bylaw FINAL.pdf";
            form = ""; // "<p>Written submissions may be made by downloading the <a href=\"" + formlink + "\"</a>, completing it and posting or delivering it to:  </p>";
            submissionshearing = "Monday 18 June 2018";
            bylawpolicy = "bylaw";
            SP = "PS_Update_RoadNaming0618";
            shortname = "RoadNaming0618";
            specificemailsubject = "Road Naming and Number Policy";

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

            documentvalues["q1"] = "When naming new roads, which of the following proposals do you support?";
            documentvalues["q2"] = "When naming a new road (pg. 7), a name suggested can reflect an established theme in the area or one or more of the following: <ul><li>Traditional or appropriate Māori name</li><li>Historical person or event</li><li>Significant geographical or topographical features</li><li>Personal name for special service</li></ul";
            documentvalues["q3"] = "The Council’s approach to <b>naming of previously unformed roads</b> (pg. 8).";
            documentvalues["q4"] = "The Council’s approach to <b>re-naming an existing road</b>(pp. 8-9).";
            documentvalues["q5"] = "Overall, do you generally agree with the contents of the proposed policy?";

            ratings2[0] = "<b>Option 1<br /><br />Developer submits new road names</b><br /><br />This would mean the developer is invited to submit up to three names in order of preference. This must include reasons for the suggestions, as well as details of any engagement undertaken (pg. 6).";
            ratings2[1] = "<b>Option 2<br /><br />Developer suggest names for public consultation</b><br /><br />This would mean the developer is invited to submit up to three names in order of preference. The public would be notified of an opportunity to have their say on which name they prefer of the three (pg. 7).";
            ratings2[2] = "<b>Option 3<br /><br />Public submits a name when a new road is created</b><br /><br />This would mean that whenever a new road is created the public would be provided the opportunity to propose a name for it, including developers (pg. 7). ";
            ratings2[3] = "<b>Option 4<br /><br />Developer submits from a list of names provided by the public</b><br /><br />This would mean the developer is invited to submit up to three names in order of preference from a list of names provided by the public. The list will be created through public engagement occurring once or twice a year (pg. 7).";



            lit_questions1.Text = "";
            lit_questions1.Text += "<div class=\"table-responsive\">";
            lit_questions1.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            lit_questions1.Text += "<tr>";
            lit_questions1.Text += "<td><b>Naming of new roads</b></td>";

            foreach (string rating in ratings2)
            {
                lit_questions1.Text += "<td class=\"tdcenter\">" + rating + "</td>";
            }
            lit_questions1.Text += "</tr>";


            for (int f1 = 1; f1 <= 1; f1++)
            {
                lit_questions1.Text += "<tr>";

                lit_questions1.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                for (int f2 = 1; f2 <= 4; f2++)
                {
                    lit_questions1.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings2[f2 - 1] + "\" /></td>";
                }
            }

            lit_questions1.Text += "</table>";
            lit_questions1.Text += "</div>";
            lit_questions1.Text += "<br /><br />";

            lit_questions1.Text += "<div class=\"table-responsive\">";
            lit_questions1.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            lit_questions1.Text += "<tr>";
            lit_questions1.Text += "<td><b>Please indicate your level of agreement for options</b></td>";

            foreach (string rating in ratings1)
            {
                lit_questions1.Text += "<th class=\"tdcenter\">" + rating + "</th>";
            }
            lit_questions1.Text += "</tr>";


            for (int f1 = 2; f1 <= 5; f1++)
            {
                lit_questions1.Text += "<tr>";

                lit_questions1.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                for (int f2 = 1; f2 <= 5; f2++)
                {
                    lit_questions1.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings1[f2 - 1].Replace("<br />", " ") + "\" /></td>";
                }
            }

            lit_questions1.Text += "</table>";
            lit_questions1.Text += "</div>";
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
            opt_q1 = Request.Form["opt_q1"] + "";
            opt_q2 = Request.Form["opt_q2"] + "";
            opt_q3 = Request.Form["opt_q3"] + "";
            opt_q4 = Request.Form["opt_q4"] + "";
            opt_q5 = Request.Form["opt_q5"] + "";
 
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

            #region setup specific data
            cmd.CommandText = SP;
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
            cmd.Parameters.Add("@ps_submitter_ctr", SqlDbType.VarChar).Value = submitter_ctr;
            cmd.Parameters.Add("@q1", SqlDbType.VarChar).Value = opt_q1;
            cmd.Parameters.Add("@q2", SqlDbType.VarChar).Value = opt_q2;
            cmd.Parameters.Add("@q3", SqlDbType.VarChar).Value = opt_q3;
            cmd.Parameters.Add("@q4", SqlDbType.VarChar).Value = opt_q4;
            cmd.Parameters.Add("@q5", SqlDbType.VarChar).Value = opt_q5;

            cmd.Parameters.Add("@furthercomments", SqlDbType.VarChar).Value = tb_furthercomments;
            cmd.Parameters.Add("@speak", SqlDbType.VarChar).Value = speak;
            cmd.Parameters.Add("@previoussubmission", SqlDbType.VarChar).Value = dd_previoussubmission;
            cmd.Parameters.Add("@documents", SqlDbType.VarChar).Value = documentslinks;

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