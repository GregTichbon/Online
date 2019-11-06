using Generic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS
{
    public partial class test2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Functions gFunctions = new Functions();
            string html = gFunctions.SendRemoteMessage("0272495088", "1" + System.Environment.NewLine + "2", "Test");
            Response.Write(html);
        }
    }
}