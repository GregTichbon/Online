using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract.Review
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("communitycontracts_reviewer");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if ((tb_username.Text == "CC2018" || tb_username.Text == "Lauren" || tb_username.Text == "Greg") && tb_password.Text == "4C0mmun1ty")
            {
                Session["communitycontracts_reviewer"] = true;
                Response.Redirect("default.aspx");
            }
            else
            {
                //string message = "Invalid user name / email address and password combination";
                Session["message_title"] = "Log in";
                Session["message_head"] = "Access denied";
                Session["message_message"] = "Invalid user name and password combination";
                Session["message_redirect"] = "communitycontract/review/login.aspx";
                Response.Redirect("../../message.aspx");
            }
        }
    }
}