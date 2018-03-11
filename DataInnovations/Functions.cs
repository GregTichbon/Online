using MessagingApp.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SMSChecker
{
    public class Functions
    {
        public string IPAddress = "";
        public string Port = "";
        public string UserName = "";
        public string Password = "";

        public string Test()
        {
            return "Greg";
        }

        

        public async Task<string> SendMessage(string PhoneNumber, string Message)
        //public string SendMessage(string PhoneNumber, string Message)
        {
            string returnval = "";
            getparams();


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
            return(returnval);
        }
        protected string ConstructBaseUri()
        {
            UriBuilder uriBuilder = new UriBuilder("http", IPAddress, Convert.ToInt32(Port));
            return uriBuilder.ToString();
        }

        public void getparams()
        {
            String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_PARAMETER", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@parameter", SqlDbType.VarChar).Value = "IPAddress";

            cmd.Connection = con;
            try
            {
                con.Open();
                //SqlDataReader dr = cmd.ExecuteReader();
                IPAddress = cmd.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.Message);
                //Console.WriteLine(ex.InnerException);
                throw ex;
            }
            finally
            {
                con.Close();
            }
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@parameter", SqlDbType.VarChar).Value = "Port";

            cmd.Connection = con;
            try
            {
                con.Open();
                //SqlDataReader dr = cmd.ExecuteReader();
                Port = cmd.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.Message);
                //Console.WriteLine(ex.InnerException);
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        private const string NetworkInfoUrlPath = "services/api/status/network";

        private const string BatteryInfoUrlPath = "services/api/status/battery";

        private const string MessagesUrlPath = "services/api/messaging";

        private const string MessageStatusUrlPath = "services/api/messaging/status";
    }
}