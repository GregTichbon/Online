using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Pickups
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (tb_password.Text == "dontrump" && tb_name.Text != "")
            {
                Session["pickups_loggedin"] = "Yes";
                DateTime now = DateTime.Now;
                Session["pickups_name"] = tb_name.Text + " " + now.ToString();
                Response.Redirect("default.aspx");
            }
            else {
                Session.Remove("pickups_loggedin");
                Session.Remove("pickups_name");
            }
        }
    }
}