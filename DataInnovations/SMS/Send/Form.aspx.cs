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
            //string xx = "";
            string[] lines = tb_mobilenumber.Text.Split(new[] { Environment.NewLine }, StringSplitOptions.None);
            string mobile = "";
            foreach (string line in lines)
            {
                string message = tb_message.Text;
                if (line != "")
                {
                    string[] fields = line.Split(',');
                    int c1 = 0;
                    foreach (string field in fields)
                    {
                        c1++;
                        if (c1 == 1)
                        {
                            mobile = field;
                        }
                        message = message.Replace("||" + c1.ToString() + "||", field);
                    }
                    //xx += message + "<br />";

                    if (dd_mode.SelectedValue == "Local URL")
                    {
                        string[] numbers = mobile.Split(';');
                        foreach (string number in numbers)
                        {
                            WebRequest wr = WebRequest.Create("http://192.168.10.80:8080/?number=" + number + "&text=" + HttpUtility.UrlEncode(message));
                            wr.Timeout = 3500;

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
                    else if (dd_mode.SelectedValue == "Generic Function")
                    {
                        Generic.Functions gFunctions = new Generic.Functions();
                        string[] numbers = mobile.Split(';');
                        foreach (string number in numbers)
                        {
                            string html = gFunctions.SendRemoteMessage(number, message, "Send from form");
                            Response.Write(html);
                        }

                    }
                    else if (dd_mode.SelectedValue == "office.datainn.co.nz URL")
                    {
                        string[] numbers = mobile.Split(';');
                        foreach (string number in numbers)
                        {
                            WebRequest wr = WebRequest.Create("http://office.datainn.co.nz/sms/send?O=S&P=" + number + "&M=" + HttpUtility.UrlEncode(message));
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
            //Response.Write(xx);
        }
    }
}