using SMSProcessing.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SMSProcessing
{
    public class Functions
    {
        string IPAddress = "";
        string Port = "";
        string UserName = "";
        string Password = "";
        string Operation = "";
        string PhoneNumber = ""; //   "0272495088";
        string Message = ""; //"Test";
        public string html = "";

        public string Test()
        {
            return "Greg";
        }

        public async Task<string> SendMessage(string PhoneNumber, string Message)
        {
            string returnval = "";
            using (var client = new HttpClient())
            {
                string url = ConstructBaseUri();
                client.BaseAddress = new Uri(url);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                if (!string.IsNullOrEmpty(UserName) && !string.IsNullOrEmpty(Password))
                {
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(
                                "Basic",
                                 Convert.ToBase64String(
                                 ASCIIEncoding.ASCII.GetBytes(
                                 string.Format("{0}:{1}", UserName, Password))));
                }
                var postData = new List<KeyValuePair<string, string>>();
                postData.Add(new KeyValuePair<string, string>("to", PhoneNumber));
                postData.Add(new KeyValuePair<string, string>("message", Message));
                HttpContent content = new FormUrlEncodedContent(postData);

                HttpResponseMessage response = await client.PostAsync(MessagesUrlPath, content);
                if (response.IsSuccessStatusCode)
                {
                    
                    PostMessageResponse result = await response.Content.ReadAsAsync<PostMessageResponse>();
                    if (result.IsSuccessful)
                    {
                        returnval = result.ToString();
                    }
                    else
                    {
                        returnval = result.Description;
                    }
                    
                }
                else
                {
                    returnval = response.ToString();
                }
            }
            return (returnval);
        }
        protected string ConstructBaseUri()
        {
            UriBuilder uriBuilder = new UriBuilder("http", IPAddress, Convert.ToInt32(Port));
            return uriBuilder.ToString();
        }

        private const string NetworkInfoUrlPath = "services/api/status/network";

        private const string BatteryInfoUrlPath = "services/api/status/battery";

        private const string MessagesUrlPath = "services/api/messaging";

        private const string MessageStatusUrlPath = "services/api/messaging/status";
    }
}