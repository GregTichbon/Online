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

namespace Online.PolicySubmissions.LongTermPlan0418
{
    public partial class _default : System.Web.UI.Page
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

        public string tb_furthercomments;
        public string cb_foundout;
        public string tb_otherfoundout;
        
        public string cb_speak;
        public string dd_panel;
        public string dd_previoussubmission;
        public string dd_gender;
        public string dd_agegroup;
        public string cb_ethnicity;
        public string tb_otherethnicity;

        public string speak;
        public string ethnicity;
        public string foundout;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Submission: Long Term Plan 2018 - 2028";
            title = "Submission: Long Term Plan 2018 - 2028 Consultation Document";
            shorttitle = "Submission: Long Term Plan 2018 - 2028";
            closes = new DateTime(2018, 4, 19, 17, 0, 0);
            closesfull = closes.ToString("h:mmtt dddd d MMMM yyyy");
            formlink = "http://www.whanganui.govt.nz/our-district/have-your-say/proposed-trade-waste-bylaw/Documents/Submission form Trade Waste Bylaw FINAL.pdf";
            form = ""; // "<p>Written submissions may be made by downloading the <a href=\"" + formlink + "\"</a>, completing it and posting or delivering it to:  </p>";
            submissionshearing = "Wednesday 2 and Thursday 3 May 2018";
            bylawpolicy = "bylaw";
            SP = "PS_Update_LongTermPlan0418";
            shortname = "LongTermPlan0418";
            specificemailsubject = "Long Term Plan 2018 - 2028";

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

            documentvalues["q1"] = "<b>Paying for the Impact of Forestry Harvesting:</b> Implement a new targeted rate for exotic forestry properties.  This would mean that exotic forestry properties pay 2.5 times their current contributing to roading.";
            documentvalues["q2"] = "<b>Revitalisation of our Port:</b>  Proceed with the Port Revitalisation Programme should the business case be approved.";
            documentvalues["q3"] = "<b>Our Stormwater Network:</b>  Upgrade the stormwater network in priority areas and the remainder in descending order of priority over time.";

            documentvalues["q4"] = "<b>Kerbside Recycling:</b>  Kerbside rubbish, mixed recycling and organic (garden and/or food) collection service for urban households by the 2020/21 financial year.";
            documentvalues["q5"] = "<b>Whanganui Regional Museum:</b>  Increase funding from $800,00 to $850,000 for the 2018/18 year, and then to $900,000 in the 2019/20 year to undertake promotional activity for the re-opening in 2018, and to enhance its exhibitions and events programmes.";
            documentvalues["q6"] = "<b>Whanganui Resource Recovery Centre:</b>  An additional $25,000 per year (taking its total funding to $175,000 per year) to enable the centre to introduce a kiosk reception booth and manage the centre’s user-pay services.";
            documentvalues["q7"] = "<b>Library Hubs:</b>  Establish four self-service suburban library hubs in partnership with existing facilities to deliver a service locally in a cost-effective manner. Each hub will cost $50,000. ";
            documentvalues["q8"] = "<b>Heritage Incentive Funding:</b>  $100,000 for a Heritage Grants scheme to assist building owners to comply with heritage preservation initiatives which may also provide an incentive to undertake earthquake strengthening work at the same time.";
            documentvalues["q9"] = "<b>Sport and Recreation Strategy:</b>  $100,000 towards the implementation of the Sport & Recreation Strategy, to continue development with sporting codes to support better and more efficient utilisation of Whanganui’s sport and recreation facilities.";
            documentvalues["q10"] = "<b>Dog Pound:</b>  $550,000 in Year 1 to complete construction of a new and compliant dog pound on Airport Road.  There is $450,000 in the budget for 2017/18, taking the total funding to $1M.";
            documentvalues["q11"] = "<b>Regional facilities:</b> $50,000 per year as a contribution towards a Regional Facilities fund to recognise the benefit certain localised facilities provide to the wider Manawatu-Whanganui region.  ";
            documentvalues["q12"] = "<b>Transferring our Marine & Airport Activity:</b>  Transfer the governance of the Ports Group from Whanganui District Council Holdings Ltd into Council’s Property Department.";
            documentvalues["q13"] = "<b>Wakefield Street Bridge:</b>  The cost of replacing the Wakefield Street Bridge is $1.9M. Subject to NZTA approval of funding.";
            //added new
            documentvalues["q14"] = "<b>Dublin Street Bridge:</b>  The cost of replacing the Dublin Street Bridge is $33.3M. Subject to NZTA approval of funding. ";
            documentvalues["q15"] = "<b>Wikitoria Culvert:</b>  Upgrade the Wikitoria Road culvert, subject to NZTA approval of funding. ";
            //added new group
            documentvalues["q16"] = "<b>Wastewater and Trade Waste</b>";
            documentvalues["q17"] = "<b>Resilient Roading</b>";
            documentvalues["q18"] = "<b>Animal Management</b>";
            documentvalues["q19"] = "<b>Port and River</b>";

            lit_questions1.Text = "";
            lit_questions1.Text += "<div class=\"table-responsive\">";
            lit_questions1.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            lit_questions1.Text += "<tr>";
            lit_questions1.Text += "<td><b>KEY ISSUES</b><br />Please indicate your level of agreement for the following preferred options.</td>";

            foreach (string rating in ratings1)
            {
                lit_questions1.Text += "<th class=\"tdcenter\">" + rating + "</th>";
            }
            lit_questions1.Text += "</tr>";


            for (int f1 = 1; f1 <= 3; f1++)
            {
                lit_questions1.Text += "<tr>";

                lit_questions1.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                for (int f2 = 1; f2 <= 5; f2++)
                {
                    lit_questions1.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings1[f2 - 1].Replace("<br />", " ") + "\" /></td>";
                }
            }

            if ( 1==2) { 
                lit_questions1.Text += "<tr><td colspan=\"6\">";
                lit_questions1.Text +=
                    "<div class=\"form-group\">" +
                    "<label class=\"control-label col-sm-4\" for=\"tb_objectivecomments\">Please use this space to add any further comments.</label>" +
                    "<div class=\"col-sm-8\">" +
                    "<textarea id =\"tb_objectivecomments\" name=\"tb_objectivecomments\" class=\"form-control\" rows=\"4\"></textarea>" +
                    "</div>  " +
                    "</div>";
            }

            lit_questions1.Text += "</table>";
            lit_questions1.Text += "</div>";


            //*******************************


            Lit_quest_WhoPays.Text = "";
            Lit_quest_WhoPays.Text += "<div class=\"table-responsive\">";
            Lit_quest_WhoPays.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            Lit_quest_WhoPays.Text += "<tr>";
            Lit_quest_WhoPays.Text += "<td><b>WHO PAYS?</b><br />Please indicate your level of agreement regarding the proposed funding approach for:</td>";

            foreach (string rating in ratings1) {
                Lit_quest_WhoPays.Text += "<th class=\"tdcenter\">" + rating + "</th>";
            }
            Lit_quest_WhoPays.Text += "</tr>";


            for (int f1 = 16; f1 <= 19; f1++) {
                Lit_quest_WhoPays.Text += "<tr>";

                Lit_quest_WhoPays.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                for (int f2 = 1; f2 <= 5; f2++) {
                    Lit_quest_WhoPays.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings1[f2 - 1].Replace("<br />", " ") + "\" /></td>";
                }
            }
            Lit_quest_WhoPays.Text += "</table>";
            Lit_quest_WhoPays.Text += "</div>";

            //*******************************

            lit_questions2.Text = "";
            lit_questions2.Text += "<div class=\"table-responsive\">";
            lit_questions2.Text += "<table class=\"table-striped table-bordered\" style=\"width: 100%;\">";
            lit_questions2.Text += "<tr>";
            lit_questions2.Text += "<td><b>MORE FOR YOU TO THINK ABOUT</b><br />Please indicate your level of agreement for the following options.</td>";

            foreach (string rating in ratings1)
            {
                lit_questions2.Text += "<th class=\"tdcenter\">" + rating + "</th>";
            }
            lit_questions2.Text += "</tr>";


            for (int f1 = 4; f1 <= 15; f1++)
            {
                lit_questions2.Text += "<tr>";

                lit_questions2.Text += "<td>" + documentvalues["q" + f1.ToString()] + "</td>";
                for (int f2 = 1; f2 <= 5; f2++)
                {
                    lit_questions2.Text += "<td class=\"tdcenter\"><input id=\"opt_q" + f1.ToString() + "_" + f2.ToString() + "\" name=\"opt_q" + f1.ToString() + "\" type=\"radio\" value=\"" + ratings1[f2 - 1].Replace("<br />", " ") + "\" /></td>";
                }
            }

            if (1 == 2)
            {
                lit_questions2.Text += "<tr><td colspan=\"6\">";
                lit_questions2.Text +=
                "<div class=\"form-group\">" +
                "<label class=\"control-label col-sm-4\" for=\"tb_objectivecomments\">Please use this space to add any further comments.</label>" +
                "<div class=\"col-sm-8\">" +
                "<textarea id =\"tb_objectivecomments\" name=\"tb_objectivecomments\" class=\"form-control\" rows=\"4\"></textarea>" +
                "</div>  " +
                "</div>";
            }


            lit_questions2.Text += "</table>";
            lit_questions2.Text += "</div>";


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

            string[] opt_q = new string[20]; 

            for (int f1 = 1; f1 <= 19; f1++)
            {
                opt_q[f1] = Request.Form["opt_q" + f1.ToString()] + "";
            }

            tb_furthercomments = Request.Form["tb_furthercomments"].Trim();

            cb_speak = Request.Form["cb_speak"] + "";
            dd_panel = Request.Form["dd_panel"].Trim();
            dd_previoussubmission = Request.Form["dd_previoussubmission"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_agegroup = Request.Form["dd_agegroup"].Trim();
            cb_ethnicity = Request.Form["cb_ethnicity"] + "";
            tb_otherethnicity = Request.Form["tb_otherethnicity"].Trim();
            cb_foundout = Request.Form["cb_foundout"] + "";
            tb_otherfoundout = Request.Form["tb_otherfoundout"].Trim();

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

            foundout = cb_foundout;
            if (cb_foundout != "" && tb_otherfoundout != "")
            {
                foundout = cb_foundout + "," + tb_otherfoundout;
            }
            else
            {
                foundout = cb_foundout + tb_otherfoundout;
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

            for (int f1 = 1; f1 <= 19; f1++)
            {
                cmd.Parameters.Add("@q" + f1.ToString(), SqlDbType.VarChar).Value = opt_q[f1];
            }
            cmd.Parameters.Add("@foundout", SqlDbType.VarChar).Value = foundout;

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
            documentvalues["foundout"] = foundout;
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