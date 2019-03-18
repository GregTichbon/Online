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
    public partial class ApplicationList : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];

        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["communitycontracts_users_ctr"] != null)
            {
                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("CC_ApplicationList", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@cc_users_ctr", SqlDbType.BigInt).Value = Convert.ToInt16(Session["communitycontracts_users_ctr"]);
                cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        html = "<div class=\"table-responsive\"><table class=\"table\"><thead><tr><th>Description</th><th>Last Modified</th><th>Submission Period</th><th>Finalised</th><th>Required Report</th></tr></thead>";
                        while (dr.Read())
                        {
                            html = html + "<tr><td><a href=\"application.aspx?reference=" + dr["Reference"] + "\">" + dr["projectname"] + "</a></td>";
                            html = html + "<td>" + dr["ModifiedDate"] + "</td>";
                            html = html + "<td>" + dr["submissionperiod"] + "</td>";
                            html = html + "<td>" + dr["finalised"] + "</td>";
                            string report = dr["ReportingRequirements"].ToString();
                            string reportlink = "";
                            if (report == "")
                            {
                                report = "&nbsp;";
                            }
                            else
                            {
                                //string delim = "";
                                reportlink += "<ul>";
                                foreach (string reporttype in report.Split('\x00FE'))
                                {
                                    //Parts 0 = description, 1 = reference, 2 = FormName
                                    string[] parts = reporttype.Split('\x00FD');
                                    reportlink += "<li>" + "<a href=\"report" + parts[2] + ".aspx?reference=" + parts[1] + "\">" + parts[0] + "</a></li>";
                                    //reportlink += delim + "<a href=\"report" + parts[2] + ".aspx?reference=" + parts[1] + "\">" + parts[0] + "</a>";
                                    //delim = "<br />";
                                }
                                reportlink += "</ul>";
                            }

                            html = html + "<td>" + reportlink + "</td></tr>";


                            //CC_Application_CTR, Reference, projectname, ModifiedDate, finalised, submissionperiod
                        }
                        html = html + "</table></div>";
                    }
                    else
                    {
                        html = "There are no applications recorded against your group.";
                    }
                    Literal1.Text = html;
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
            else
            {
                Response.Redirect("default.aspx");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}