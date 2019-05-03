using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Test_iti_post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:60311/Raffles/posts.asmx/test2");
            request.Method = "POST";

            string jsonContent = @"{
                    ""param1"": ""1"",
                    ""param2"": ""2""}";

            System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
            Byte[] byteArray = encoding.GetBytes(jsonContent);

            request.ContentLength = byteArray.Length;
            request.ContentType = @"application/json";

            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            Stream receiveStream = response.GetResponseStream();

            StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);

            string ans = readStream.ReadToEnd();
            dynamic result = JsonConvert.DeserializeObject(ans);
            string name = result.d.status;

            response.Close();
            readStream.Close();
            */
        

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://iti.ninja/posts.asmx/Create_Link");
            request.Method = "POST";

            string jsonContent = @"{
                    ""link"": """",
                    ""datetimefrom"": """",
                    ""datetimeto"": """",
                    ""url"": ""http://facebook.com"",
                    ""description"": """",
                    ""recordlog"": ""Yes""}";

            System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
            Byte[] byteArray = encoding.GetBytes(jsonContent);

            request.ContentLength = byteArray.Length;
            request.ContentType = @"application/json";

            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            Stream receiveStream = response.GetResponseStream();

            StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);

            string ans = readStream.ReadToEnd();

            dynamic result = JsonConvert.DeserializeObject(ans);

            string val2 = result.d.value;

            response.Close();
            readStream.Close();
           


        }
    }
}