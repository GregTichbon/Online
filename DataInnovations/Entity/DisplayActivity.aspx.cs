using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace Online.Entity
{
    public partial class DisplayActivity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                Generic.Functions gFunctions = new Generic.Functions();

                char[] bar = { '|' };
                string[] parts = Request.QueryString["id"].Split(bar);
                string moduleName = parts[0];
                string reference = parts[5];

                string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];

                //lit_data.Text = Request.QueryString["id"] + "<br />" + submissionpath + "<br />";
                string screenpath = submissionpath + "\\" + reference + ".html";
                //screenpath = "F:\\InetPub\\OnlineTEST\\onlineSubmissions\\Finance\\DirectDebit\\923041045175220.html";
                string screendocument = "";

                try
                {
                    using (StreamReader sr = new StreamReader(screenpath))
                    {
                        screendocument = sr.ReadToEnd();
                    }
                }
                catch (Exception ex)
                {
                    gFunctions.Log("",Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                }
                lit_data.Text += screendocument;
            } else
            {
                Response.Redirect("account.aspx");
            }
        }
    }
}