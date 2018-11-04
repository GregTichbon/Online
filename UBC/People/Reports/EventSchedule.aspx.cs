using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class EventSchedule : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

            if (!IsPostBack)
            {
                string person_id = Session["UBC_person_id"].ToString();
                string mycategories = localfunctions.get_person_category(person_id);
                
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Build_Event_Planner", con);

                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {

                        int c1 = 0;
                        string lastdate = "";
                        string endtd = "";


                        html = "<table><thead><tr><th>Monday</th><th>Tuesday</th><th>Wednesday</th><th>Thursday</th><th>Friday</th><th>Saturday</th><th>Sunday</th></tr></thead><tbody>";

                        while (dr.Read())
                        {
                            DateTime thedate = Convert.ToDateTime(dr["thedate"]);
                            string event_id = dr["event_id"].ToString();
                            string title = dr["title"].ToString();
                            string description = dr["description"].ToString().Replace("\r\n", "<br />");
                            string startdatetime = dr["startdatetime"].ToString();
                            string enddatetime = dr["enddatetime"].ToString();
                            string allday = dr["allday"].ToString();
                            string type = dr["type"].ToString();
                            string coach = dr["coach"].ToString();
                            string category = "|" + dr["category"].ToString() + "|";

                            string dateonly = thedate.ToString("d MMM yyyy");

                            if (dateonly != lastdate)
                            {
                                c1++;

                                if (c1 == 1)
                                {
                                    html += "<tr>";
                                }
                                html += endtd;
                                endtd = "</td>";
                                html += "<td>";
                                html += "<div class=\"date\">" + dateonly + "</div>";

                                lastdate = dateonly;

                            }

                            if (event_id != "")
                            {
                                string time;
                                if (allday == "Yes")
                                {
                                    time = "All day";
                                }
                                else
                                {
                                    time = Convert.ToDateTime(startdatetime).ToString("HH:mm") + " - " + Convert.ToDateTime(enddatetime).ToString("HH:mm");
                                }

                                string mine = " others";

                                foreach(string mycat in mycategories.Split('|'))
                                {
                                    string usecat = "|" + mycat + "|";
                                    if(category.IndexOf(usecat) != -1)
                                    {
                                        mine = " mine";
                                        break;
                                    } 

                                }

                                html += "<div id=\"event_" + event_id + "\" class=\"event " + type.Replace(" ","") + mine + "\"><div class=\"title\" title=\"" + description + "\">" + time + " " + title + "</div>";

                                if (coach != "")
                                {
                                    html += "<div class=\"coaches\" style=\"display:none\">";
                                    string[] coaches = coach.Split('|');

                                    foreach (string thecoach in coaches)
                                    {
                                        string[] thecoachparts = thecoach.Split(',');

                                         html += "<div class=\"person\" id=\"coach_event_" + event_id + "_" + thecoachparts[0] + "\" style=\"background-color:" + thecoachparts[2] + ";\">" + thecoachparts[1] + "</div>";
                                    }
                                    html += "</div>";

                                }
                                html += "</div>";
                            }

                            if (c1 == 7)
                            {
                                html += endtd + "</tr>" + "\r\n";
                                c1 = 0;
                            }

                        }
                        html += "</tbody></table>";
                    }

                    dr.Close();
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
