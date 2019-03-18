using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Entity
{
    public partial class account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["online_entity_ctr"] != null)
            {
                String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_Entity_Activity", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = Session["online_entity_ctr"];

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        Lit_activity.Text = "<table class=\"table table-striped table-responsive\"><tbody>";
                        Lit_activity.Text += "<tr><th>Date/Time</th><th>Module</th><th>Action</th><th>View</th></tr>";

                        while (dr.Read())
                        {
                            string mode = dr["Mode"].ToString();
                            switch (mode)
                            {
                                case "Insert":
                                    mode = "Record Created";
                                    break;
                                default:
                                    mode = "Unknown mode";
                                    break;
                            }
                            string description = dr["ModuleName"].ToString();
                            switch (description)
                            {
                                case "RatesDirectDebit":
                                    description = "Rates Direct Debit";
                                    break;
                                default:
                                    description = "Unknown module name";
                                    break;
                            }
                            string when = dr["datetime"].ToString();

                            Lit_activity.Text += "<tr><td>" + when + "</td><td>" + description + "</td><td>" + mode + "</td><td><a class=\"view\" href=\"javascript: void(0);\" id =\"" + dr["ModuleName"].ToString() + "|" + dr["Mode"].ToString() + "|" + dr["Module_CTR"].ToString() + "|" + mode + "|" + description + "|" + dr["reference"].ToString() + "\">View</a></td></tr>";
                        }
                        Lit_activity.Text += "</tbody></table>";
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
            }else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}