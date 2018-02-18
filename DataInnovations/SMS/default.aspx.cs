using SMSChecker;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_send_Click(object sender, EventArgs e)
        {
            Functions a = new Functions();
            string response = "";
            foreach (ListItem listItem in cbl_recipients.Items)
            {
                if (listItem.Selected)
                {
                    //this may be wrong,  see sms/send/default.aspx
                    response += "<br />" + listItem.Value + a.SendMessage(listItem.Value, tb_message.Text).ToString();
                }
                else
                {
                    //do something else 
                }
            }

            lbl_response.Text = response;
        }
    }
}