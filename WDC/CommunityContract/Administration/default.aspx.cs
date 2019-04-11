using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Administration
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["communitycontracts_administrator"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}