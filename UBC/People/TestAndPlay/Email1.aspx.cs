using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using HtmlAgilityPack;

namespace UBC.People.TestAndPlay
{
    public partial class Email1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string emailfrom = "ltr@datainn.co.nz";
            string emailfromname = "Union Boat Club";
            string replyto = "";
            string emailRecipient = "greg@datainn.co.nz";
            string emailbcc = "";
            string emailsubject = "Test";
            string emailhtml = "<html><head></head><body><p><b>Greg was here</b></p></body></html>";
            string host = "70.35.207.87";
            string password = "m33t1ng";

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
            //mail.Body = emailtext;

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(emailhtml);
            string text = doc.DocumentNode.SelectSingleNode("//body").InnerText;
            mail.Body = text;




            System.Net.Mime.ContentType mimeType = new System.Net.Mime.ContentType("text/html");
            AlternateView alternate = AlternateView.CreateAlternateViewFromString(emailhtml, mimeType);
            mail.AlternateViews.Add(alternate);

            client.Send(mail);
        }
    }
}