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

namespace Online.Cemetery.DataMatching
{
    public partial class SextonPlots : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        public string[] dd_cemetery_values = new string[3] { "Company", "Partnership", "Individual" };
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            if (!Page.IsPostBack)
            {

            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string plots = Request.Form["hf_plots"].Trim();
            //string newdivisionid = Request.Form["hf_newdivisionid"].Trim();
            string division = Request.Form["division"].Trim();

        }
    }
}