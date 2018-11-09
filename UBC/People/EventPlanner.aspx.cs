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
namespace UBC.People
{
    public partial class EventPlanner : System.Web.UI.Page
    {
        public string html = "";
        public string coaches_html = "";
        public string script = "";
        public string mode;
        public string hf_person_id = "";
        public string hf_person_name = "";
        public string hf_person_colour = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) {
                if (Session["UBC_person_id"] == null)
                {
                    Response.Redirect("~/people/security/login.aspx");
                }

                if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1011"))
                {
                    Response.Redirect("~/default.aspx");
                }

                if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1001"))
                {
                    mode = "admin";
                    script = "EventPlanner1.js";

                } else
                {
                    hf_person_id = Session["UBC_person_id"].ToString();
                    hf_person_name = Session["UBC_name"].ToString();
                    hf_person_colour = Session["UBC_colour"].ToString();
                    mode = "coach";
                    script = "EventPlanner2.js";
                }


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
                                html += "<div class=\"wrapper\">";
                                html += "<div class=\"date\">" + dateonly + "</div>";
                                if(mode == "admin")
                                {
                                    html += "<span class=\"addevent\"></span>";
                                }
                                html += "</div>";

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

                                html += "<div id=\"event_" + event_id + "\" class=\"event\"><div class=\"wrapper\"><div class=\"title\" title=\"" + description + "\">" + time + " " + title + "</div><span class=\"add\"></span></div>";

                                if (coach != "")
                                {
                                    string[] coaches = coach.Split('|');

                                    foreach (string thecoach in coaches)
                                    {
                                        string[] thecoachparts = thecoach.Split(',');
                                        if (thecoachparts[3] != "Not Going" && thecoachparts[3] != "No")
                                        {
                                            string remove = "";

                                            if (mode == "admin" || thecoachparts[0] == Session["UBC_person_id"].ToString())
                                            {
                                                remove = "<span class=\"remove\"></span>";
                                            }
                                            html += "<div class=\"wrapper\"><div class=\"person\" id=\"coach_event_" + event_id + "_" + thecoachparts[0] + "\" style=\"background-color:" + thecoachparts[2] + ";\">" + thecoachparts[1] + "</div>" + remove + "</div>";
                                        }
                                    }

                                }
                                html += "</div>";
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
                }

                /*get_persons_for_categories '5,2'*/
                SqlCommand cmd2 = new SqlCommand("get_persons_for_categories", con);

                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add("@categories", SqlDbType.VarChar).Value = "5";
                cmd2.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd2.ExecuteReader();
                    while (dr.Read())
                    {

                        string name = dr["name"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string colour = dr["colour"].ToString();

                        coaches_html += "<div id=\"coach_" + person_id + "\" class=\"coach\" style=\"background-color:" + colour + ";\">" + name + "</div>";

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
                }

                con.Dispose();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string hf_changes = Request.Form["hf_changes"].ToString();
            if (hf_changes != "")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd2 = new SqlCommand("update_event_coach", con);
                cmd2.CommandType = CommandType.StoredProcedure;

                string[] changes = hf_changes.Split(',');
                foreach (string change in changes)
                {
                    string[] parts = change.Split('_');

                    cmd2.Parameters.Clear();
                    cmd2.Parameters.Add("@action", SqlDbType.VarChar).Value = parts[0];
                    cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = parts[1];
                    cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = parts[2];

                    cmd2.Connection = con;
                    try
                    {
                        cmd2.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
                con.Close();
                con.Dispose();


            }
            string URL = Request.RawUrl;
            Response.Redirect(URL);


        }

    }
}
