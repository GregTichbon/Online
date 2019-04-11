using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration.ACO
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("aco_administrator");
            Session.Remove("aco_RESP_USER_ID");
            //Session.Remove("Officer");
            
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            if ((tb_username.Text == "Bernie" && tb_password.Text == "Bernie"))
            {
                Session["aco_administrator"] = true;
                Session["aco_RESP_USER_ID"] = "berniec";
                //Session["Officer"] = "AniSAC";

                Response.Redirect("crm.aspx");
            }
            if ((tb_username.Text == "Kimberly" && tb_password.Text == "Kimberly"))
            {
                Session["aco_administrator"] = true;
                Session["aco_RESP_USER_ID"] = "kimberlyT";
                //Session["Officer"] = "AniCon";

                Response.Redirect("crm.aspx");
            }
        }
    }
}