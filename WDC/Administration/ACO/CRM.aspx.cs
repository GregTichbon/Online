using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration.ACO
{
    public partial class CRM : System.Web.UI.Page
    {
        public string RESP_USER_ID;
        protected void Page_Load(object sender, EventArgs e)
        {

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;

            if (Session["online_entity_ctr"] != null)
            {
                if (Session["aco_resp_user_id"] == null)
                {
                    WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
                    string[,] authorisations = WDCFunctions.getWDCAccess(strConnString, "WDC", "Animal Control CRM", Session["online_entity_ctr"].ToString());
                    Session["aco_resp_user_id"] = authorisations[0, 2];
                }

                if (Session["aco_resp_user_id"] == null)
                {
                    Response.Redirect("~/Message.aspx");
                }
            } else
            {
                Response.Redirect("../../entity/login.aspx?folder=administration/aco&form=crm");
                //Response.Redirect("login.aspx");

            }
            RESP_USER_ID = Session["aco_resp_user_id"].ToString();


            //string strConnString = "Data Source=192.168.0.204;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("ACO_Get_CRM", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@RESP_USER_ID", SqlDbType.VarChar).Value = Session["aco_resp_user_id"];
            string html = "";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    html += "<thead><tr><th>Location</th><th>RAM ID</th><th>Category</th><th>Description</th><th>Caller</th><th>Officer</th><th>Decision</th></tr></thead>";
                    html += "<tbody>";
                    while (dr.Read())
                    {
                        string date_received = Convert.ToDateTime(dr["Date_Received"]).ToString("dd/MM/yy hh:mm");
                        string RAM_PROCESS_CTR = dr["RAM_PROCESS_CTR"].ToString();
                        string RAM_ID = dr["RAM_ID"].ToString();
                        string RAM_PRIMARY_CATEGORY = dr["RAM_PRIMARY_CATEGORY"].ToString();
                        string description = dr["description"].ToString();
                        string caller_surname = dr["caller_surname"].ToString();
                        string CALLER_GIVEN = dr["CALLER_GIVEN"].ToString();
                        string CALLER_HOME_PHONE = dr["CALLER_HOME_PHONE"].ToString();
                        string CALLER_WORK_PHONE = dr["CALLER_WORK_PHONE"].ToString();
                        string CALLER_Mobile = dr["CALLER_Mobile"].ToString();
                        string CALLER_EMAIL = dr["CALLER_EMAIL"].ToString();
                        string DECISION = dr["DECISION"].ToString();
                        string RESP_USER_ID = dr["RESP_USER_ID"].ToString();
                        string Officer = dr["Officer"].ToString();
                        string Location = dr["Location"].ToString();
                        string Animal_ID = dr["Animal_ID"].ToString();
                        string animal_description = dr["Animal_Description"].ToString();

                        string caller = "";
                        caller += CALLER_GIVEN + " " + caller_surname;
                        if (CALLER_HOME_PHONE != "")
                        {
                            caller += "<br />Home: " + CALLER_HOME_PHONE;
                        }
                        if (CALLER_WORK_PHONE != "")
                        {
                            caller += "<br />Work: " + CALLER_WORK_PHONE;
                        }
                        if (CALLER_Mobile != "")
                        {
                            caller += "<br />Mobile: " + CALLER_Mobile;
                        }
                        if (CALLER_EMAIL != "")
                        {
                            caller += "<br />Email: <a href=\"mailto:" + CALLER_EMAIL + "\">" + CALLER_EMAIL + "</a>";
                        }

                        string ramid_class = "ramid";
                        string ramid_atts = " data-id=\"" + RAM_PROCESS_CTR + "\"";
                        string officer_class = "officer";
                        string officer_atts = "";

                        if (!String.Equals(RESP_USER_ID, Session["aco_RESP_USER_ID"].ToString(), StringComparison.OrdinalIgnoreCase)) { //Not mine
                            ramid_class += " take";
                        } else
                        {
                            officer_class += " return";
                        }
                        ramid_atts += " class=\"" + ramid_class + "\" ";
                        officer_atts += " class=\"" + officer_class + "\" ";


                        if (Location.EndsWith("WHANGANUI"))
                        {
                            Location = Location.Substring(0, Location.Length - 9);
                        }
                        string trclass = "";
                        if(RESP_USER_ID == "ACO_CRM")
                        {
                            trclass = "";
                        } else {
                            trclass = " class=\"" + DECISION + "\"";
                        }

                        string display_description = "<b>" + date_received + "</b>";
                        if(Animal_ID != "")
                        {
                            display_description += "<br />" + "<span class='animal_id'>" + Animal_ID + " - " + animal_description + "</span>";
                        }
                        display_description += "<br />" + description;

                        html += "<tr" + trclass + ">";
                        html += "<td>" + Location + "</td>";
                        html += "<td" + ramid_atts + ">" + RAM_ID + "</td>";
                        html += "<td>" + RAM_PRIMARY_CATEGORY + "</td>";
                        html += "<td class=\"description\">" + display_description + "</td>";
                        html += "<td>" + caller + "</td>";
                        html += "<td" + officer_atts + ">" + Officer + "</td>";
                        html += "<td>" + DECISION + "</td>";
                        html += "</tr>";


                    }
                    html += "</tbody>";

                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
/*
    grant execute on usraniage to onlineservices
    grant select on animaster to onlineservices
    grant select on dirpeople to onlineservices
*/
                con.Close();
                con.Dispose();
            }
            lit_html.Text = html;
        }
    }
}