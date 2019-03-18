using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Web.Configuration;
using System.IO;

namespace Online.PolicySubmissions
{
    public partial class completed : System.Web.UI.Page
    {
         
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string module = Request.QueryString["module"] ?? "";
            string reference = Request.QueryString["id"] ?? "";

            if(module != "" && reference != "") { 

            string submissionpath = WebConfigurationManager.AppSettings[module + ".submissionpath"] + "\\";

            string screendocument = "";
            string screenpath = submissionpath + "\\" + reference + ".html";

            try
            {
                using (StreamReader sr = new StreamReader(screenpath))
                {
                    screendocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            lit_screendocument.Text = screendocument;
            } else
            {
                Response.Redirect("https://www.whanganui.govt.nz");
            }
        }
    }
}