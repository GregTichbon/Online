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

namespace Online.PolicySubmissions.Administration
{
    public partial class review : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["PolicySubmissions.submissionperiod"];

        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["online_entity_ctr"] == null)
            {
                Response.Redirect("../../entity/login.aspx?folder=policysubmissions/administration&form=review");
            }



        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            string policysubmissionspath = WebConfigurationManager.AppSettings["PolicySubmissions" + ".submissionpath"] + "\\";
            string policysubmissionsurl = WebConfigurationManager.AppSettings["PolicySubmissions" + ".submissionurl"] + "/";

            WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
            //string onlinemode = wdcfunction.onlinemode();
            string onlinemode = WDCFunctions.WDCFunctions.onlinemode();   //use if onlinemode was static  


            Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
            buildfiletableoptions["type"] = "List";


            SqlCommand cmd = new SqlCommand("PS_Review", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Submission_name", SqlDbType.VarChar).Value = dd_submission_name.Text;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {

                    html = "<div class=\"table-responsive\"><table class=\"table\"><thead><tr><th>Submitter</th><th>Speak</th><th>Created</th></tr></thead>";
                    while (dr.Read())
                    {

                        string policysubmissionstable = wdcfunction.buildfiletable(policysubmissionspath + dr["Reference"], "http://wdc.whanganui.govt.nz/" + policysubmissionsurl + dr["Reference"], "xxx", buildfiletableoptions);

                        html += "<tr>";
                        html += "<td>" + dr["Submitter"] + "</td><td>" + dr["speak"] + "</td><td><a href=\"http://wdc.whanganui.govt.nz/" + onlinemode  + "/onlinesubmissions/PolicySubmissions/" + dd_submission_name.Text + "/" + dr["Reference"] + ".html\" target=\"_blank\">" + dr["CreatedDate"] + "</a></td>";
                        html += "</tr>";
                    }
                    html = html + "</table></div>";
                }
                else
                {
                    html = "There are no submissions recorded for To do";
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