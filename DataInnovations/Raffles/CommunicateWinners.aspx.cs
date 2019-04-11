using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class CommunicateWinners : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Generic.Functions gFunctions = new Generic.Functions();

            int c1 = 0;
            
   
            html += "<tr><td colspan=\"7\"><input id=\"cb_toggleall\" type=\"checkbox\" /></td></tr>";
            html += "<tr><td>Ticket</td><td>Purchaser</td><td>Mobile</td><td>Email Address</td><td>Winner Status</td><td>Winner Response</td><td>Winner Note</td></tr>";

            string sql2 = "select R.identifier, T.* from raffleticket T inner join Raffle R on R.Raffle_ID = T.Raffle_ID where isnull(winnerstatus,'') <> '' order by isnull(winnerstatus,''), R.identifier, T.ticketnumber";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql2, con)
            {
                CommandType = CommandType.Text,
                Connection = con
            };
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;

 
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {


                while (dr.Read())
                {
                    string identifier = dr["identifier"].ToString();
                    string id = dr["RaffleTicket_ID"].ToString();
                    string purchaser = dr["Purchaser"].ToString();
                    string mobile = dr["mobile"].ToString();
                    string ticketnumber = dr["ticketnumber"].ToString();
                    string emailaddress = dr["emailaddress"].ToString();
                    string greeting = dr["greeting"].ToString();
                    string guid = dr["guid"].ToString();
                    string winnerstatus = dr["winnerstatus"].ToString();
                    string winnerresponse = dr["winnerresponse"].ToString();
                    string winnernote = dr["winnernote"].ToString();

                    html += "<tr><td><input class=\"checkbox\" id=\"cb_" + id + "\" name=\"cb_" + id + "\" value=\"x\" type=\"checkbox\" /><a href=\"http://office.datainn.co.nz/raffles/ubc2019awinner.aspx?id=" + guid + "\" target=\"order\">" + identifier + " - " + ticketnumber + "</a></td><td>" + purchaser + "</td><td>" + mobile + "</td><td>" + emailaddress + "</td><td>" + winnerstatus + "</td><td>" + winnerresponse + "</td><td>" + winnernote + "</td></tr>";

                    if (IsPostBack)
                    {
                        string val = Request.Form["cb_" + id];
                        if (val == "x")
                        {
                            string textmessage = tb_message.Text;
                            textmessage = textmessage.Replace("||greeting||", greeting);
                            textmessage = textmessage.Replace("||ticketnumber||", ticketnumber);
                            textmessage = textmessage.Replace("||guid||", guid);
                            foreach (string mobilex in mobile.Split(';'))
                            {
                                Response.Write(gFunctions.SendRemoteMessage(mobilex, textmessage, "Raffle Communication") + "<br />");
                                c1++;
                            }
                        }
                    }
                }
            }

            dr.Close();
            con.Close();
            con.Dispose();

            if (IsPostBack)
            {
                Response.Write(c1.ToString() + " messages sent");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}