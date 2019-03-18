using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class ReceivefromPost1 : System.Web.UI.Page
    {
        public string html = "Received<br />";
        protected void Page_Load(object sender, EventArgs e)
        {

            string[] keys = Request.Form.AllKeys;
            for (int i = 0; i < keys.Length; i++)
            {
                html += keys[i] + ": " + Request.Form[keys[i]] + "<br>";
            }

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            WDCFunctions.sendemail("Test", html, "greg.tichbon@whanganui.govt.nz", "");
        }
    }
}