using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;

namespace Online
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string headerimage;
        public string navbaradjust;
        public string webconfig;

        protected void Page_Load(object sender, EventArgs e)
        {
            webconfig = ConfigurationManager.AppSettings["ConfigName"];
            string fp = this.Page.Request.FilePath;
            if (fp.IndexOf("/wmc/", StringComparison.OrdinalIgnoreCase) >= 0)
            //if (fp.Contains("/wmc/"))
            {
                headerimage = ResolveUrl("~/wmc/banner-image.png");
            }
            else
            {
                headerimage = ResolveUrl("~/images/wdclogo.png");
            }
            if (fp.IndexOf("/communitycontract/", StringComparison.OrdinalIgnoreCase) >= 0)
            //if (fp.Contains("/communitycontract/"))
            {
                //navbaradjust = WDCFunctions.WDCFunctions.HTMLRaw("style='margin-top: 50px;'");
                navbaradjust = "margin-top: 50px;";
            }
            else
            {
                navbaradjust = "";
            }




        }    
    }
}