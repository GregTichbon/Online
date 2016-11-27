using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class Upload1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string links = "";
            string links_delim = "";
            string[] test1;
            string test2 = "";

            string othercouncil = "";
            string othercouncil_display = "";

            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };

            othercouncil = WDCFunctions.saveattachments("c:\\temp", "123", fu_othercouncil, "", Request.RawUrl);
            string[] results = othercouncil.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
            foreach (string result in results)
            {

                links = links + links_delim + "Other Council: " + fu_othercouncil.FileName + "\x00FD" + "WEBPROTOCOL" + "://" + "WEBSERVER" + "/onlinesubmissions/" + "MODULENAME" + "/" + "REFERENCE" + "/" + result.Split(fieldDelim, 2);
                othercouncil_display = othercouncil_display + links_delim + result.Split(fieldDelim, 0) + " - " + result.Split(fieldDelim, 1).ToString();
                links_delim = "\x00FE";

                test1 = result.Split(fieldDelim);
                test2 = test1[0];
            }

        }
    }
}
