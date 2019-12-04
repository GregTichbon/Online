using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC
{
    public partial class TestEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string host = "70.35.207.87";
            //string host = "datainn.co.nz";
            //string emailfrom = "ltr@datainn.co.nz";
            //string password = "m33t1ng";

            string host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
            string emailfrom = "info@unionboatclub.co.nz";
            string password = "R0wtheboat";
            int port = 587; // 465; // 25;
            Boolean enableSsl = true;

            string emailSubject = "Union Boat Club Test";
            string emailBCC = emailfrom;


            string emailfromname = "Union Boat Club";

            string emailRecipient = "greg@datainn.co.nz; gtichbon@teorahou.org.nz";
            string[] attachments = new string[0];
            Dictionary<string, string> emailoptions = new Dictionary<string, string>();
            string emailHtml = "<html><body>Test</body></html>";

            Functions functions = new Functions();
            functions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailSubject, emailHtml, emailRecipient, emailBCC,"",attachments,emailoptions);
        }
    }
}