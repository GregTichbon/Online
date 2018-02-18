using System;
using System.Web.Mail;

namespace Common
{
    public class Functions
    {
        public static string test()
        {
            return "Common:Test";
        }

        public static void sendemail()
        {
            string emailRecipient = "gtichbon@teorahou.org.nz";
            string emailbcc = "";
            string emailsubject = "Test";
            string emailbody = "Test";

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("mail@datainn.co.nz", "Mail");
            mail.ReplyToList.Add("gtichbon@teorahou.org.nz");

            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            //client.Host = "wdc-cas.local.whanganui.govt.nz";
            client.UseDefaultCredentials = false;
            //client.Credentials = new NetworkCredential("noreply@datainn.co.nz", "Passos123");
            client.Host = "datainn.co.nz"; //"192.168.1.78";

            mail.IsBodyHtml = true;

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
            mail.Body = emailbody;
            client.Send(mail);
        }
    }
}
