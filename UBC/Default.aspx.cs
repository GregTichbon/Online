using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC
{
    public partial class Default : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            html = "";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1")) //Highest Level
            {
                html += "<br /><a href=\"people/communicate.aspx\">Communicate</a>";
                html += "<br /><a href=\"people/categories.aspx\">Maintain all Categories</a>";
            }
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1000001"))
            {
                html += "<br /><a href=\"people/Masterscommunicate.aspx\">Masters Communicate</a>";
            }
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1")) //Highest Level
            {
                html += "<br /><a href=\"people/bankimport.aspx\">Bank Import</a>";
                html += "<br /><a href=\"people/bankallocate.aspx\">Bank Alloction</a>";
                html += "<br /><a href=\"people/transactions.aspx\">Transactions</a>";
            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1101"))
            {
                html += "<br /><a href=\"people/newslist.aspx\">News</a>";
            }
            html += "<br /><a href=\"people/newsviewer.aspx\">News Viewer</a>";
            html += "<br /><a href=\"calendar.aspx\">Calendar</a>";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "100001"))
            {
                html += "<br /><a href=\"bookinglist.aspx\">Bookings</a>";
                html += "<br /><a href=\"bookingcalendar.aspx\">Booking Calendar</a>";
            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1101"))
            {
                html += "<br /><a href=\"people/Search.aspx\">People Search</a>";
                html += "<br /><a href=\"people/List.aspx\">People List</a>";
            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                html += "<br /><a href=\"people/reports/CheckList.aspx\">Check List</a>";

                html += "<br /><a href=\"people/findphone.aspx\">Find a phone number</a>";
                html += "<br /><a href=\"people/keyregister.aspx\">Key Register</a>";

            }
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1011"))
            {
                html += "<br /><a href=\"people/attending.aspx\">Attending</a>";
                html += "<br /><a href=\"people/EventPlanner.aspx\">Event Planner</a>";
                html += "<br /><a href=\"people/EventList.aspx\">Event List</a>";    //not sure about this one!  Coaches to update attendance?
            }
            html += "<br /><a href=\"Training/ZoneTraining.aspx\">Zone Training</a>";
            html += "<br /><a href=\"people/Attend.aspx\">Record Your Attendance</a>";    


            html += "<br /><a href=\"people/resources.aspx\">Rowing Resources</a>";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111101"))
            {
                html += "<br /><a href=\"people/reports/AttendanceMatrix.aspx\">Attendance Matrix</a>";
                html += "<br /><a href=\"people/reports/CurrentCategoriesMatrix.aspx\">Current Categories Matrix</a>";
            }



            html += "<br /><a href=\"people/reports/EventSchedule.aspx\">Event Schedule</a>";
            html += "<br /><a href=\"people/reports/ShowAttendees.aspx\">Show Attendees</a>";
            html += "<br /><a href=\"people/reports/ComingEventsList.aspx\">Coming Events List</a>";
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11"))
            {
                html += "<br /><a href=\"people/upload.aspx\">Upload</a>";
            }
            html += "<br /><a href=\"people/reports/default.aspx\">REPORTS</a>";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
            {
                html += "<br /><a href=\"people/signup/menu.aspx\">SIGNUP</a>";
            }
        }
    }
}
 