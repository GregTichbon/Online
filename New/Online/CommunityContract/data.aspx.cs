using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.CommunityContract
{
    public partial class data : System.Web.UI.Page
    {
        public string result = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string mode = Request.QueryString["mode"];

            if (mode == "buildfilestable")
            {
                string name = Request.QueryString["name"];
                string reference = Request.QueryString["reference"];

                string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + reference;
                string submissionurl = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionurl"] + "/" + reference;

                WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
                Dictionary<string, string> buildfiletableoptions = new Dictionary<string, string>();
                string returntable = wdcfunction.buildfiletable(submissionpath, submissionurl, name, buildfiletableoptions);
                result = returntable;
            }

        }
    }
}