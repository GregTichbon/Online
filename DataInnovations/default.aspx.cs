using MessagingApp.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations
{
    public partial class _default : System.Web.UI.Page
    {
        string IPAddress = "192.168.10.39";
        string Port = "1688";
        string UserName = "";
        string Password = "";
        string Mode = "";
        string PhoneNumber = ""; //   "0272495088";
        string Message = ""; //"Test";
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            Mode = Request.QueryString["M"] ?? "";
            PhoneNumber = Request.QueryString["P"] ?? "";
            Message = Request.QueryString["M"] ?? "";
            SendMessage();
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            //SendMessage();
        }

        private async void SendMessage()
        {
            if(Mode == "S")
            {

            }
            if (PhoneNumber == "" || Message == "")
            {
                html = "Invalid Parameters";
            }
            else
            {
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

                            html = result.ToString();

                        }
                        else
                        {
                            html = result.Description;
                        }
                    }
                    else
                    {
                        html = response.ToString();
                    }
                }
            }
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