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

namespace Online.CommunityContract.Administration
{
    public partial class _default1 : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];

        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["communitycontracts_reviewer"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            string groupsubmissionpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionpath"];
            string groupsubmissionurl = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionurl"] + "/";

            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];

            string usesubmissionurl = webprotocol + "://" + webserver + "/";


            string applicationsubmissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"];
            string applicationsubmissionurl = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionurl"] + "/";

            WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
            Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
            buildfiletableoptions["type"] = "List";


            SqlCommand cmd = new SqlCommand("CC_ApplicationReview", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;
            cmd.Parameters.Add("@finalisedonly", SqlDbType.Bit).Value = 1;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {

                    html = "<div class=\"table-responsive\"><table class=\"table\"><thead><tr><th>Group</th><th>Project</th></tr></thead>";
                    while (dr.Read())
                    {

                        string groupbudgettable = wdcfunction.buildfiletable(groupsubmissionpath + dr["GroupReference"] + "\\budget", usesubmissionurl + groupsubmissionurl + dr["GroupReference"] + "/budget", "xxx", buildfiletableoptions);
                        string groupstatementstable = wdcfunction.buildfiletable(groupsubmissionpath + dr["GroupReference"] + "\\statements", usesubmissionurl + groupsubmissionurl + dr["GroupReference"] + "/statements", "xxx", buildfiletableoptions);
                        string groupstrategicplantable = wdcfunction.buildfiletable(groupsubmissionpath + dr["GroupReference"] + "\\strategicplan", usesubmissionurl + groupsubmissionurl + dr["GroupReference"] + "strategicplan", "xxx", buildfiletableoptions);
                        string grouptable = "Budget" + groupbudgettable + "Statements" + groupstatementstable + "Strategic Plan" + groupstrategicplantable;


                        string applicationtable = wdcfunction.buildfiletable(applicationsubmissionpath + dr["ApplicationReference"], usesubmissionurl + applicationsubmissionurl + dr["ApplicationReference"], "xxx", buildfiletableoptions);

                        html += "<tr>";
                        html += "<td><a href=\"" + usesubmissionurl + "onlinesubmissions/CommunityContract/groupdetails/" + dr["GroupReference"] + ".html\" target=\"ccreview\">" + dr["legalname"] + "</a><br />" + grouptable + "</td>";
                        html += "<td><a href=\"" + usesubmissionurl + "onlinesubmissions/CommunityContract/application/" + dr["ApplicationReference"] + ".html\" target=\"ccreview\">" + dr["projectname"] + "</a><br />" + applicationtable + "</td>";
                        html += "</tr>";
                    }
                    html = html + "</table></div>";
                }
                else
                {
                    html = "There are no applications recorded for the " + submissionperiod + " submission period.";
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

    }
}