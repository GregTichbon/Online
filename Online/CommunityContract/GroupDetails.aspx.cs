using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace Online.CommunityContract
{
    public partial class GroupDetails : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];
        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string selected;

        #region fields
        //public int users_ctr;
        //public int groupdetails_ctr;
        public string tb_reference;
        public string tb_legalname;
        public string tb_grouptype;
        public string tb_charitiesnumber;
        public string tb_physicaladdress;
        public string tb_postaladdress;
        public string tb_bankaccountnumber;
        public string tb_gstnumber;
        public string tb_phonenumber;
        public string tb_emailaddress;
        public string tb_emailconfirm;
        public string tb_facebook;
        public string tb_website;
        public string tb_umbrellagroup;
        public string dd_constitution;
        public string tb_employedstaff;
        public string tb_employmentcontracts;
        public string tb_jobdescriptions;
        public string tb_performancemanagement;
        public string tb_paidstaff;
        public string tb_paidstaffhours;
        public string tb_volunteers;
        public string tb_volunteerhours;
        public string dd_financialpoliciespractices;
        public string dd_financialpeople;
        public string tb_accountingprogramme;
        public string tb_financialreports;
        public string tb_financialyear;
        public string tb_payrollsystem;
        public string tb_premises;
        public string dd_complaints;
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["communitycontracts_users_ctr"] == null)
                {
                    Response.Redirect("default.aspx");
                }
                
                if (Request.QueryString["populate"] == "True")
                {
                    tb_reference = "reference";
                    tb_legalname = "legalname";
                    tb_grouptype = "grouptype";
                    tb_charitiesnumber = "charitiesnumber";
                    tb_physicaladdress = "physicaladdress" + System.Environment.NewLine + "physicaladdress";
                    tb_postaladdress = "postaladdress" + System.Environment.NewLine + "postaladdress";
                    tb_bankaccountnumber = "bankaccountnumber";
                    tb_gstnumber = "gstnumber";
                    tb_phonenumber = "phonenumber";
                    tb_emailaddress = "greg@datainn.co.nz";
                    tb_emailconfirm = "greg@datainn.co.nz";
                    tb_facebook = "http://www.facebook.com";
                    tb_website = "https://www.google.com";
                    tb_umbrellagroup = "umbrellagroup" + System.Environment.NewLine + "umbrellagroup";
                    dd_constitution = "No";
                    tb_employedstaff = "employedstaff" + System.Environment.NewLine + "employedstaff";
                    tb_employmentcontracts = "employmentcontracts" + System.Environment.NewLine + "employmentcontracts";
                    tb_jobdescriptions = "jobdescriptions" + System.Environment.NewLine + "jobdescriptions";
                    tb_performancemanagement = "performancemanagement" + System.Environment.NewLine + "performancemanagement";
                    tb_paidstaff = "99";
                    tb_paidstaffhours = "999";
                    tb_volunteers = "99";
                    tb_volunteerhours = "999";
                    dd_financialpoliciespractices = "No";
                    dd_financialpeople = "No";
                    tb_accountingprogramme = "accountingprogramme" + System.Environment.NewLine + "accountingprogramme";
                    tb_financialreports = "financialreports" + System.Environment.NewLine + "financialreports";
                    tb_financialyear = "financialyear";
                    tb_payrollsystem = "payrollsystem" + System.Environment.NewLine + "payrollsystem";
                    tb_premises = "premises";
                    dd_complaints = "No";
                }
                else
                {
                    string groupsubmissionperiod = "";
                    hf_users_ctr.Value = Session["communitycontracts_users_ctr"].ToString();
                    String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                    SqlConnection con = new SqlConnection(strConnString);

                    SqlCommand cmd = new SqlCommand("Get_CC_GroupDetails", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ctr", SqlDbType.Int).Value = Session["communitycontracts_users_ctr"];
                    cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();
                            hf_groupdetails_ctr.Value = dr["cc_groupdetails_ctr"].ToString();
                            tb_reference = dr["reference"].ToString();
                            tb_legalname = dr["legalname"].ToString();
                            tb_grouptype = dr["grouptype"].ToString();
                            tb_charitiesnumber = dr["charitiesnumber"].ToString();
                            tb_physicaladdress = dr["physicaladdress"].ToString();
                            tb_postaladdress = dr["postaladdress"].ToString();
                            tb_bankaccountnumber = dr["bankaccountnumber"].ToString();
                            tb_gstnumber = dr["gstnumber"].ToString();
                            tb_phonenumber = dr["phonenumber"].ToString();
                            tb_emailaddress = dr["emailaddress"].ToString();
                            //tb_emailconfirm = dr["emailconfirm"].ToString();
                            tb_facebook = dr["facebook"].ToString();
                            tb_website = dr["website"].ToString();
                            tb_umbrellagroup = dr["umbrellagroup"].ToString();
                            dd_constitution = dr["constitution"].ToString();
                            tb_employedstaff = dr["employedstaff"].ToString();
                            tb_employmentcontracts = dr["employmentcontracts"].ToString();
                            tb_jobdescriptions = dr["jobdescriptions"].ToString();
                            tb_performancemanagement = dr["performancemanagement"].ToString();
                            tb_paidstaff = dr["paidstaff"].ToString();
                            tb_paidstaffhours = dr["paidstaffhours"].ToString();
                            tb_volunteers = dr["volunteers"].ToString();
                            tb_volunteerhours = dr["volunteerhours"].ToString();
                            dd_financialpoliciespractices = dr["financialpoliciespractices"].ToString();
                            dd_financialpeople = dr["financialpeople"].ToString();
                            tb_accountingprogramme = dr["accountingprogramme"].ToString();
                            tb_financialreports = dr["financialreports"].ToString();
                            tb_financialyear = dr["financialyear"].ToString();
                            tb_payrollsystem = dr["payrollsystem"].ToString();
                            tb_premises = dr["premises"].ToString();
                            dd_complaints = dr["complaints"].ToString();
                            groupsubmissionperiod = dr["submissionperiod"].ToString();
                        }
                        else { }
                        if (groupsubmissionperiod != submissionperiod)
                        {
                            tb_reference = WDCFunctions.WDCFunctions.getReference("datetime");
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

                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            #region parameters
            string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionpath"] + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails.emailSubject"];
            string screenTemplate = "GroupDetailsScreen.html";
            string emailbodyTemplate = "GroupDetailsEmail.html";
            #endregion

            #region fields
            tb_reference = Request.Form["tb_reference"].Trim();
            tb_legalname = Request.Form["tb_legalname"].Trim();
            tb_grouptype = Request.Form["tb_grouptype"].Trim();
            tb_charitiesnumber = Request.Form["tb_charitiesnumber"].Trim();
            tb_physicaladdress = Request.Form["tb_physicaladdress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_bankaccountnumber = Request.Form["tb_bankaccountnumber"].Trim();
            tb_gstnumber = Request.Form["tb_gstnumber"].Trim();
            tb_phonenumber = Request.Form["tb_phonenumber"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_emailconfirm = Request.Form["tb_emailconfirm"].Trim();
            tb_facebook = Request.Form["tb_facebook"].Trim();
            tb_website = Request.Form["tb_website"].Trim();
            tb_umbrellagroup = Request.Form["tb_umbrellagroup"].Trim();
            dd_constitution = Request.Form["dd_constitution"].Trim();
            tb_employedstaff = Request.Form["tb_employedstaff"].Trim();
            tb_employmentcontracts = Request.Form["tb_employmentcontracts"].Trim();
            tb_jobdescriptions = Request.Form["tb_jobdescriptions"].Trim();
            tb_performancemanagement = Request.Form["tb_performancemanagement"].Trim();
            tb_paidstaff = Request.Form["tb_paidstaff"].Trim();
            tb_paidstaffhours = Request.Form["tb_paidstaffhours"].Trim();
            tb_volunteers = Request.Form["tb_volunteers"].Trim();
            tb_volunteerhours = Request.Form["tb_volunteerhours"].Trim();
            dd_financialpoliciespractices = Request.Form["dd_financialpoliciespractices"].Trim();
            dd_financialpeople = Request.Form["dd_financialpeople"];
            tb_accountingprogramme = Request.Form["tb_accountingprogramme"].Trim();
            tb_financialreports = Request.Form["tb_financialreports"].Trim();
            tb_financialyear = Request.Form["tb_financialyear"].Trim();
            tb_payrollsystem = Request.Form["tb_payrollsystem"].Trim();
            tb_premises = Request.Form["tb_premises"].Trim();
            dd_complaints = Request.Form["dd_complaints"];
            #endregion

            #region uploadfiles
            string strategicplan = "";
            string strategicplan_display = "";

            if (fu_strategicplan.HasFiles)
            {
                //to do should pass back an object/class ???

                string links = "";
                string links_delim = "";

                char[] fieldDelim = { '\x00FD' };
                char[] recordDelim = { '\x00FE' };
                string[] resultSplit;



                strategicplan = WDCFunctions.WDCFunctions.saveattachments(submissionpath + tb_reference, "", fu_strategicplan, Request.RawUrl);
                string[] results = strategicplan.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (results[0] != "File(s) not provided")
                {
                    foreach (string result in results)
                    {

                        resultSplit = result.Split(fieldDelim);
                        links = links + links_delim + "Strategic plan: " + fu_strategicplan.FileName + "\x00FD" + webprotocol + "://" + webserver + "/onlinesubmissions/xxxxx/" + tb_reference + "/" + resultSplit[2];
                        strategicplan_display = strategicplan_display + links_delim + resultSplit[0] + " - " + resultSplit[1];
                        links_delim = "\x00FE";
                    }
                }

            }


            /*

                string attpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails.submissionpath"] + tb_reference;

                if (!Directory.Exists(attpath))
                {
                    Directory.CreateDirectory(attpath);
                }

                int c1 = 0;
                int failed = 0;
                int succeeded = 0;

                foreach (HttpPostedFile postedFile in fu_strategicplan.PostedFiles)
                {
                    c1 = c1 + 1;
                    try
                    {
                        string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
                        postedFile.SaveAs(attpath + "\\strategicplan" + c1.ToString() + wpextension);
                        succeeded = succeeded + 1;
                    }
                    catch (Exception ex)
                    {
                        WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                        failed = failed + 1;
                    }
                }

                hf_strategicplan.Value = "";
                string delim = "";
                string uploadresult = "";
                if (succeeded > 0)
                {
                    uploadresult = succeeded.ToString() + " Uploaded";
                    delim = ", ";
                }
                if (failed > 0)
                {
                    uploadresult = uploadresult + delim + failed.ToString() + " Failed ";
                }

                hf_strategicplan.Value = uploadresult;
     
             
             */
            #endregion

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "Update_CC_GroupDetails";
            cmd.Parameters.Add("@CC_GroupDetails_CTR", SqlDbType.Int).Value = hf_groupdetails_ctr.Value;
            cmd.Parameters.Add("@cc_users_CTR", SqlDbType.Int).Value = hf_users_ctr.Value;

            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;

            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference;

            cmd.Parameters.Add("@legalname", SqlDbType.VarChar).Value = tb_legalname;
            cmd.Parameters.Add("@grouptype", SqlDbType.VarChar).Value = tb_grouptype;
            cmd.Parameters.Add("@charitiesnumber", SqlDbType.VarChar).Value = tb_charitiesnumber;
            cmd.Parameters.Add("@physicaladdress", SqlDbType.VarChar).Value = tb_physicaladdress;
            cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@bankaccountnumber", SqlDbType.VarChar).Value = tb_bankaccountnumber;
            cmd.Parameters.Add("@gstnumber", SqlDbType.VarChar).Value = tb_gstnumber;
            cmd.Parameters.Add("@phonenumber", SqlDbType.VarChar).Value = tb_phonenumber;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            cmd.Parameters.Add("@website", SqlDbType.VarChar).Value = tb_website;
            cmd.Parameters.Add("@umbrellagroup", SqlDbType.VarChar).Value = tb_umbrellagroup;
            cmd.Parameters.Add("@constitution", SqlDbType.VarChar).Value = dd_constitution;
            cmd.Parameters.Add("@strategicplan", SqlDbType.VarChar).Value = strategicplan;
            cmd.Parameters.Add("@employedstaff", SqlDbType.VarChar).Value = tb_employedstaff;
            cmd.Parameters.Add("@employmentcontracts", SqlDbType.VarChar).Value = tb_employmentcontracts;
            cmd.Parameters.Add("@jobdescriptions", SqlDbType.VarChar).Value = tb_jobdescriptions;
            cmd.Parameters.Add("@performancemanagement", SqlDbType.VarChar).Value = tb_performancemanagement;
            cmd.Parameters.Add("@paidstaff", SqlDbType.VarChar).Value = tb_paidstaff;
            cmd.Parameters.Add("@paidstaffhours", SqlDbType.VarChar).Value = tb_paidstaffhours;
            cmd.Parameters.Add("@volunteerhours", SqlDbType.VarChar).Value = tb_volunteerhours;
            cmd.Parameters.Add("@volunteers", SqlDbType.VarChar).Value = tb_volunteers;
            cmd.Parameters.Add("@financialpoliciespractices", SqlDbType.VarChar).Value = dd_financialpoliciespractices;
            cmd.Parameters.Add("@financialpeople", SqlDbType.VarChar).Value = dd_financialpeople;
            cmd.Parameters.Add("@accountingprogramme", SqlDbType.VarChar).Value = tb_accountingprogramme;
            cmd.Parameters.Add("@financialreports", SqlDbType.VarChar).Value = tb_financialreports;
            cmd.Parameters.Add("@financialyear", SqlDbType.VarChar).Value = tb_financialyear;
            cmd.Parameters.Add("@payrollsystem", SqlDbType.VarChar).Value = tb_payrollsystem;
            cmd.Parameters.Add("@premises", SqlDbType.VarChar).Value = tb_premises;
            cmd.Parameters.Add("@complaints", SqlDbType.VarChar).Value = dd_complaints;

            #endregion

            #region save data (Standard)
            cmd.Connection = con;
            try
            {
                con.Open();
                hf_groupdetails_ctr.Value = cmd.ExecuteScalar().ToString();
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

            Session["communitycontractsgroup_legalname"] = tb_legalname;

            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = tb_reference;
            documentvalues["legalname"] = tb_legalname;
            documentvalues["grouptype"] = tb_grouptype;
            documentvalues["charitiesnumber"] = tb_charitiesnumber;
            documentvalues["physicaladdress"] = tb_physicaladdress;
            documentvalues["postaladdress"] = tb_postaladdress;
            documentvalues["bankaccountnumber"] = tb_bankaccountnumber;
            documentvalues["gstnumber"] = tb_gstnumber;
            documentvalues["phonenumber"] = tb_phonenumber;
            documentvalues["emailaddress"] = tb_emailaddress;
            documentvalues["facebook"] = tb_facebook;
            documentvalues["website"] = tb_website;
            documentvalues["umbrellagroup"] = tb_umbrellagroup;
            documentvalues["constitution"] = dd_constitution;
            documentvalues["strategicplan"] = strategicplan_display.Replace("\x00FE", "<br />"); 
            documentvalues["employedstaff"] = tb_employedstaff;
            documentvalues["employmentcontracts"] = tb_employmentcontracts;
            documentvalues["jobdescriptions"] = tb_jobdescriptions;
            documentvalues["performancemanagement"] = tb_performancemanagement;
            documentvalues["paidstaff"] = tb_paidstaff;
            documentvalues["paidstaffhours"] = tb_paidstaffhours;
            documentvalues["volunteers"] = tb_volunteers;
            documentvalues["volunteerhours"] = tb_volunteerhours;
            documentvalues["financialpoliciespractices"] = dd_financialpoliciespractices;
            documentvalues["financialpeople"] = dd_financialpeople;
            documentvalues["accountingprogramme"] = tb_accountingprogramme;
            documentvalues["financialreports"] = tb_financialreports;
            documentvalues["financialyear"] = tb_financialyear;
            documentvalues["payrollsystem"] = tb_payrollsystem;
            documentvalues["premises"] = tb_premises;
            documentvalues["complaints"] = dd_complaints;

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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();


            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill Screen", "");
            screendocument = a.documentfill(screendocument, documentvalues);

            //save a copy of formatdocument in submissions

            path = Server.MapPath("~");
            try
            {
                //'C:\inetpub\Online\submissions\MobileShopLicence\910030955162210
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill email", "");
            emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion
            
            #region send email
            WDCFunctions.WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);
            #endregion

            Response.Redirect("default.aspx");

        }
    }
}