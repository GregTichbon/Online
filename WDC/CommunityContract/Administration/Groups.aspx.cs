using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Administration
{
    public partial class Groups : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["communitycontracts_administrator"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            string html = "";
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);


            SqlCommand cmd = new SqlCommand("CC_Get_groups", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {

                    html = "<div class=\"table-responsive\"><table class=\"table\"><thead><tr><th>Period</th><th>Legal Name</th><th>Type</th><th>Contact</th><th>Username</th></tr></thead>";
                    while (dr.Read())
                    {

                        string submissionperiod = dr["submissionperiod"].ToString();
                        string phonenumber = dr["phonenumber"].ToString();
                        string emailaddress = dr["emailaddress"].ToString();
                        string facebook = dr["facebook"].ToString();
                        string website = dr["website"].ToString();


                        string contact = "";
                        if(phonenumber != "")
                        {
                            contact += phonenumber + "<br />";
                        }
                        if (emailaddress != "")
                        {
                            contact += "<a href=\"mailto:" + emailaddress + "\">" + emailaddress + "</a><br />";
                        }
                        if (facebook != "")
                        {
                            string url = "";
                            if(facebook.StartsWith("https://"))
                            {
                                url = facebook;
                                facebook = facebook.Remove(0, 8);
                            } else
                            {
                                url = "https://" + facebook;
                            }
                            contact += "<a href=\"" + url + "\" target=\"_blank\">" + facebook + "</a><br />";
                        }
                        if (website != "")
                        {
                            string url = "";
                            if (website.StartsWith("http://"))
                            {
                                url = website;
                                website = website.Remove(0, 7);
                            }
                            else if(website.StartsWith("https://"))
                            {
                                url = website;
                                website = website.Remove(0, 8);
                            }
                            else
                            {
                                url = "http://" + website;
                            }
                            contact += "<a href=\"" + url + "\" target=\"_blank\">" + website + "</a><br />";
                        }
                        html += "<tr>";
                        html += "<td>" + dr["submissionperiod"] + "</td>";
                        html += "<td>"+ dr["legalname"] + "</td>";
                        html += "<td>" + dr["grouptype"] + "</td>";
                        html += "<td>" + contact + "</td>";
                        html += "<td>" + dr["username"] + "</td>";
                        html += "</tr>";
                    }
                    html = html + "</table></div>";
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