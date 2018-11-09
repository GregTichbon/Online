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
        public string person_id;
        public string html = "";
        public string attendance_html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

            if (!IsPostBack)
            {
                person_id = Session["UBC_person_id"].ToString();
                string mycategories = localfunctions.get_person_category(person_id);
                string[] attendance_values = new string[3] { "Maybe", "Going", "Not Going" };

                foreach(string attendance in attendance_values) { 
                    attendance_html += "<div class=\"attendance\">" + attendance + "</div>";
                }

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Build_Event_Planner", con);
                cmd1.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;

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
                            string attendance = dr["attendance"].ToString();
                            string note = dr["note"].ToString();
                            string personnote = dr["personnote"].ToString();

                            if (attendance == "")
                            {
                                attendance = "Unknown";
                            }
                            attendance = attendance.Replace(" ", "");

                            string dateonly = thedate.ToString("d MMM yyyy");

                            if (dateonly != lastdate)
                            {
                                html += endtd;
                                c1++;

                                if (c1 == 1)
                                {
                                    html += "<tr>";
                                }
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

                                string past = "";
                                if (Convert.ToDateTime(startdatetime) <= DateTime.Now)
                                {
                                    past = " past";
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

                                html += "<div id=\"event_" + event_id + "\" class=\"event " + type.Replace(" ", "") + mine + past + "\" data-personnote=\"" + personnote + "\">"; //Start 1

                                if(past == "") { 
                                    html += "<div class=\"wrapper\">";  //Start 2
                                    html += "<span id=\"attend_event_" + event_id + "\" class=\"attend" + attendance + "\"></span>";

                                }
                                html += "<div class=\"title\" title=\"" + description + "\">" + time + " " + title + "</div>";
                                if (past == "")
                                {
                                    //html += "<span id=\"attend_event_" + event_id + "\" class=\"attend" + attendance + "\"></span>";
                                    html += "</div>";  //End 2
                                }

                                if (coach != "")
                                {
                                    html += "<div class=\"coaches\" style=\"display:none\">"; //Start 3
                                    string[] coaches = coach.Split('|');

                                    foreach (string thecoach in coaches)
                                    {
                                        string[] thecoachparts = thecoach.Split(',');

                                         html += "<div class=\"person\" id=\"coach_event_" + event_id + "_" + thecoachparts[0] + "\" style=\"background-color:" + thecoachparts[2] + ";\">" + thecoachparts[1] + "</div>";
                                    }
                                    html += "</div>";  //End 3

                                }
                                html += "</div>";  //End 1
                            }

                            if (c1 == 7)
                            {
                                html += endtd + "</tr>" + "\r\n";
                                endtd = "";
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
