using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Online
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            HttpContext con = HttpContext.Current;
            string url = con.Request.Url.ToString();
            string referrer = con.Request.ServerVariables["HTTP_REFERER"];

       /*
            string sessionvars = "";
            foreach (string key in con.Session.Keys)
            {
                sessionvars += key + " - " + con.Session[key] + "<br />";
            }
      */

            Exception ex = Server.GetLastError();

            //if (ex is HttpUnhandledException)
            //{
                // Pass the error on to the error page.
                Server.Transfer("~/Error/default.aspx?url=" + url + "&referrer=" + referrer, true);
            //}
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}