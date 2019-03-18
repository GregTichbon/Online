using System;
using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Administration
{
    public partial class ReportSetup : Page
    {
        public string tb_reference;

        public string CC_ReportRequirements_CTR;

   

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["communitycontracts_administrator"] == null)
            {
                base.Response.Redirect("Login.aspx");
            }
            this.tb_reference = base.Request.QueryString["reference"];
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString);
            string str = "";
            SqlCommand sqlCommand = new SqlCommand("Get_CC_ReportSettings", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };
            sqlCommand.Parameters.Add("@reference", SqlDbType.VarChar).Value = this.tb_reference;
            sqlCommand.Connection = sqlConnection;
            try
            {
                try
                {
                    sqlConnection.Open();
                    SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                    while (sqlDataReader.Read())
                    {
                        if (str == "")
                        {
                            this.CC_ReportRequirements_CTR = sqlDataReader["CC_ReportRequirements_CTR"].ToString();
                            str = string.Concat(new object[] { str, "<p>", sqlDataReader["ReportType"], " (", sqlDataReader["opendate"], " - ", sqlDataReader["closedate"], "</p>" });
                            str = (sqlDataReader["finalised"].ToString() != "Yes" ? string.Concat(str, "<p>Not Finalised</p>") : string.Concat(str, "<p>Finalised</p>"));
                            str = string.Concat(str, "<table class=\"table\" id=\"table_items\"><thead><tr><th class=\"item\" id=\"item_new\">Add</th><th>Prompt</th><th>Group</th></tr></thead><tbody>");
                        }
                        if (sqlDataReader["CC_Report_Item_CTR"].ToString() != "")
                        {
                            str = string.Concat(new object[] { str, "<tr><td class=\"item\" id=\"item_", sqlDataReader["CC_Report_Item_CTR"], "\" data-response=\"", sqlDataReader["response"], "\" data-type=\"", sqlDataReader["type"], "\" data-group=\"", sqlDataReader["CC_ReportGroup_CTR"],  "\">Edit</td><td>", sqlDataReader["prompt"], "</td><td>", sqlDataReader["Groupprompt"], "</td></tr>" });
                        }
                    }
                }
                catch (Exception exception)
                {
                    throw exception;
                }
            }
            finally
            {
                sqlConnection.Close();
                sqlConnection.Dispose();
            }
            if (str != "")
            {
                str = string.Concat(str, "</tbody></table>");
            }
            lit_html.Text = str;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand("Update_CC_ReportSettings", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure,
                Connection = sqlConnection
            };
            sqlConnection.Open();
            int num = 0;
            foreach (string form in base.Request.Form)
            {
                if (form.StartsWith("item_"))
                {
                    string item = base.Request.Form[form];
                    string[] strArrays = item.Split(new char[] { 'þ' });
                    string str = form.Substring(5);
                    if (str.StartsWith("new_"))
                    {
                        str = "0";
                    }
                    string str1 = strArrays[0];
                    string str2 = strArrays[1];
                    string str3 = strArrays[2];
                    string str4 = strArrays[3];
                    if ((str != "0" ? true : !(str3 == "Yes")))
                    {
                        sqlCommand.Parameters.Clear();
                        num++;
                        sqlCommand.Parameters.Add("@CC_ReportRequirements_CTR", SqlDbType.VarChar).Value = this.CC_ReportRequirements_CTR;
                        sqlCommand.Parameters.Add("@CC_Report_Item_CTR", SqlDbType.VarChar).Value = str;
                        sqlCommand.Parameters.Add("@sequence", SqlDbType.Int).Value = num;
                        sqlCommand.Parameters.Add("@prompt", SqlDbType.VarChar).Value = str2;
                        sqlCommand.Parameters.Add("@type", SqlDbType.VarChar).Value = str1;
                        sqlCommand.Parameters.Add("@group", SqlDbType.VarChar).Value = str3;
                        sqlCommand.Parameters.Add("@response", SqlDbType.VarChar).Value = "";
                        sqlCommand.Parameters.Add("@delflag", SqlDbType.VarChar).Value = str4;
                        sqlCommand.ExecuteNonQuery();
                    }
                }
            }
            sqlConnection.Close();
            sqlConnection.Dispose();
            base.Response.Redirect("review.aspx");
        }
    }
}