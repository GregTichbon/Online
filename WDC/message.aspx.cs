using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online
{
    public partial class message : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            Session.Remove("message_title");
            Session.Remove("message_head");
            Session.Remove("message_message");
            string redirect = Session["message_redirect"].ToString();
            Session.Remove("message_redirect");
            Response.Redirect(redirect);
        }
    }
}