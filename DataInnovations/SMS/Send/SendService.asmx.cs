using MessagingApp.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Services;

namespace DataInnovations.SMS.Send
{
    /// <summary>
    /// Summary description for SendService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SendService : System.Web.Services.WebService
    {
        string IPAddress = "";
        string Port = "";

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        //public async Task<string> SendMessage(string PhoneNumber, String Message)
        public string SendMessage(string PhoneNumber, String Message)
        {
            string returnval = "";
            Generic.Functions gFunctions = new Generic.Functions();
            gFunctions.SendMessage(PhoneNumber, Message);
     
            return (returnval); ;
        }

        public async void SendMessageX(NameValue[] formVars)
        {
            string Operation = formVars.Form("Operation");
            string PhoneNumber = formVars.Form("PhoneNumber");
            string Message = formVars.Form("Message");

            string UserName = "";
            string Password = "";
            string html = "";
            
            if (Operation == "S")
            {

            }
            if (PhoneNumber == "" || Message == "")
            {
                html = "Invalid Parameters";
            }
            else
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

    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }
    #endregion

    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}

