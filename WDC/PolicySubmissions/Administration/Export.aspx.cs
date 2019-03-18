using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PolicySubmissions.Administration
{
    public partial class Export : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["online_entity_ctr"] == null)
            {
                Response.Redirect("../../entity/login.aspx?folder=policysubmissions/administration&form=export");
            }
        }
    }
}