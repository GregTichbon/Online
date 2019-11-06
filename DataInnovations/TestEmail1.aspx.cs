using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;
using HtmlAgilityPack;

namespace DataInnovations
{
    public partial class TestEmail1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            {
                string host = "70.35.207.87";
                string emailfrom = "raffle@datainn.co.nz";
                string emailfromname = "Union Boat Club - Raffle";
                string password = "39%3Zxon";
                string emailbcc = "greg@datainn.co.nz";
                string replyto = "";
                string emailRecipient = "greg@datainn.co.nz";
                string emailsubject = "Test";
                string emailhtml = "<html><body>Test</body></html>";
                /*
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(emailfrom, emailfromname);
                if (replyto != "")
                {
                    string[] rtaddresses = replyto.Split(';');

                    IEnumerable<string> distinctrtaddresses = rtaddresses.Distinct();

                    foreach (string rtaddress in distinctrtaddresses)
                    {
                        mail.ReplyToList.Add(rtaddress);
                    }
                }

                SmtpClient client = new SmtpClient();
                client.Port = 25;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(emailfrom, password);
                client.Host = host;

                string[] emailaddresses = emailRecipient.Split(';');

                IEnumerable<string> distinctemailaddresses = emailaddresses.Distinct();

                foreach (string emailaddress in distinctemailaddresses)
                {
                    mail.To.Add(emailaddress);
                }

                if (emailbcc != "")
                {
                    string[] bccaddresses = emailbcc.Split(';');

                    IEnumerable<string> distinctbccaddresses = bccaddresses.Distinct();

                    foreach (string bccaddress in distinctbccaddresses)
                    {
                        mail.Bcc.Add(bccaddress);
                    }
                }

                mail.Subject = emailsubject;

                mail.IsBodyHtml = false;

                HtmlDocument doc = new HtmlDocument();
                doc.LoadHtml(emailhtml);

                string text = doc.DocumentNode.SelectSingleNode("//body").InnerText;
                mail.Body = text;
              
                System.Net.Mime.ContentType mimeType = new System.Net.Mime.ContentType("text/html");
                AlternateView alternate = AlternateView.CreateAlternateViewFromString(emailhtml, mimeType);
                mail.AlternateViews.Add(alternate);

                client.Send(mail);
                */
                Functions gFunctions = new Functions();

                gFunctions.sendemailV3(host, emailfrom, emailfromname, password, emailsubject, emailhtml, emailRecipient, emailbcc, replyto);


            }
        }
    }
}