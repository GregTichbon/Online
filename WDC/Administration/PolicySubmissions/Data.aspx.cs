using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration.PolicySubmissions
{
    public partial class Data : System.Web.UI.Page
    {
        public string tables;
        public string table;

        protected void Page_Load(object sender, EventArgs e)
        {

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

            string tablename = "";
            if (Page.IsPostBack)
            {
                tablename = Request.Form["dd_table"].ToString();
            }

            Dictionary<string, string> tables_options = new Dictionary<string, string>();
            //tables_options["usevalues"] = "";
            tables_options["selecttype"] = "Label";
            tables_options["storedprocedure"] = "";
            tables_options["storedprocedurename"] = "";
            tables = WDCFunctions.buildandpopulateselect(strConnString, "PS_Tables", tablename, tables_options);

            if (tablename != "")
            {
                table = "";
                SqlConnection con = new SqlConnection(strConnString);


                SqlCommand cmd = new SqlCommand("PS_Table_Data", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@table", SqlDbType.VarChar).Value = tablename;
                cmd.Parameters.Add("@showsubmitter", SqlDbType.VarChar).Value = cb_showsubmitter.Checked;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            if(table == "")
                            {
                                table += "<table id=\"tbl_data\">";
                                table += "<thead>";
                                table += "<tr>";

                                for (int i = 0; i < dr.FieldCount; i++)
                                {
                                    table += "<th>" + dr.GetName(i) + "</th>";
                                }


                                table += "</tr>";
                                table += "</thead>";
                                table += "<thead>";
                            }
                            table += "<tr>";

                            for (int i = 0; i < dr.FieldCount; i++)
                            {
                                table += "<td>" + dr.GetValue(i) + "</td>";
                            }
                            table += "</tr>";


                        }
                        table += "</tbody>";
                        table += "</table>";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}