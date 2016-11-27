using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Online.TestAndPlay
{
    public partial class calendar1 : System.Web.UI.Page
    {
        public string strConnString;
        protected void Page_Load(object sender, EventArgs e)
        {
            strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}