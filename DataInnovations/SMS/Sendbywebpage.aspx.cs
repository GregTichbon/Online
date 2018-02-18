using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS
{
    public partial class Sendbywebpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WebRequest wr = WebRequest.Create("http://office.datainn.co.nz/sms/send/?O=S&P=0272495088&M=Test1");
            wr.Timeout = 3500;

            WebResponse response = wr.GetResponse();
            Stream data = response.GetResponseStream();
            string html = String.Empty;
            using (StreamReader sr = new StreamReader(data))
            {
                html = sr.ReadToEnd();
            }
            Lit_result.Text = html;
        }
    }
}