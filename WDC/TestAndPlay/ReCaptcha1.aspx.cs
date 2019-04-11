using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class ReCaptcha1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string a = "";
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            if (WDCFunctions.IsReCaptchValid(Request.Form["g-recaptcha-response"]))
            {
                a = "OK";
            }
            else
            {
                a = "not OK";
            };
            Literal1.Text = a;

        }
    }
}