using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class _TestEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string host = "datainn.co.nz"; //"70.35.207.87";
            string emailfrom = "UnionBoatClub@datainn.co.nz";
            string password = "39%3Zxon";
            int port = 25;
            Boolean enableSsl = false;

            /*
            string host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
            string emailfrom = "info@unionboatclub.co.nz";
            string password = "R0wtheboat";
            int port = 587; // 465; // 25;
            Boolean enableSsl = true;
            */

            string emailfromname = "Union Boat Club";
            string emailbcc = "";
            string replyto = "";

            string emailsubject = "Test";
            string emailhtml = "<html><head></head><body>Test</body></html>";
            string emailRecipient = "greg@datainn.co.nz";
            string[] attachments = new string[0];

            Dictionary<string, string> emailoptions = new Dictionary<string, string>();
            /*
            Generic.Functions gFunctions = new Generic.Functions();
            gFunctions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailsubject, emailhtml, emailRecipient, emailbcc, replyto, attachments, emailoptions);
            */
            //      public void sendemailV5(string host, int port, Boolean enableSsl, string emailfrom, string emailfromname, string password, string emailsubject, string emailhtml, string emailRecipient, string emailbcc, string replyto, string[] attachments, Dictionary<string, string> options)

            try
            {
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
                client.Port = port;
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

                foreach (string attachment in attachments)
                {
                    mail.Attachments.Add(new Attachment(attachment));
                }
                client.EnableSsl = enableSsl;
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                client.Send(mail);
            }
            catch (Exception ex)
            {
                string message = ex.Message;
                string StackTrace = ex.StackTrace;
            }




        }
    }
}