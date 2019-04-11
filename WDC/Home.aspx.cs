using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Online
{
    public partial class Home : System.Web.UI.Page
    {
        public String webconfig;

        protected void Page_Load(object sender, EventArgs e)
        {
            webconfig = ConfigurationManager.AppSettings["ConfigName"];
        }
    }
}