using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class email : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String localDate = DateTime.Now.ToString();
            System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
            message.To.Add("greg@stonesoup.org.nz");
            //message.To.Add("gtichbon@teorahou.org.nz");

            System.Net.Mail.MailAddress replyEmail = new System.Net.Mail.MailAddress("greg@stonesoup.org.nz","Greg Tichbon");
            message.ReplyToList.Add(new System.Net.Mail.MailAddress("greg@stonesoup.org.nz", "Greg Tichbon"));
            message.From = new System.Net.Mail.MailAddress("meetingscheduler@datainn.co.nz","Meeting Scheduler");

            message.Subject = "Subject: " + localDate;
            message.Body = "This is a test email sent by connecting to datainn.co.nz, 25 from greg@datainn.co.nz to greg@stonesoup.org.nz, passing zero authentication parameters.  It will be received but marked as ***SPAM*** in the subject line."; 


            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("datainn.co.nz", 25);
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential("meetingscheduler@datainn.co.nz", "m33t1ng");
            client.Send(message);

            lit_html.Text = localDate;
        }
    }
}