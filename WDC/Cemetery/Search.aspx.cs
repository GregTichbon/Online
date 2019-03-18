using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Cemetery
{
    public partial class Search : System.Web.UI.Page
    {
        public string mode = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            mode = "&mode=";
            if (Request.QueryString["mode"] != null)
            {
                mode += Request.QueryString["mode"];
            }
        }
    }
}