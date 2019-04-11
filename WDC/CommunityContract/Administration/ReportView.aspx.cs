using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Administration
{
    public partial class ReportView : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];
        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string selected;
        public string html = "";

        #region fields
        public string hf_cc_report_ctr;
        public string hf_CC_ReportRequirements_CTR;
        public string cc_users_ctr;
        public string tb_reference;
        public string tb_applicationreference;
        public string hf_applicantemail;
        public string tb_projectname;
        public string tb_highlights;
        public string tb_issues;
        public string dd_finalised;
        public string tb_open;
        public string hf_open;

        public string cb_deletefiles;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            if (!IsPostBack)
            {
                if (Session["communitycontracts_administrator"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                tb_reference = Request.QueryString["reference"];

               

                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);


                SqlCommand cmd = new SqlCommand("Get_CC_Report", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();

                        hf_cc_report_ctr = dr["report_ctr"].ToString();
                        hf_CC_ReportRequirements_CTR = dr["ReportRequirements_CTR"].ToString();
                        tb_applicationreference = dr["reference"].ToString();
                        tb_projectname = dr["projectname"].ToString();
                        hf_applicantemail = dr["applicantemail"].ToString();
                        tb_highlights = dr["highlights"].ToString();
                        tb_issues = dr["issues"].ToString();
                        tb_open = dr["opendate"].ToString() + dr["closedate"].ToString();
                        hf_open = dr["open"].ToString();
                        dd_finalised = dr["finalised"].ToString();
                        cc_users_ctr = dr["cc_users_ctr"].ToString();


                        

                        string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + tb_applicationreference + "\\reports\\" + tb_reference;
                        string submissionurl = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionurl"] + "/" + tb_applicationreference + "/reports/" + tb_reference;
                        string lastgroup = "";
                        Boolean injectused = false;

                        SqlConnection con2 = new SqlConnection(strConnString);
                        cmd = new SqlCommand("Get_CC_Report_items", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@CC_ReportRequirements_CTR", SqlDbType.Int).Value = hf_CC_ReportRequirements_CTR;

                        cmd.Connection = con2;
                        try
                        {
                            con2.Open();
                            SqlDataReader dr2 = cmd.ExecuteReader();
                            while (dr2.Read())
                            {
                                string CC_Report_Item_CTR = dr2["CC_Report_Item_CTR"].ToString();
                                string prompt = dr2["prompt"].ToString();
                                string type = dr2["type"].ToString();
                                string group = dr2["groupprompt"].ToString();
                                string response = dr2["response"].ToString();
                                string parameters = dr2["parameters"].ToString();
                                string help = dr2["help"].ToString();

                                string id = "response_" + CC_Report_Item_CTR;
                                string fld = "";

                                if(group != lastgroup)
                                {
                                    html += "<b>" + group + "</b>";
                                    lastgroup = group;
                                }

                                switch (type)
                                {
                                    case "Inject":
                                        {
                                            injectused = true;
                                            int c1 = 0;
                                            int c2 = 0;
                                            string fielddata = "";
                                            string fieldname = "";
                                            string value = "";
                                            string showvalue = "";
                                            string output = "";
                                            string hf_output = "";
                                            string simple_output = "";
                                            string simple_text = "";
                                            string shortprompt = "";
                                            string specifichelp = "";
                                            int flds = 0;

                                            prompt += "  ";

                                            fld = "<div class=\"form-group\">";
                                            fld += "<label class=\"control-label col-sm-4\" for=\"" + id + "\">" + "" + "</label>";
                                            fld += "<div class=\"col-sm-8\">";

                                            for (c1 = 0; c1 < prompt.Length - 2; c1++)
                                            {
                                                if (prompt.Substring(c1, 2) == "||")
                                                {
                                                    c2 = 2;
                                                    while (prompt.Substring(c1 + c2, 2) != "||")
                                                    {
                                                        c2 = c2 + 1;
                                                    }
                                                    flds++;
                                                    fielddata = prompt.Substring(c1 + 2, c2 - 2);
                                                    fielddata += "~~~";
                                                    string[] parms = fielddata.Split('~');
                                                    fieldname = parms[1];
                                                    value = parms[2];
                                                    shortprompt = parms[3];
                                                    specifichelp = parms[4];

                                                    if (shortprompt == "")
                                                    {
                                                        shortprompt = fieldname;
                                                    }

                                                    if (value == "")
                                                    {
                                                        showvalue = fieldname;
                                                    }
                                                    else
                                                    {
                                                        showvalue = value;
                                                    }
                                                    
                                                        if (specifichelp == "")
                                                        {
                                                            specifichelp = "Please click here to enter your response.";
                                                        }
                                                

                                                    output += "<span class=\"inject\" id=\"" + id + "_" + flds + "\" data-shortprompt=\"" + shortprompt + "\" data-value=\"" + value + "\" title=\"" + specifichelp + "\">" + showvalue + "</span>";
                                                    hf_output += "<input id=\"item_" + id + "_" + flds + "\" name=\"item_" + id + "_" + flds + "\" type=\"hidden\" value=\"" + value + "\">";
                                                    simple_output += "<span id=\"text_" + id + "_" + flds + "\">" + showvalue + "</span>";
                                                    simple_text += showvalue;

                                                    c1 = c1 + c2 + 1;
                                                }
                                                else
                                                {
                                                    output += prompt.Substring(c1, 1);
                                                    simple_output += prompt.Substring(c1, 1);
                                                    simple_text += prompt.Substring(c1, 1);
                                                }
                                            }

                                            //fld += output + hf_output + "<span class=\"temp\" id=\"item_" + id + "\">" + simple_output + "</span>";
                                            fld += output + hf_output + "<span style=\"display:none\" id=\"" + id + "\">" + simple_output + "</span><textarea style=\"display:none\" id=\"line_" + id + "\" name=\"line_" + id + "\">" + simple_text + "</textarea>";

                                            //fld += prompt + "<span class=\"inject\" name=\"" + id + "\" id=\"" + id + "\" data-shortprompt=\"To do\" title=\"" + help + "\">" + response + "</span> people.";



                                            fld += "</div>";
                                            fld += "</div>";
                                            //fld += "<input id=\"hf_" + id + "\" name=\"hf_" + id + "\" type=\"text\" value=\"" + prompt + "\">";

                                            break;
                                        }
                                    case "Textbox":
                                        {
                                            fld = "<div class=\"form-group\">";
                                            fld += "<label class=\"control-label col-sm-4\" for=\"item_" + id + "\">" + prompt + "</label>";
                                            fld += "<div class=\"col-sm-8\">";
                                            fld += "<textarea id=\"line_" + id + "\" name=\"item_" + id + "\" class=\"form-control\" required>" + response + "</textarea>";
                                            fld += "</div>";
                                            fld += "</div>";
                                            break;

                                            /*
                                             *     <div class="form-group">
        <label class="control-label col-sm-4" for="fu_files">Test of editible text</label>
        <div class="col-sm-8">
            Once apon a time there were <span class="inject" id="x1" data-shortprompt="Number of people" title="Please click here to enter your response.">25</span> people.
        </div>
    </div>
    */
                                        }
                                    default:
                                        break;

                                }

                                html += fld;
                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            con2.Close();
                            con2.Dispose();
                        }
                        if (html != "" && injectused)
                        {
                            string prehtml = "";
                            prehtml += "<div class=\"form-group\">";
                            prehtml += "<label class=\"control-label col-sm-4\"></label>";
                            prehtml += "<div class=\"col-sm-8\" style=\"font-weight: bold\">";
                            prehtml += "Click on the<span class=\"inject\"> Red </span>hilighted text to enter your responses";
                            prehtml += "</div>";
                            prehtml += "</div>";

                            html = prehtml + html;
                        }

                        WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
                        Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
                        //buildfiletableoptions["removeprefix"] = "_files";
                        lbl_files.Text = wdcfunction.buildfiletable(submissionpath, submissionurl, "", buildfiletableoptions);
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
}