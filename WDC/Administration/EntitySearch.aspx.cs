using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration
{
    public partial class EntitySearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string[] ValidIP = new string[2] { "127", "192" };
            string ThisIP = Page.Request.UserHostAddress.Substring(0,3);
            if (ThisIP != "127" && ThisIP != "192" && 1 ==2)
            {
                Session["message_title"] = "Access denied";
                Session["message_head"] = "Invalid IP address";
                Session["message_message"] = Page.Request.UserHostAddress;
                Session["message_redirect"] = "http://www.whanganui.govt.nz";
                Response.Redirect("../message.aspx");

            }
        }
    }
}