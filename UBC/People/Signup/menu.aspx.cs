using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC.People.Signup
{
    public partial class menu : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            html = "";

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11")) //Highest Level
            {
                html += "<br /><a href=\"communicate.aspx\">Communicate</a>";
                html += "<br /><a href=\"list.aspx\">List</a>";
                html += "<br /><a href=\"checklist.aspx\">Check List</a>";
                html += "<br /><a href=\"../../default.aspx\">Main menu</a>";

            }

        }
    }
}
