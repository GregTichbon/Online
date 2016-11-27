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
    public partial class review : System.Web.UI.Page
    {
         public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];

        public string html = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {


                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                string groupsubmissionpath = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionpath"] + "\\";
                string groupsubmissionurl = WebConfigurationManager.AppSettings["CommunityContractsGroupDetails" + ".submissionurl"] + "/";

                string applicationsubmissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\";
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
                        while (dr.Read()) {

                            string grouptable =       wdcfunction.buildfiletable(groupsubmissionpath       + dr["GroupReference"]      , "http://wdc.whanganui.govt.nz/" + groupsubmissionurl       + dr["GroupReference"]      , "xxx", buildfiletableoptions);
                            string applicationtable = wdcfunction.buildfiletable(applicationsubmissionpath + dr["ApplicationReference"], "http://wdc.whanganui.govt.nz/" + applicationsubmissionurl + dr["ApplicationReference"], "xxx", buildfiletableoptions);

                            html += "<tr>";
                            html += "<td><a href=\"http://wdc.whanganui.govt.nz/online/onlinesubmissions/CommunityContract/groupdetails/" + dr["GroupReference"]       + ".html\" target=\"_blank\">" + dr["legalname"]   + "</a><br />" + grouptable       + "</td>";
                            html += "<td><a href=\"http://wdc.whanganui.govt.nz/online/onlinesubmissions/CommunityContract/application/"  + dr["ApplicationReference"] + ".html\" target=\"_blank\">" + dr["projectname"] + "</a><br />" + applicationtable + "</td>";
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