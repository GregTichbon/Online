using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HtmlAgilityPack;

namespace DataInnovations.SMS.Send
{
    public partial class Form : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btn_send_Click(object sender, EventArgs e)
        {
            if (dd_mode.SelectedValue == "Local URL")
            {
                WebRequest wr = WebRequest.Create("http://192.168.10.21:8080/?number=" + tb_mobilenumber.Text + "&text=" + HttpUtility.UrlEncode(tb_message.Text));
                wr.Timeout = 3500;

                //Console.WriteLine(i);

                WebResponse response = wr.GetResponse();
                Stream data = response.GetResponseStream();
                using (StreamReader sr = new StreamReader(data))
                {
                    string html = sr.ReadToEnd();
                    Response.Write(html);
                }

                data.Dispose();
            } else if(dd_mode.SelectedValue == "Generic Function")
            {
                Generic.Functions gFunctions = new Generic.Functions();
                string html = gFunctions.SendRemoteMessage(tb_mobilenumber.Text, tb_message.Text, "Send from form");
                Response.Write(html);

            }
            else if (dd_mode.SelectedValue == "office.datainn.co.nz URL")
            {
                WebRequest wr = WebRequest.Create("http://office.datainn.co.nz/sms/send?O=S&P=" + tb_mobilenumber.Text + "&M=" + HttpUtility.UrlEncode(tb_message.Text));
                wr.Timeout = 3500;

                //Console.WriteLine(i);

                WebResponse response = wr.GetResponse();
                Stream data = response.GetResponseStream();
                using (StreamReader sr = new StreamReader(data))
                {
                    string html = sr.ReadToEnd();
                    Response.Write(html);
                }

                data.Dispose();
            }
        }
    }
}