using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class SendEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
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
            */
            Generic.Functions gFunctions = new Generic.Functions();
            gFunctions.sendemail("Test", "Test Body", "gtichbon@teorahou.org.nz", "", "greg@datainn.co.nz");

            Response.Write(gFunctions.test());
            


        }
    }
}