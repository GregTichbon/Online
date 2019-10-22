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
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            html = "";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1")) //Highest Level
            {

                html += "<br /><a href=\"loginregister.aspx\">Login register</a>";
                html += "<br /><a href=\"tracker.aspx\">Tracker</a>";
                html += "<br /><a href=\"FriendsStatementsPreview.aspx\">Friends Statemens Preiew</a>";

            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                html += "<br /><a href=\"people/reports/currentmembers.aspx\">Registered members for given year</a>";
                html += "<br /><a href=\"ContactDetails.aspx\">Contact Details</a>";
            }
        }
    }
}
