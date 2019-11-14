using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC.People.Reports
{
    public partial class Default : System.Web.UI.Page
    {
        public string html;
        public string script = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            html = "";


            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1")) //Highest Level
            {

                html += "<br /><a id=\"link1\" href=\"loginregister.aspx\">Login register</a>";
                script += "$('#link1').prop('title', 'A register of all login attempts whether successful or failure');";
                html += "<br /><a href=\"tracker.aspx\">Tracker</a>";
                html += "<br /><a href=\"FriendsStatementsPreview.aspx\">Friends Statemens Preiew</a>";
                html += "<br /><a href=\"RelationshipAudit.aspx\">Relationship Audit</a>";

            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                html += "<br /><a id=\"link2\" href=\"currentmembers.aspx\">Registered members for the current year</a>";
                script += "$('#link2').prop('title', 'All members who have a a registration date for the current year as defined in Parameter 1 - Current Season');";

                html += "<br /><a href=\"registrations.aspx\">All registrations</a>";

                html += "<br /><a href=\"ContactDetails.aspx\">Contact Details</a>";
                html += "<br /><a id=\"link3\" href=\"SchoolRowers.aspx\">School Rowers</a>";
                script += "$('#link3').prop('title', 'Those that have a school loaded and and \"Active\" Category');";

            }
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111101"))
            {
                html += "<br /><a href=\"smslog.aspx\">SMS Log</a>";
            }
        }
    }
}
