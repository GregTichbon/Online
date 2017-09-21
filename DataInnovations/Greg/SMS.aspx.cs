using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Greg
{
    public partial class SMS : System.Web.UI.Page
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