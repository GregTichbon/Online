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

namespace UBC
{
    public partial class BookingCalendar : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            Boolean admin = false;
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "100001"))
            {
                admin = true;
            }

            if (!IsPostBack)
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Build_Booking_Calendar", con);

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
                            string booking_id = dr["booking_id"].ToString();
                            string who = dr["who"].ToString();
                            string description = dr["description"].ToString().Replace("\r\n", "<br />");
                            string startdatetime = dr["startdatetime"].ToString();
                            string enddatetime = dr["enddatetime"].ToString();
                            string allday = dr["allday"].ToString();
                            string contact_details = dr["contact_details"].ToString();

                            string dateonly = thedate.ToString("d MMM yyyy");

                            if (dateonly != lastdate)
                            {
                                html += endtd;
                                if (c1 == 7)
                                {
                                    html += endtd + "</tr>" + "\r\n";
                                    endtd = "";
                                    c1 = 0;
                                }

                                c1++;

                                if (c1 == 1)
                                {
                                    html += "<tr>";
                                }
                                endtd = "</td>";
                                html += "<td>";
                                html += "<div class=\"date\" admin =\"" + admin + "\">" + dateonly + "</div>";

                                lastdate = dateonly;

                            }

                            if (booking_id != "")
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


  
                             
                                html += "<div id=\"booking_" + booking_id + "\" admin=\"" + admin + "\" class=\"booking " + past + "\">"; //Start 1

                                if (past == "")
                                {
                                    html += "<div class=\"wrapper\">";  //Start 2
                                }
                               
                                html += "<div class=\"who\" title=\"" + description + "\">" + time + "<br />" + who + "</div>";
                                if (past == "")
                                {
                                    //html += "<span id=\"attend_booking_" + booking_id + "\" class=\"attend" + attendance + "\"></span>";
                                    html += "</div>";  //End 2
                                }

                               
                               
                                html += "</div>";  //End 1
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
