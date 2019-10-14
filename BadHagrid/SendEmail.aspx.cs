using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace BadHagrid
{
    public partial class SendEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Generic.Functions gFunctions = new Generic.Functions();


                string body = "";
                body += "<html>";
                body += "<head>";
                body += "<title>Badhagrid</title>";
                body += "</head>";
                body += "<body>";
                body += "<p>Test</p>";
                body += "</body>";
                body += "</html>";

                Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                string[] attachments = new string[0];
                string host = "127.0.0.1";
                string password = "";

                gFunctions.sendemailV4(host, "mail@badhagrid.com", "Badhagrid", password, "Badhagrid", body, "greg@datainn.co.nz", "", "tpmoonshine@gmail.com", attachments, emailoptions);
            }
    }
}