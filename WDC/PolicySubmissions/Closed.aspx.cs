using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PolicySubmissions
{
    public partial class Closed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["policysubmissions_closed"] == null)
            {
                Response.Redirect("http://www.whanganui.govt.nz");
            }
            else
            {
                lit_title.Text = Session["policysubmissions_closed"].ToString();
                lit_datetime.Text = Session["policysubmissions_datetime"].ToString();
            }


        }
    }
}