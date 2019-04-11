using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PropertyRolls
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("proproll_administrator");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if ((tb_username.Text == "Archivist" && tb_password.Text == "scr0115"))
            {
                Session["proproll_administrator"] = true;

                Response.Redirect("default.aspx");
            }
           
        }
    }
}