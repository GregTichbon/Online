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
        public string tb_facebook;
        public string tb_website;
        public string tb_umbrellagroup;
        public string dd_constitution;
        public string cb_deletestrategicplan;
        public string cb_deletestatements;
        public string cb_deletebudget;
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
        public string dd_statutoryobligations;

        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            if (!IsPostBack)
            {
                if (Session["communitycontracts_users_ctr"] == null)
                {
                    Response.Redirect("default.aspx");
                }
                #region populate
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
                    #endregion
                    string groupsubmissionperiod = "";
                    hf_users_ctr.Value = Session["communitycontracts_users_ctr"].ToString();
                    hf_originalreference.Value = "";
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
                            dd_statutoryobligations = dr["statutoryobligations"].ToString();
                            groupsubmissionperiod = dr["submissionperiod"].ToString();

                            string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionpath"] + tb_reference;
                            string submissionurl = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionurl"] + "/" + tb_reference;

                            #region buildfiletables

                            if (Directory.Exists(submissionpath + "\\strategicplan"))
                            {
                                string[] strategicplanfilePaths = Directory.GetFiles(submissionpath + "\\strategicplan");
                                string strategicplanfileName;
                                if (strategicplanfilePaths.Count() != 0)
                                {
                                    lbl_strategicplan.Text = "<div class=\"table-responsive\"><table class=\"table table-condensed\"><tr><th>File name</th><th>Delete</th></tr>";
                                    foreach (string filePath in strategicplanfilePaths)
                                    {

                                        string wpextension = System.IO.Path.GetExtension(filePath);
                                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filePath);
                                        strategicplanfileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;

                                        lbl_strategicplan.Text = lbl_strategicplan.Text + "<tr><td><a href=\"../" + submissionurl + "/strategicplan/" + wpfilename + wpextension + "\" target=\"_blank\">" + strategicplanfileName + "</a></td><td><input name=\"cb_deletestrategicplan\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
                                    }
                                    lbl_strategicplan.Text = lbl_strategicplan.Text + "</table></div>";
                                }
                            }


                            //Greg starts
                            if (Directory.Exists(submissionpath + "\\statements"))
                            {
                                string[] statementsfilePaths = Directory.GetFiles(submissionpath + "\\statements");
                                string statementsfileName;
                                if (statementsfilePaths.Count() != 0)
                                {
                                    lbl_statements.Text = "<div class=\"table-responsive\"><table class=\"table table-condensed\"><tr><th>File name</th><th>Delete</th></tr>";
                                    foreach (string filePath in statementsfilePaths)
                                    {

                                        string wpextension = System.IO.Path.GetExtension(filePath);
                                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filePath);
                                        statementsfileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;

                                        lbl_statements.Text = lbl_statements.Text + "<tr><td><a href=\"../" + submissionurl + "/statements/" + wpfilename + wpextension + "\" target=\"_blank\">" + statementsfileName + "</a></td><td><input name=\"cb_deletestatements\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
                                    }
                                    lbl_statements.Text = lbl_statements.Text + "</table></div>";
                                }
                            }

                            if (Directory.Exists(submissionpath + "\\budget"))
                            {
                                string[] budgetfilePaths = Directory.GetFiles(submissionpath + "\\budget");
                                string budgetfileName;
                                if (budgetfilePaths.Count() != 0)
                                {
                                    lbl_budget.Text = "<div class=\"table-responsive\"><table class=\"table table-condensed\"><tr><th>File name</th><th>Delete</th></tr>";
                                    foreach (string filePath in budgetfilePaths)
                                    {

                                        string wpextension = System.IO.Path.GetExtension(filePath);
                                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filePath);
                                        budgetfileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;

                                        lbl_budget.Text = lbl_budget.Text + "<tr><td><a href=\"../" + submissionurl + "/budget/" + wpfilename + wpextension + "\" target=\"_blank\">" + budgetfileName + "</a></td><td><input name=\"cb_deletebudget\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
                                    }
                                    lbl_budget.Text = lbl_budget.Text + "</table></div>";
                                }
                            }
                            //Greg ends
                            #endregion
                        }
                        else
                        {
                            tb_reference = "";
                        }
                        if (groupsubmissionperiod != submissionperiod)
                        {
                            hf_originalreference.Value = tb_reference;
                            tb_reference = WDCFunctions.getReference("datetime");
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
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region parameters
            string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionpath"] + "\\";
            string submissionurl = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string emailBCC = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails.emailSubject"];
            string screenTemplate = "GroupDetailsScreen.html";
            string emailbodyTemplate = "GroupDetailsEmail.html";
            #endregion

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

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
            tb_facebook = Request.Form["tb_facebook"].Trim();
            tb_website = Request.Form["tb_website"].Trim();
            tb_umbrellagroup = Request.Form["tb_umbrellagroup"].Trim();
            dd_constitution = Request.Form["dd_constitution"].Trim();
            cb_deletestrategicplan = Request.Form["cb_deletestrategicplan"];
            cb_deletestatements = Request.Form["cb_deletestatements"];
            cb_deletebudget = Request.Form["cb_deletebudget"];
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
            dd_statutoryobligations = Request.Form["dd_statutoryobligations"];

            #endregion

            string strategicplan = "";
            string strategicplanlinks = "";
            string strategicplan_delim = "";
            string strategicplan_display = "";

            string statements = "";
            string statementslinks = "";
            string statements_delim = "";
            string statements_display = "";

            string budget = "";
            string budgetlinks = "";
            string budget_delim = "";
            string budget_display = "";


            #region deletecopyfiles

            try
            {
                if (hf_originalreference.Value == "")
                {
                    //WDCFunctions.Log(Request.RawUrl, "hf_originalreference.Value == ''", "greg.tichbon@whanganui.govt.nz");
                    //WDCFunctions.Log(Request.RawUrl, "cb_deletestrategicplan: " + cb_deletestrategicplan, "greg.tichbon@whanganui.govt.nz");

                    if (WDCFunctions.isNull(cb_deletestrategicplan, "") != "")
                    {
                        string[] deletefiles = cb_deletestrategicplan.Split(',');
                        //WDCFunctions.Log(Request.RawUrl, "X1", "greg.tichbon@whanganui.govt.nz");


                        if (deletefiles.Count() != 0)
                        {
                            string subpath = submissionpath + tb_reference + "\\strategicplan";
                            string deletedpath = subpath + "\\Deleted";
                            if (!Directory.Exists(deletedpath))
                            {
                                Directory.CreateDirectory(deletedpath);
                            }

                            foreach (string deletefile in deletefiles)
                            {

                                string wpextension = System.IO.Path.GetExtension(deletefile);
                                string wpfilename = System.IO.Path.GetFileNameWithoutExtension(deletefile);
                                string fileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;
                                string newfilename = wpfilename + "_" + DateTime.Now.ToString("ddMMyyhhmmss") + wpextension;

                                File.Move(subpath + "\\" + deletefile, deletedpath + "\\" + newfilename);
                                strategicplan_display = strategicplan_display + strategicplan_delim + fileName + " - Deleted";
                                //Greg 26/7/2018 strategicplan = strategicplan + deletefile + fieldDelim + "Deleted";
                                strategicplan_delim = "\x00FE";
                            }
                        }
                    }
                    //greg start

                    if (WDCFunctions.isNull(cb_deletestatements, "") != "")
                    {
                        string[] deletefiles = cb_deletestatements.Split(',');
                        //WDCFunctions.Log(Request.RawUrl, "X1", "greg.tichbon@whanganui.govt.nz");


                        if (deletefiles.Count() != 0)
                        {
                            string subpath = submissionpath + tb_reference + "\\statements";
                            string deletedpath = subpath + "\\Deleted";
                            if (!Directory.Exists(deletedpath))
                            {
                                Directory.CreateDirectory(deletedpath);
                            }

                            foreach (string deletefile in deletefiles)
                            {

                                string wpextension = System.IO.Path.GetExtension(deletefile);
                                string wpfilename = System.IO.Path.GetFileNameWithoutExtension(deletefile);
                                string fileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;
                                string newfilename = wpfilename + "_" + DateTime.Now.ToString("ddMMyyhhmmss") + wpextension;

                                File.Move(subpath + "\\" + deletefile, deletedpath + "\\" + newfilename);
                                statements_display = statements_display + statements_delim + fileName + " - Deleted";
                                //Greg 26/7/2018 statements = statements + deletefile + fieldDelim + "Deleted";
                                statements_delim = "\x00FE";
                            }
                        }
                    }

                    if (WDCFunctions.isNull(cb_deletebudget, "") != "")
                    {
                        string[] deletefiles = cb_deletebudget.Split(',');
                        //WDCFunctions.Log(Request.RawUrl, "X1", "greg.tichbon@whanganui.govt.nz");


                        if (deletefiles.Count() != 0)
                        {
                            string subpath = submissionpath + tb_reference + "\\budget";
                            string deletedpath = subpath + "\\Deleted";
                            if (!Directory.Exists(deletedpath))
                            {
                                Directory.CreateDirectory(deletedpath);
                            }

                            foreach (string deletefile in deletefiles)
                            {

                                string wpextension = System.IO.Path.GetExtension(deletefile);
                                string wpfilename = System.IO.Path.GetFileNameWithoutExtension(deletefile);
                                string fileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;
                                string newfilename = wpfilename + "_" + DateTime.Now.ToString("ddMMyyhhmmss") + wpextension;

                                File.Move(subpath + "\\" + deletefile, deletedpath + "\\" + newfilename);
                                budget_display = budget_display + budget_delim + fileName + " - Deleted";
                                //Greg 26/7/2018 budget = budget + deletefile + fieldDelim + "Deleted";
                                budget_delim = "\x00FE";
                            }
                        }
                    }

                    //greg end
                }
                else
                {
                    //WDCFunctions.Log(Request.RawUrl, "hf_originalreference.Value != ''", "greg.tichbon@whanganui.govt.nz");

                    string origpath = submissionpath + hf_originalreference.Value;
                    string newpath = submissionpath + tb_reference;

                    //WDCFunctions.Log(Request.RawUrl, "origpath: " + origpath, "greg.tichbon@whanganui.govt.nz");
                    //WDCFunctions.Log(Request.RawUrl, "newpath: " + newpath, "greg.tichbon@whanganui.govt.nz");

                    //Greg 2jul2018 if (Directory.Exists(origpath)) {
                    //Greg 2jul2018if (!Directory.Exists(newpath))
                    //Greg 2jul2018{
                    //WDCFunctions.Log(Request.RawUrl, "CreateDirectory: " + newpath, "greg.tichbon@whanganui.govt.nz");
                    //Greg 2jul2018Directory.CreateDirectory(newpath);
                    //Greg 2jul2018}

                    //WDCFunctions.Log(Request.RawUrl, "cb_deletestrategicplan: " + cb_deletestrategicplan, "greg.tichbon@whanganui.govt.nz");

                    //if (WDCFunctions.isNull(cb_deletestrategicplan, "") != "")
                    //{

                    string usefolder = "";

                    if(submissionperiod == "2015" || submissionperiod == "2016" || submissionperiod == "2017" || submissionperiod == "2018")
                    {
                        usefolder = "";
                    } else
                    {
                        usefolder = "\\strategicplan";
                    }

                    if (Directory.Exists(origpath + usefolder))
                    {
                        cb_deletestrategicplan = cb_deletestrategicplan + ",";
                        string[] deletestrategicplanfiles = cb_deletestrategicplan.Split(',');

                        string[] strategicplanfilepaths = Directory.GetFiles(origpath + usefolder);
                        string strategicplanfileName;
                        Boolean strategicplanskip;
                        if (strategicplanfilepaths.Count() != 0)
                        {
                            Directory.CreateDirectory(newpath + "\\strategicplan");
                            foreach (string filePath in strategicplanfilepaths)
                            {
                                strategicplanfileName = System.IO.Path.GetFileName(filePath);
                                strategicplanskip = false;
                                foreach (string deletefile in deletestrategicplanfiles)
                                {
                                    if (deletefile == strategicplanfileName)
                                    {
                                        strategicplanskip = true;
                                    }
                                }
                                if (strategicplanskip != true)
                                {
                                    File.Copy(filePath, newpath + "\\strategicplan\\" + strategicplanfileName);
                                }
                            }
                        }
                    }

                    if (submissionperiod != "2015" && submissionperiod != "2016" && submissionperiod != "2017" && submissionperiod != "2018")
                    {
                        if (Directory.Exists(origpath + "\\statements"))
                        {
                            cb_deletestatements = cb_deletestatements + ",";
                            string[] deletestatementsfiles = cb_deletestatements.Split(',');

                            string[] statementsfilepaths = Directory.GetFiles(origpath + "\\statements");
                            string statementsfileName;
                            Boolean statementsskip;
                            if (statementsfilepaths.Count() != 0)
                            {
                                Directory.CreateDirectory(newpath + "\\statements");
                                foreach (string filePath in statementsfilepaths)
                                {
                                    statementsfileName = System.IO.Path.GetFileName(filePath);
                                    statementsskip = false;
                                    foreach (string deletefile in deletestatementsfiles)
                                    {
                                        if (deletefile == statementsfileName)
                                        {
                                            statementsskip = true;
                                        }
                                    }
                                    if (statementsskip != true)
                                    {
                                        File.Copy(filePath, newpath + "\\statements\\" + statementsfileName);
                                    }
                                }
                            }

                        }

                        if (Directory.Exists(origpath + "\\budget"))
                        {
                            cb_deletebudget = cb_deletebudget + ",";
                            string[] deletebudgetfiles = cb_deletebudget.Split(',');

                            string[] budgetfilepaths = Directory.GetFiles(origpath + "\\budget");
                            string budgetfileName;
                            Boolean budgetskip;
                            if (budgetfilepaths.Count() != 0)
                            {
                                Directory.CreateDirectory(newpath + "\\budget");
                                foreach (string filePath in budgetfilepaths)
                                {
                                    budgetfileName = System.IO.Path.GetFileName(filePath);
                                    budgetskip = false;
                                    foreach (string deletefile in deletebudgetfiles)
                                    {
                                        if (deletefile == budgetfileName)
                                        {
                                            budgetskip = true;
                                        }
                                    }
                                    if (budgetskip != true)
                                    {
                                        File.Copy(filePath, newpath + "\\budget\\" + budgetfileName);
                                    }
                                }
                            }
                        }
                    }

                    //}
                    //Greg 2jul2018 }
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl + ":074e1ab9-2a18-4841-940d-46af7cff91a0", "Error: " + ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            #endregion

            #region uploadfiles
            string usesubmissionpath = submissionpath + tb_reference + "\\strategicplan";
            string usesubmissionurl = webprotocol + "://" + webserver + "/" + submissionurl + tb_reference + "/strategicplan";

            if (fu_strategicplan.HasFiles)
            {
                //to do should pass back an object/class ???

                string[] strategicplansplit;

                //Greg 26/7/2018 strategicplan = strategicplan + strategicplan_delim + WDCFunctions.saveattachments(usesubmissionpath, "", fu_strategicplan, usesubmissionurl, Request.RawUrl);
                strategicplan = WDCFunctions.saveattachments(usesubmissionpath, "", fu_strategicplan, usesubmissionurl, Request.RawUrl);
                //WDCFunctions.Log(Request.RawUrl + ":f42ec76c-5fc4-45e1-b9f6-05345d34a5bc", strategicplan, "greg.tichbon@whanganui.govt.nz");

                string[] strategicplanresults = strategicplan.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (strategicplanresults[0] != "File(s) not provided")
                {
                    foreach (string result in strategicplanresults)
                    {
                        strategicplansplit = result.Split(fieldDelim);
                        strategicplanlinks = strategicplanlinks + strategicplan_delim + fu_strategicplan.FileName + "\x00FD" + strategicplansplit[4] + "/" + strategicplansplit[2];
                        strategicplan_display = strategicplan_display + strategicplan_delim + "<a href=\"" + strategicplansplit[4] + "/" + strategicplansplit[2] + "\" target=\"_Blank\">" + strategicplansplit[0] + "</a> - " + strategicplansplit[1];
                        strategicplan_delim = "\x00FE";
                    }
                }

            }
            else
            {
                strategicplan_display = strategicplan_display + strategicplan_delim + "File(s) not provided";
                strategicplan_delim = "\x00FE";
            }

            WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
            Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
            buildfiletableoptions["type"] = "list";
            string currentstrategicplan = wdcfunction.buildfiletable(usesubmissionpath, usesubmissionurl, "", buildfiletableoptions);
            if(currentstrategicplan != "")
            {
                strategicplan_display += "<br /><br />All Files" + currentstrategicplan;
            }


            //Greg start
            usesubmissionpath = submissionpath + tb_reference + "\\statements";
            usesubmissionurl = webprotocol + "://" + webserver + "/" + submissionurl + tb_reference + "/statements";

            if (fu_statements.HasFiles)
            {
                //to do should pass back an object/class ???
                string[] statementssplit;

                //Greg 26/7/2018 statements = statements + statements_delim + WDCFunctions.saveattachments(usesubmissionpath, "", fu_statements, usesubmissionurl, Request.RawUrl);
                statements = WDCFunctions.saveattachments(usesubmissionpath, "", fu_statements, usesubmissionurl, Request.RawUrl);
                string[] statementsresults = statements.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (statementsresults[0] != "File(s) not provided")
                {
                    foreach (string result in statementsresults)
                    {
                        statementssplit = result.Split(fieldDelim);
                        statementslinks = statementslinks + statements_delim + fu_statements.FileName + "\x00FD" + statementssplit[4] + "/" + statementssplit[2];
                        statements_display = statements_display + statements_delim + "<a href=\"" + statementssplit[4] + "/" + statementssplit[2] + "\" target=\"_Blank\">" + statementssplit[0] + "</a> - " + statementssplit[1];
                        statements_delim = "\x00FE";
                    }
                }
            }
            else
            {
                statements_display = statements_display + statements_delim + "File(s) not provided";
                statements_delim = "\x00FE";
            }

            string currentstatements = wdcfunction.buildfiletable(usesubmissionpath, usesubmissionurl, "", buildfiletableoptions);
            if (currentstatements != "")
            {
                statements_display += "<br /><br />All Files" + currentstatements;
            }

            usesubmissionpath = submissionpath + tb_reference + "\\budget";
            usesubmissionurl = webprotocol + "://" + webserver + "/" + submissionurl + tb_reference + "/budget";

            if (fu_budget.HasFiles)
            {
                //to do should pass back an object/class ???
                string[] budgetsplit;

                //Greg 26/7/2018 budget = budget + budget_delim + WDCFunctions.saveattachments(usesubmissionpath, "", fu_budget, usesubmissionurl, Request.RawUrl);
                budget = WDCFunctions.saveattachments(usesubmissionpath, "", fu_budget, usesubmissionurl, Request.RawUrl);
                string[] budgetresults = budget.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (budgetresults[0] != "File(s) not provided")
                {
                    foreach (string result in budgetresults)
                    {
                        budgetsplit = result.Split(fieldDelim);
                        budgetlinks = budgetlinks + budget_delim + fu_budget.FileName + "\x00FD" + budgetsplit[4] + "/" + budgetsplit[2];
                        budget_display = budget_display + budget_delim + "<a href=\"" + budgetsplit[4] + "/" + budgetsplit[2] + "\" target=\"_Blank\">" + budgetsplit[0] + "</a> - " + budgetsplit[1];
                        budget_delim = "\x00FE";
                    }
                }
            }
            else
            {
                budget_display = budget_display + budget_delim + "File(s) not provided";
                budget_delim = "\x00FE";
            }

            string currentbudget = wdcfunction.buildfiletable(usesubmissionpath, usesubmissionurl, "", buildfiletableoptions);
            if (currentbudget != "")
            {
                budget_display += "<br /><br />All Files" + currentbudget;
            }

            //Greg End

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
            cmd.Parameters.Add("@statutoryobligations", SqlDbType.VarChar).Value = dd_statutoryobligations;

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
            documentvalues["physicaladdress"] = tb_physicaladdress.Replace(Environment.NewLine,"<br />");
            documentvalues["postaladdress"] = tb_postaladdress.Replace(Environment.NewLine, "<br />");
            documentvalues["bankaccountnumber"] = tb_bankaccountnumber;
            documentvalues["gstnumber"] = tb_gstnumber;
            documentvalues["phonenumber"] = tb_phonenumber;
            documentvalues["emailaddress"] = tb_emailaddress;
            documentvalues["facebook"] = tb_facebook;
            documentvalues["website"] = tb_website;
            documentvalues["umbrellagroup"] = tb_umbrellagroup;
            documentvalues["constitution"] = dd_constitution;
            documentvalues["strategicplan"] = strategicplan_display.Replace("\x00FE", "<br />");
            documentvalues["statements"] = statements_display.Replace("\x00FE", "<br />");
            documentvalues["budget"] = budget_display.Replace("\x00FE", "<br />");
            documentvalues["employedstaff"] = tb_employedstaff.Replace(Environment.NewLine, "<br />");
            documentvalues["employmentcontracts"] = tb_employmentcontracts.Replace(Environment.NewLine, "<br />");
            documentvalues["jobdescriptions"] = tb_jobdescriptions.Replace(Environment.NewLine, "<br />");
            documentvalues["performancemanagement"] = tb_performancemanagement.Replace(Environment.NewLine, "<br />");
            documentvalues["paidstaff"] = tb_paidstaff;
            documentvalues["paidstaffhours"] = tb_paidstaffhours;
            documentvalues["volunteers"] = tb_volunteers;
            documentvalues["volunteerhours"] = tb_volunteerhours;
            documentvalues["financialpoliciespractices"] = dd_financialpoliciespractices;
            documentvalues["financialpeople"] = dd_financialpeople;
            documentvalues["accountingprogramme"] = tb_accountingprogramme;
            documentvalues["financialreports"] = tb_financialreports.Replace(Environment.NewLine, "<br />");
            documentvalues["financialyear"] = tb_financialyear;
            documentvalues["payrollsystem"] = tb_payrollsystem;
            documentvalues["premises"] = tb_premises;
            documentvalues["complaints"] = dd_complaints;
            documentvalues["statutoryobligations"] = dd_statutoryobligations;

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
                WDCFunctions.Log(Request.RawUrl + ":ae965607-0a57-4e17-b305-328636c0729c", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            // WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();


            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill Screen", "");
            screendocument = WDCFunctions.documentfill(screendocument, documentvalues);

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
                WDCFunctions.Log(Request.RawUrl + ":322613ed-9444-4740-9437-a8ddee3d1bff", ex.Message, "greg.tichbon@whanganui.govt.nz");
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
                WDCFunctions.Log(Request.RawUrl + ":60a623d9-970c-45c1-8fda-4484fc1408a4", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill email", "");
            emailbodydocument = WDCFunctions.documentfill(emailbodydocument, documentvalues);

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
                WDCFunctions.Log(Request.RawUrl + ":32cc88ac-2a6c-4cdf-a898-78e5f0ba15ef", ex.Message, "");
            }

            WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);
            #endregion

            Response.Redirect("default.aspx");

        }
    }
}