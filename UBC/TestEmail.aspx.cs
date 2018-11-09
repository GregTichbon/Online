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
            string emailSubject = "Union Boat Club Test";
            string emailBCC = "";
            //string host = "datainn.co.nz";
            string host = "70.35.207.87";
            string emailfrom = "ltr@datainn.co.nz";
            string emailfromname = "Union Boat Club";
            string password = "m33t1ng";
            string emailRecipient = "greg@datainn.co.nz; gtichbon@teorahou.org.nz"; 


            Functions functions = new Functions();
            functions.sendemailV2(host, emailfrom, emailfromname, password, emailSubject, "Test", "Test", emailRecipient, emailBCC, "");

        }
    }
}