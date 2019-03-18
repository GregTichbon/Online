using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Appointments
{

    public partial class _default : System.Web.UI.Page
    {
        public string mode = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("~/error");
            mode = "&mode=";
            if (Request.QueryString["mode"] != null) {
                mode += Request.QueryString["mode"];
            } 
        }
    }
}