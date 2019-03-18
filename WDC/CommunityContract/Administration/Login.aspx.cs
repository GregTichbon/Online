using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Administration   
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("communitycontracts_administrator");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if ( (tb_username.Text == "Lauren" || tb_username.Text == "Greg") && tb_password.Text == "0n11n3")
            {
                Session["communitycontracts_administrator"] = true;
                Response.Redirect("default.aspx");
            } 
        }
    }
}