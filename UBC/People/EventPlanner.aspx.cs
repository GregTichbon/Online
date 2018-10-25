﻿using Generic;
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
        protected void Page_Load(object sender, EventArgs e)
        {
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
                        string description = dr["description"].ToString().Replace("\r\n","<br />");
                        string startdatetime = dr["startdatetime"].ToString();
                        string enddatetime = dr["enddatetime"].ToString();
                        string allday = dr["allday"].ToString();
                        string type = dr["type"].ToString();
                        string coach = dr["coach"].ToString();

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

                            html += "<div id=\"event_" + event_id + "\" class=\"event\"><div class=\"wrapper\"><div class=\"title\" title=\"" + description + "\">" + time + " " + title + "</div><span class=\"add\"></span></div>";

                            if (coach != "")
                            {
                                string[] coaches = coach.Split('|');

                                foreach (string thecoach in coaches)
                                {
                                    string[] thecoachparts = thecoach.Split(',');
                                    html += "<div class=\"wrapper\"><div class=\"person\" id=\"coach_event_" + event_id + "_" + thecoachparts[0] + "\" style=\"background-color:" + thecoachparts[2] + ";\">" + thecoachparts[1] + "</div><span class=\"remove\"></span></div>";
                                }

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
            } finally
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
            } finally
            {
                con.Close();
            }

            con.Dispose();
        }
    }
}
 
 
 
 