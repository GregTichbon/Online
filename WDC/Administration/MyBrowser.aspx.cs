using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration
{
    public partial class MyBrowser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            System.Web.HttpBrowserCapabilities browser = Request.Browser;

            lit_response.Text = WDCFunctions.BrowserDetails(browser);

            

        }

        
    }
}