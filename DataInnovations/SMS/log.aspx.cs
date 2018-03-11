using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS
{
    public partial class log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string days = Request.QueryString["days"] + "";
            if(days == "")
            {
                days = "2";
            }
            string type = Request.QueryString["type"] + "";
            if(type == "")
            {
                type = "B";
            }

            switch (type.ToUpper())
            {
                case "I":
                    type = " and MessageType = 'MESSAGE_TYPE_INBOX'";
                    break;
                case "S":
                    type = " and MessageType = 'MESSAGE_TYPE_SENT'";
                    break;
                default:
                    type = "";
                    break;
            }
        


        


            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            string select = "select m.MessageType, m.datetime, M.message, [dbo].[FormatMobileNumber](M.sender,'') + ' - ' + isnull(Ns.name,'') as [Sender], [dbo].[FormatMobileNumber](M.Receiver,'') + ' - ' + isnull(nr.name,'') as [Receiver] ";
            select += "from message M ";
            select += "left outer join number ns on Ns.number =  [dbo].[FormatMobileNumber](M.sender, '') ";
            select += "left outer join number nr on Nr.number = [dbo].[FormatMobileNumber](M.Receiver, '') ";
            select += "where m.datetime > dateadd(d, -" + days + ", getdate())" + type + " " ;
            select += "order by m.datetime desc";

            SqlCommand cmd = new SqlCommand(select, con);

            cmd.CommandType = CommandType.Text;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    LitRows.Text = "<table>";

                    LitRows.Text += "<tr>";
                    LitRows.Text += "<td>Type</td>";
                    LitRows.Text += "<td>Date/Time</td>";
                    LitRows.Text += "<td>Message</td>";
                    LitRows.Text += "<td>Sender</td>";
                    LitRows.Text += "<td>Receiver</td>";
                    LitRows.Text += "</tr>";

                    while (dr.Read())
                    {
                        LitRows.Text += "<tr>";
                        LitRows.Text += "<td>" + dr["MessageType"] + "</td>";
                        LitRows.Text += "<td>" + dr["datetime"] + "</td>";
                        LitRows.Text += "<td>" + dr["message"] + "</td>";
                        LitRows.Text += "<td>" + dr["sender"] + "</td>";
                        LitRows.Text += "<td>" + dr["receiver"] + "</td>";
                        LitRows.Text += "</tr>";
                    }
                    LitRows.Text += "</table>";

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}