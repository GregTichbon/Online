using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS.Send
{
    public partial class SMSGateway : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            for (int i = 1; i <= 30; i++)
            {

                //WebRequest wr = WebRequest.Create("http://192.168.10.21:8080/?number=0272495088&text=test" + i.ToString());
                WebRequest wr = WebRequest.Create("http://192.168.10.21:8080/?number=0272604006&text=test" + i.ToString());
                wr.Timeout = 3500;

                //Console.WriteLine(i);

                WebResponse response = wr.GetResponse();
                Stream data = response.GetResponseStream();
                using (StreamReader sr = new StreamReader(data))
                {
                    html += sr.ReadToEnd() + "<br />";
                }

                data.Dispose();
                System.Threading.Thread.Sleep(1000);

            }

        }
    }
}