using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class ICal1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string calendartemplate = Server.MapPath(".") + "\\ICal1.txt";
            string calendardocument = "";

            using (StreamReader sr = new StreamReader(calendartemplate))
            {
                calendardocument = sr.ReadToEnd();
            }

            //string UID = WDCFunctions.getReference("guid") + "@wdc.whanganui.govt.nz";

            string UID = "6e785a41-f785-4188-afa6-db7bdb1f5618@wdc.whanganui.govt.nz";
            calendardocument = calendardocument.Replace("||EVENT_UID||", UID);

            string DTSTAMP = DateTime.UtcNow.ToString("yyyyMMdd'T'HHmmss'Z'");
            calendardocument = calendardocument.Replace("||EVENT_DTSTAMP||", DTSTAMP);

            calendardocument = calendardocument.Replace("||SEQUENCE||", tb_sequence.Text);
            

            WDCFunctions.sendemailwithAttachments("Ical1", "ICal1", tb_email.Text, "", calendardocument);

        }

        protected void btn_remove_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string calendartemplate = Server.MapPath(".") + "\\ICal1Remove.txt";
            string calendardocument = "";

            using (StreamReader sr = new StreamReader(calendartemplate))
            {
                calendardocument = sr.ReadToEnd();
            }

            //string UID = WDCFunctions.getReference("guid") + "@wdc.whanganui.govt.nz";

            string UID = "6e785a41-f785-4188-afa6-db7bdb1f5618@wdc.whanganui.govt.nz";
            calendardocument = calendardocument.Replace("||EVENT_UID||", UID);

            string DTSTAMP = DateTime.UtcNow.ToString("yyyyMMdd'T'HHmmss'Z'");
            calendardocument = calendardocument.Replace("||EVENT_DTSTAMP||", DTSTAMP);

            calendardocument = calendardocument.Replace("||SEQUENCE||", "9");

            WDCFunctions.sendemailwithAttachments("Ical1 Remove", "ICal1 Remove", tb_email.Text, "", calendardocument);
        }
    }
}




