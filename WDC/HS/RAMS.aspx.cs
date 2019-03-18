using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.HS
{
    public partial class RAMS : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        static string moduleName = "xxxxxx";
        //string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        //string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        public string[] yesno = new string[2] { "Yes", "No" };
        public string[] category = new string[3] { "Environment", "Participants", "Technical" };
        public string[] em = new string[2] { "E", "M" };
        public string[] rate = new string[5] { "1", "2", "3", "4", "5" };


        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            if (!Page.IsPostBack)
            {
                string wdcscripts = "";
                if (Request.QueryString["populate"] != null)
                {
                    wdcscripts += "$.getScript('../scripts/wdc/populate.js');";
                }
                if (Request.QueryString["showfields"] != null)
                {
                    wdcscripts += "$.getScript('../scripts/wdc/showfields.js');";
                }
                if (wdcscripts != "")
                {
                    wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
                }
            }
        }
    }
}