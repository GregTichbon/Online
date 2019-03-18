using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class ReceiveFromPost2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:21328/TestAndPlay/ReceivefromPost1.aspx");
            request.Method = "POST";

            string formContent = "FormValue1=" + "aaa" + "&FormValue2=" + "bbb" + "&FormValue=" + "ccc";

            byte[] byteArray = Encoding.UTF8.GetBytes(formContent);
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = HttpUtility.UrlDecode(reader.ReadToEnd());
            //You may need HttpUtility.HtmlDecode depending on the response

            reader.Close();
            dataStream.Close();
            response.Close();
        }
    }
}