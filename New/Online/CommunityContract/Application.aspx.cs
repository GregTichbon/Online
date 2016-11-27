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
    public partial class Application : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];
        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string selected;
        public string[] dd_fundingtype_values = new string[3] { "1 off", "Seeding", "Matching" };
        public string viewmode = "";

        #region fields
        public string hf_users_ctr;
        public string hf_application_ctr;
        public string tb_reference;
        public string dd_fundingtype;
        public string tb_projectname;
        public string tb_projectdescription;
        public string tb_peopledirectbenefit;
        public string tb_outcomes;
        public string tb_deeplyunited;
        public string tb_globallyconnected;
        public string tb_creativesmarts;
        public string tb_flowingwithrichness;
        public string tb_worksforeveryone;
        public string tb_saferwhanganui;
        public string tb_collaboration;
        public string fu_additionalfiles;
        public string tb_projectcost;
        public string tb_owncontributions;
        public string tb_committedfunding;
        public string tb_fundingapplications;
        public string tb_councilcontribution;
        public string tb_committedfunders;
        public string tb_fundersappliedto;
        public string tb_applicantname;
        public string tb_applicantposition;
        public string tb_applicantemail;
        public string tb_applicantphone;
        public string tb_applicantmobile;
        public string dd_finalised;
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
                hf_users_ctr = Session["communitycontracts_users_ctr"].ToString();

                if (Request.QueryString["populate"] == "True")
                {
                    tb_reference = "reference";

                }
                else
                {
                    string reference = "";
                    if (Request.QueryString["reference"] != null)
                    {
                        reference = Request.QueryString["reference"];
                        viewmode = "readonly";
                    }

                    String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                    SqlConnection con = new SqlConnection(strConnString);

                    //check whether they have created a groupdetails record for the current submissionperiod



                    SqlCommand cmd = new SqlCommand("Get_CC_Application", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
                    cmd.Parameters.Add("@users_ctr", SqlDbType.VarChar).Value = hf_users_ctr;
                    cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();

                            if (dr["Updated_groupdetails"].ToString() != "Yes")
                            {
                                Response.Redirect("groupdetails.aspx");
                            }
                            else
                            {
                                hf_application_ctr = dr["cc_application_ctr"].ToString();
                                tb_reference = dr["reference"].ToString();
                                dd_fundingtype = dr["fundingtype"].ToString();
                                tb_projectname = dr["projectname"].ToString();
                                tb_projectdescription = dr["projectdescription"].ToString();
                                tb_peopledirectbenefit = dr["peopledirectbenefit"].ToString();
                                tb_outcomes = dr["outcomes"].ToString();
                                tb_deeplyunited = dr["deeplyunited"].ToString();
                                tb_globallyconnected = dr["globallyconnected"].ToString();
                                tb_creativesmarts = dr["creativesmarts"].ToString();
                                tb_flowingwithrichness = dr["flowingwithrichness"].ToString();
                                tb_worksforeveryone = dr["worksforeveryone"].ToString();
                                tb_saferwhanganui = dr["saferwhanganui"].ToString();
                                tb_collaboration = dr["collaboration"].ToString();
                                fu_additionalfiles = dr["additionalfiles"].ToString();
                                tb_projectcost = dr["projectcost"].ToString();
                                tb_owncontributions = dr["owncontributions"].ToString();
                                tb_committedfunding = dr["committedfunding"].ToString();
                                tb_fundingapplications = dr["fundingapplications"].ToString();
                                tb_councilcontribution = dr["councilcontribution"].ToString();
                                tb_committedfunders = dr["committedfunders"].ToString();
                                tb_fundersappliedto = dr["fundersappliedto"].ToString();
                                tb_applicantname = dr["applicantname"].ToString();
                                tb_applicantposition = dr["applicantposition"].ToString();
                                tb_applicantemail = dr["applicantemail"].ToString();
                                tb_applicantphone = dr["applicantphone"].ToString();
                                tb_applicantmobile = dr["applicantmobile"].ToString();
                                dd_finalised = dr["finalised"].ToString();

                                string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + tb_reference;
                                string submissionurl = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionurl"] + "/" + tb_reference;

                                WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
                                Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
                                lbl_additionalfiles.Text = wdcfunction.buildfiletable(submissionpath, submissionurl, "additional", buildfiletableoptions);
                            }
                        }
                        else
                        {
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


        }

        //protected string populateselect(string[] options, string selectedoption)
        //{
        //    WDCFunctions.WDCFunctions myWDCFunctions = new WDCFunctions.WDCFunctions();
        //    return myWDCFunctions.populateselect(options, selectedoption);

        //}
    }
}