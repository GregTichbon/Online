using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;

namespace Online.TestAndPlay
{
    public partial class documentfill1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Dictionary<string, string> documentvalues = new Dictionary<string, string>();

            //foreach (string key in Request.Form.Keys)
            //{
            //    Debug.WriteLine(key + "=" + Request.Form[key]);
            //}

            documentvalues["f1"] = "F1";
            documentvalues["f2"] = "F2";
            documentvalues["f3"] = "F3";
            documentvalues["f4"] = "F4";
            documentvalues["f5"] = "F5";
            documentvalues["f6"] = "F6";
            documentvalues["f7"] = "F7";
        
            string screendocument = "";

            string path = Server.MapPath(".");

            string filepath = path + "\\documentfill1.html";
            using (StreamReader sr = new StreamReader(filepath))
            {
                screendocument = sr.ReadToEnd();
            }
           



            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
            screendocument = a.documentfill(screendocument, documentvalues);

            WDCFunctions.WDCFunctions.sendemail("Test", screendocument, "greg.tichbon@whanganui.govt.nz","");
        }
    }
}