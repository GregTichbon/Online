using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Details : System.Web.UI.Page
    {
        public string filename;
        public string raffle;
        public string mode;
        public int available = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            raffle = Request.QueryString["raffle"] + "";
            mode = Request.QueryString["mode"] + "";
            int available = 0;
            string head = "";

            switch (raffle)
            {
                case "1":
                    head = "Pale Yellow Meat Raffle";
                    break;
                case "2":
                    head = "Outdoor Table Raffle";
                    break;
                case "3":
                    head = "Red Meat Raffle";
                    break;
                case "4":
                    head = "White Meat Raffle";
                    break;
                default:
                    Console.WriteLine("Default case");
                    break;
            }
            LitRows.Text = "<h2>" + head + "</h2>";

            if (!IsPostBack)
            {
                SQLiteConnection m_dbConnection;
                m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
                m_dbConnection.Open();

                //LitRows.Text = "";
                string sql = "select number, person, details, emailaddress, mobile, paid, payment, notes, greeting, splitticket, cast(taken as nvarchar(20)) as taken from ticket where raffle_id = '" + raffle + "' order by [Number]";
                SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
                SQLiteDataReader reader = command.ExecuteReader();

                LitRows.Text += "<tr>";
                LitRows.Text += "<td>Number</td>";
                LitRows.Text += "<td>Person</td>";
                if (mode != "")
                {
                    LitRows.Text += "<td>Details</td>";
                    LitRows.Text += "<td>Emailaddress</td>";
                }
                LitRows.Text += "<td>Mobile</td>";
                if (mode != "")
                {
                    LitRows.Text += "<td>Paid</td>";
                    LitRows.Text += "<td>Payment</td>";
                    LitRows.Text += "<td>Notes</td>";
                    LitRows.Text += "<td>Greeting</td>";
                    LitRows.Text += "<td>Split ticket</td>";
                }
                LitRows.Text += "<td>Taken</td>";
                LitRows.Text += "</tr>";



                while (reader.Read())
                {
                    LitRows.Text += "<tr>";
                    LitRows.Text += "<td>" + reader["number"] + "</td>";
                    LitRows.Text += "<td>" + reader["person"] + "</td>";
                    if (mode != "") { 
                        LitRows.Text += "<td>" + reader["details"] + "</td>";
                        LitRows.Text += "<td>" + reader["emailaddress"] + "</td>";
                    }
                    LitRows.Text += "<td>" + reader["mobile"] + "</td>";
                    if (mode != "")
                    {
                        LitRows.Text += "<td>" + reader["paid"] + "</td>";
                        LitRows.Text += "<td>" + reader["payment"] + "</td>";
                        LitRows.Text += "<td>" + reader["notes"] + "</td>";
                        LitRows.Text += "<td>" + reader["greeting"] + "</td>";
                        LitRows.Text += "<td>" + reader["splitticket"] + "</td>";
                    }
                    LitRows.Text += "<td>" + reader["taken"] + "</td>";
                    LitRows.Text += "</tr>";

                    if(reader["Person"].ToString() == "")
                    {
                        available ++;
                    }
                }
                LitAvailable.Text = available.ToString() + " Available";

                m_dbConnection.Close();
                GC.Collect();




            }
        }
    }
}