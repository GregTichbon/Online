using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class SMSLog : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                //string url = "../reports/smslog.aspx";
                //Response.Redirect("~/people/security/login.aspx?return=" + url);
				Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }
            string days = Request.QueryString["days"] + "";
            if (days == "")
            {
                days = "2";
            }
            string type = Request.QueryString["type"] + "";
            if (type == "")
            {
                type = "B";
            }

            switch (type.ToUpper())
            {
                case "R":
                    type = " and L.Direction = 'Received'";
                    break;
                case "S":
                    type = " and L.MessageType = 'Sent'";
                    break;
                default:
                    type = "";
                    break;
            }

            
           string     description = " and description like '%UBC%'";
        

            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            string sql = "select L.*, N.Name, N.source from smslog L";
            sql += " left outer join number N on dbo.FormatMobileNumber(N.Number,'') = dbo.FormatMobileNumber(L.PhoneNumber,'')";
            sql += " where L.datetime > dateadd(d, -" + days + ", getdate())" + type + " " + description;
            sql += " order by L.Datetime";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.CommandType = CommandType.Text;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string name = "";
                    if (dr["Name"].ToString() != "")
                    {
                        name = "<br />" + dr["Name"].ToString();
                    }
                    html += "<tr class=\"select\">";
                    html += "<td>" + dr["smsLog_ID"] + "</td>";
                    html += "<td>" + dr["ID"] + "</td>";
                    html += "<td>" + dr["DateTime"] + "</td>";
                    html += "<td>" + dr["Direction"] + "</td>";
                    html += "<td><span class=\"phone\">" + dr["PhoneNumber"] + "</span>" + name + "</td>";
                    html += "<td>" + dr["Message"] + "</td>";
                    html += "<td>" + dr["Description"] + "</td>";
                    html += "<td>" + dr["Response"] + "</td>";
                    html += "<td>" + dr["Resend_ID"] + "</td>";
                    html += "<td>" + dr["ResendOF_ID"] + "</td>";
                    html += "</tr>";
                }
                html += "</table>";

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

            #region oldCode
            /*
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
            select += "left outer join number ns on [dbo].[FormatMobileNumber](Ns.number,'') =  [dbo].[FormatMobileNumber](M.sender, '') ";
            select += "left outer join number nr on [dbo].[FormatMobileNumber](Nr.number,'') = [dbo].[FormatMobileNumber](M.Receiver, '') ";
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
                    html = "<table>";

                    html += "<tr>";
                    html += "<td>Type</td>";
                    html += "<td>Date/Time</td>";
                    html += "<td>Message</td>";
                    html += "<td>Sender</td>";
                    html += "<td>Receiver</td>";
                    html += "</tr>";

                    while (dr.Read())
                    {
                        html += "<tr>";
                        html += "<td>" + dr["MessageType"] + "</td>";
                        html += "<td>" + dr["datetime"] + "</td>";
                        html += "<td>" + dr["message"] + "</td>";
                        html += "<td>" + dr["sender"] + "</td>";
                        html += "<td>" + dr["receiver"] + "</td>";
                        html += "</tr>";
                    }
                    html += "</table>";
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
            */
            #endregion
        }
    }
}