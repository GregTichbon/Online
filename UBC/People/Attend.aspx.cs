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
    public partial class Attend : System.Web.UI.Page
    {
        public string html = "";
        public string name = "";
        public string[] attendance_values = new string[4] { "No", "Yes", "Maybe", "Will be late" };
        public string person_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            //when is the next sunday?
            DateTime today = DateTime.Today;
            int daysUntilDay = ((int)DayOfWeek.Sunday - (int)today.DayOfWeek + 7) + 8;
            

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            //string guid = "09DB9E21-D49E-441F-9076-2626B37E099C";
            string guid = Request.QueryString["id"];

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_person_event_attendance_byperson", con);
            cmd1.Parameters.Add("@personguid", SqlDbType.VarChar).Value = guid;
            cmd1.Parameters.Add("@days", SqlDbType.Int).Value = daysUntilDay;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            try
            {

                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string event_id = dr["event_id"].ToString();
                        person_id = dr["person_id"].ToString();
                        string title = dr["title"].ToString();
                        string description = dr["description"].ToString();

                        //allday = dr["allday"].ToString();
                        //startdatetime = dr["startdatetime"].ToString();
                        //enddatetime = dr["enddatetime"].ToString();
                        string datetimedesc = dr["datetimedesc"].ToString();
                        string type = dr["type"].ToString();
                        string attendance = dr["attendance"].ToString();
                        string personnote = dr["personnote"].ToString();
                        name = dr["name"].ToString();
                        string modifieddate = dr["AttendanceUpdated"].ToString();

                        html += "<tr id=\"event_" + event_id + "\">";
                        html += "<td><b>" + datetimedesc + "</b></td>";
                        html += "<td><b>" + title + "</b><br />" + description + "</td>";
                        /*
                                                string dd_attendance = "<select class=\"form-control tr_field\" id=\"dd_attendance_" + event_id + "\" data-id=\"" + event_id + "\" name=\"dd_attendance_" + event_id + "\">";
                                                dd_attendance += "<option></option>";
                                                dd_attendance += Functions.populateselect(attendance_values, attendance);
                                                dd_attendance += "</select>";

                                                html += "<td>" + dd_attendance + "</td>";
                          */
                        html += "<td>" + attendance + "</td>";
                        html += "<td>" + personnote + "</td>";
                        //html += "<td>" + modifieddate + "</td>";
                        html += "</tr>";
                    }
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