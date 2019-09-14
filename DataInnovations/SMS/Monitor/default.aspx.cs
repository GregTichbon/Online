using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS.Monitor
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string html = "";

            /*
            WebRequest wr = WebRequest.Create("http://192.168.10.88:8080/v1/sms?limit=999");
            wr.Timeout = 5000;

            WebResponse response = wr.GetResponse();
            Stream data = response.GetResponseStream();
            using (StreamReader sr = new StreamReader(data))
            {
                string retrnedjson = sr.ReadToEnd();

                //dynamic json = JsonConvert.DeserializeObject(retrnedjson);
                dynamic json = JObject.Parse(retrnedjson);


                string limit = json.limit;

                foreach (JObject fields in json["messages"])
                {
                    string msg_box = (string)fields["msg_box"];
                    if (msg_box != "outbox")
                    {
                        string address = (string)fields["address"];
                        string thread_id = (string)fields["thread_id"];
                        string body = (string)fields["body"];
                        string id = (string)fields["_id"];


                        //string timestamps = (string)fields["timestamps"];
                        foreach (JProperty timestamps in fields["timestamps"])
                        {
                            string myprop = timestamps.Name + " = " + timestamps.Value;
                        }

                        html += address + " " + body + "<br />"; 
                    }
                }
            }
                       Response.Write(html);
            */
            string time = DateTime.Now.ToShortTimeString();
            html = time;
            /*
            foreach (string key in Request.Form)
            {
                html += key + "=" + Request.Form[key];
            }
            */

            string path = @"c:\temp\smsmonitor.txt";
            TextWriter tw = new StreamWriter(path, true);
            tw.WriteLine(html);
            tw.Close();

            Response.Write(path + " " + time);
        }
    }
}