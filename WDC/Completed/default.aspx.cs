using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Completed
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["body"] == null)
            {
                Response.Redirect("..\\entity\\account.aspx");
            }
            lbl_body.Text = Session["body"].ToString();
            if (Session["online_entity_ctr"] != null)
            {
                lbl_body.Text += "<a href=\"..\\entity\\account.aspx\">Return to your account</a>";
            }

        }
 

    }
}