using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Error
{
    public partial class _default : System.Web.UI.Page
    {
        protected Exception ex = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            /*
            Global.asax
            protected void Application_Error(object sender, EventArgs e)
                    {
                        HttpContext con = HttpContext.Current;
                        string url = con.Request.Url.ToString();
                        string referrer = con.Request.ServerVariables["HTTP_REFERER"];

                        Exception ex = Server.GetLastError();

                        //if (ex is HttpUnhandledException)
                        //{
                            // Pass the error on to the error page.
                            Server.Transfer("~/Error/default.aspx?url=" + url + "&referrer=" + referrer, true);
                        //}
                    }

            Web.Config
            <customErrors mode="On" />
            */


            string url = Server.UrlDecode(Request.QueryString["url"].ToString());
            string referrer = Server.UrlDecode(Request.QueryString["referrer"].ToString());

            string sessionvars = "";
            

            string body = "";
            body += "<p><b>URL:</b> " + url + "</b></p>";
            body += "<p><b>Referrer:</b> " + referrer + "</b></p>";
            body += "<p><b>Session Variables:</b> " + sessionvars + "</b></p>";
            // Get the last error from the server

            Exception ex = Server.GetLastError();

            // Show Inner Exception fields for local access
            if (ex.InnerException != null)
            {
                body += "<p><b>ex.InnerException.StackTrace:</b> " + ex.InnerException.StackTrace + "</p>";
                body += "<p><b>Request.IsLocal:</b> " + Request.IsLocal + "</p>";
                body += "<p><b>ex.InnerException.Message:</b> " + ex.InnerException.Message + "</p>";
            }
            body += "<p><b>ex.Message:</b> " + ex.Message + "</p>";
            body += "<p><b>ex.StackTrace:</b> " + ex.StackTrace + "</p>";


            // Clear the error from the server
            Server.ClearError();

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            WDCFunctions.sendemail("wdc.whanganui.govt.nz error: " + url, body, "greg.tichbon@whanganui.govt.nz", "");

        }
    }
}