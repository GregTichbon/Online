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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMSChecker
{
    public partial class _default : System.Web.UI.Page
    {
        //string IPAddress = "";
        //string Port = "";
        //string UserName = "";
        //string Password = "";
        string Operation = "";
        string PhoneNumber = ""; //   "0272495088";
        string Message = ""; //"Test";
        public string html = "";



        protected void Page_Load(object sender, EventArgs e)
        {

            //Page.EnableViewState = false;
            //Page.ViewStateMode = 


            Operation = Request.QueryString["O"] ?? "";
            PhoneNumber = Request.QueryString["P"] ?? "";
            Message = Request.QueryString["M"] ?? "";
            Message = Message.Replace("^^", "&");
            SendMessage();
        }

        //private async void SendMessage()

        private void SendMessage()
        {
            if (Operation == "S")
            {

            }
            if (PhoneNumber == "" || Message == "")
            {
                html = "Invalid Parameters";
            }
            else
            {
                Dictionary<string, string> parameters = new Dictionary<string, string>();
                String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Get_Parameters", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read()) { 
                        parameters.Add(dr["Name"].ToString(), dr["Value"].ToString());
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                /*
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
                {Message
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
                */

                Message = HttpUtility.UrlEncode(Message);
                //WebRequest wr = WebRequest.Create("http://192.168.10.21:8080/?number=" + PhoneNumber + "&text=" + Message);
                WebRequest wr = WebRequest.Create("http://" + parameters["IPAddress"] + parameters["Port"] + parameters["url"] + "?" + parameters["FieldNumber"] + "=" + PhoneNumber + "&" + parameters["FieldMessage"] + "=" + Message);
                wr.Timeout = 3500;

                //Console.WriteLine(i);

                WebResponse response = wr.GetResponse();
                Stream data = response.GetResponseStream();
                using (StreamReader sr = new StreamReader(data))
                {
                    html += sr.ReadToEnd();
                }

                data.Dispose();
                System.Threading.Thread.Sleep(1000);

                /*
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
                */
            }
        }
    }
    /*
    protected string ConstructBaseUri()
    {
        UriBuilder uriBuilder = new UriBuilder("http", IPAddress, Convert.ToInt32(Port));
        return uriBuilder.ToString();
    }

    private const string NetworkInfoUrlPath = "services/api/status/network";

    private const string BatteryInfoUrlPath = "services/api/status/battery";

    private const string MessagesUrlPath = "services/api/messaging";

    private const string MessageStatusUrlPath = "services/api/messaging/status";
    */
}
