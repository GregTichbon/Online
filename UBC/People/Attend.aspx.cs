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
        public string html_button;
        public string guid;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            To record my attendance

            person guid maybe passed in querystring
            if not signed on and no person guid, get the person guid from a cookie
            if person guid exists, sign out any logged in user, save person guid to cookie

            */

            //when is the next sunday?
            DateTime today = DateTime.Today;
            int daysUntilDay = ((int)DayOfWeek.Sunday - (int)today.DayOfWeek + 7) + 8;
            

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            guid = Request.QueryString["id"];
            //string guid = "09DB9E21-D49E-441F-9076-2626B37E099C";
            if (Session["UBC_person_id"] == null && guid == null)
            {
                if (Request.Cookies["UBC-GUID"] != null)
                {
                    guid = Request.Cookies["UBC-GUID"].Value;
                }
            }

            if (guid != null)
            {
                Session.Remove("UBC_person_id");
                Session.Remove("UBC_name");
                Session.Remove("UBC_AccessString");
                Session.Remove("UBC_Colour");

                //Response.Cookies["UBC-GUID"].Value = guid;
                HttpCookie cookie = new HttpCookie("UBC-GUID");
                cookie.Value = guid;
                cookie.Expires = DateTime.Now.AddMonths(3);
                Response.SetCookie(cookie);
            }

            if (Session["UBC_person_id"] == null && guid == null)
            {
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }

            Dependencies.functions.tracker((string)Session["UBC_person_id"], guid ?? "", HttpContext.Current.Request.Url.PathAndQuery);

            if (Session["UBC_person_id"] == null)
            {
                html_button = "<input type=\"button\" id=\"login\" class=\"toprighticon btn btn-info\" value=\"Log in\" />";
            }
            else
            {
                html_button = "<input type=\"button\" id=\"menu\" class=\"toprighticon btn btn-info\" value=\"MENU\" />";

            }

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_person_event_attendance_byperson", con);
            cmd1.Parameters.Add("@person_id", SqlDbType.VarChar).Value = Session["UBC_person_id"];
            cmd1.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = guid;
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
                        string stopattendanceentrydatetime = dr["stopattendanceentrydatetime"].ToString();
                        string myclass = "";
                        string closes = "";
                        if(stopattendanceentrydatetime != "")
                        {
                            closes = " - Entries close: " + Convert.ToDateTime(stopattendanceentrydatetime).ToString("d MMM yy HH:mm");
                            if (Convert.ToDateTime(stopattendanceentrydatetime) <= DateTime.Now)
                            {
                                myclass = " class=\"closed\"";
                            }
                        }

                        html += "<tr" + myclass + " id=\"event_" + event_id + "\">";
                        html += "<td><b>" + datetimedesc + "</b></td>";
                        html += "<td><b>" + title + closes + "</b><br />" + description + "</td>";
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