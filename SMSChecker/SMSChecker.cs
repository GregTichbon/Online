using MessagingApp.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace SMSChecker
{
    public partial class SMSChecker : ServiceBase
    {
        private const string NetworkInfoUrlPath = "services/api/status/network";
        private const string BatteryInfoUrlPath = "services/api/status/battery";
        private const string MessagesUrlPath = "services/api/messaging";
        private const string MessageStatusUrlPath = "services/api/messaging/status";

        public static string IPAddress = "192.168.10.39";
        public static string Port = "1688";
        public static string UserName = "";
        public static string Password = "";

        public SMSChecker()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            RetrieveNewMessages();
        }

        protected override void OnStop()
        {
        }
        static async void RetrieveNewMessages()
        {
            Functions a = new Functions();
            try
            {
                using (var client = new HttpClient())
                {
                    string url = ConstructBaseUri();
                    client.BaseAddress = new Uri(url);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    if (UserName != "" && Password != "")
                    {
                        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(
                                    "Basic",
                                     Convert.ToBase64String(
                                     ASCIIEncoding.ASCII.GetBytes(
                                     string.Format("{0}:{1}", UserName, Password))));
                    }


                    HttpResponseMessage response = await client.GetAsync(MessagesUrlPath + "?lastmessageid=742");
                    if (response.IsSuccessStatusCode)
                    {
                        GetMessageResponse result = await response.Content.ReadAsAsync<GetMessageResponse>();
                        if (result.IsSuccessful)
                        {
                            String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                            SqlConnection con = new SqlConnection(strConnString);

                            SqlCommand cmd = new SqlCommand("UPDATE_RECEIVED", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            foreach (DeviceMessage msg in result.Messages)
                            {
                                Console.WriteLine(msg.ToString());


                                cmd.Parameters.Add("@DateTime", SqlDbType.VarChar).Value = msg.Date;
                                cmd.Parameters.Add("@messageID", SqlDbType.VarChar).Value = msg.Id;
                                cmd.Parameters.Add("@message", SqlDbType.NVarChar).Value = msg.Message;
                                cmd.Parameters.Add("@number", SqlDbType.VarChar).Value = msg.Number;
                                cmd.Parameters.Add("@threadid", SqlDbType.VarChar).Value = msg.ThreadId;
                                cmd.Parameters.Add("@receiver", SqlDbType.VarChar).Value = msg.Receiver;
                                cmd.Parameters.Add("@sender", SqlDbType.VarChar).Value = msg.Sender;
                                cmd.Parameters.Add("@messagetype", SqlDbType.VarChar).Value = msg.MessageType;

                                cmd.Connection = con;
                                try
                                {
                                    con.Open();
                                    SqlDataReader dr = cmd.ExecuteReader();
                                    if (dr.HasRows)
                                    {
                                        while (dr.Read())
                                        {

                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine(ex.Message);
                                    Console.WriteLine(ex.InnerException);
                                    throw ex;
                                }
                                finally
                                {
                                    con.Close();
                                }
                                cmd.Parameters.Clear();

                                //services / api / messaging /{ id}

                                if (msg.MessageType == "MESSAGE_TYPE_INBOX")
                                {

                                    if (msg.Message.Substring(0, 1) == "@")
                                    {
                                        int nextat = msg.Message.IndexOf('@', 1);
                                        if (nextat != -1)
                                        {
                                            string word = msg.Message.Substring(1, nextat - 1);
                                            string message = msg.Message.Substring(nextat + 1);
                                        }
                                        else
                                        {
                                            // there is no message
                                        }

                                    }
                                    else if (msg.Message.Substring(0, 1) == "!")
                                    {
                                        string mymessage = msg.Message + "!!!!!!!!!!!!";
                                        string[] parts = msg.Message.Split('!');

                                        switch (parts[1])
                                        {
                                            case "send":
                                                parts[2] = parts[2] ?? "";
                                                switch (parts[2])
                                                {
                                                    case "test":
                                                        a.SendMessage(msg.Number, "Your test was received").ToString();
                                                        break;
                                                }
                                                break;
                                            case "status":
                                                parts[2] = parts[2] ?? "";
                                                //update status for parts[2] on database record datetime ie: last updated: xxxx
                                                parts[3] = parts[3] ?? "";
                                                if (parts[3] != "")
                                                {
                                                    //send out the status message to every one in parts[2]
                                                }
                                                break;
                                        }
                                    }
                                }
                            }
                            con.Dispose();
                        }
                        else
                        {
                            //to do
                        }
                    }
                    else
                    {
                        //to do
                    }
                }
            }
            catch (Exception ex)
            {
                //to do
            }

        }
        static string ConstructBaseUri()
        {
            UriBuilder uriBuilder = new UriBuilder("http", IPAddress, Convert.ToInt32(Port));
            return uriBuilder.ToString();
        }
    }
}
