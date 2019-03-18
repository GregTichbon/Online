using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.Configuration;
using System.Diagnostics;
using System.Xml.Linq;
using System.Data.SqlTypes;

using Online.Models;

namespace Online.General
{
    public partial class StockGrazing : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = true;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        static string moduleName = "StockGrazing";
        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        public string[] yesno_values = new string[2] { "Yes", "No" };
        #endregion

        #region fields
        public int Entity_CTR;
        public string dd_fundraiser;

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            if (!Page.IsPostBack)
            { }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}