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
    public partial class Communicate : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Generic.Functions gFunctions = new Generic.Functions();

            int firstticket = 1;
            int lastticket = 50;
            string raffle = "";

            string identifier = "";
            string bankaccount = "";
            string rafflename;
            string detail = "";

            int c1 = 0;

            string guid = Request.QueryString["id"];

            string sql1 = "select * from raffle where guid = '" + guid + "'";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                raffle = dr["raffle_id"].ToString();
                identifier = dr["identifier"].ToString();
                firstticket = Convert.ToInt16(dr["firstticket"]);
                lastticket = Convert.ToInt16(dr["lastticket"]);
                bankaccount = dr["bankaccount"].ToString();
                rafflename = dr["name"].ToString();
                detail = dr["detail"].ToString();

            }
            dr.Close();
            html += "<tr><td><h2>THE " + identifier + " RAFFLE</h2></td></tr>";

            string sql2 = "select * from raffleticket where raffle_id = " + raffle + " and ticketnumber between " + firstticket + " and " + lastticket + " order by [TicketNumber]";

            cmd = new SqlCommand(sql2, con)
            {
                CommandType = CommandType.Text,
                Connection = con
            };
            //try
            //{

            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                string purchaser = dr["Purchaser"].ToString();
                string mobile = dr["mobile"].ToString();
                string ticketnumber = dr["ticketnumber"].ToString();
                string emailaddress = dr["emailaddress"].ToString();
                string greeting = dr["greeting"].ToString();

                html += "<tr><td>" + ticketnumber + "</td><td>" + purchaser + "</td><td>" + mobile + "</td><td>" + emailaddress + "</td></tr>";

                if (IsPostBack)
                {
                    string textmessage = tb_message.Text;
                    textmessage = textmessage.Replace("||greeting||", greeting);
                    textmessage = textmessage.Replace("||ticketnumber||", ticketnumber);
                    foreach (string mobilex in mobile.Split(';'))
                    {
                        Response.Write( gFunctions.SendRemoteMessage(mobilex, textmessage, "Raffle Communication") + "<br />");
                        c1++;
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