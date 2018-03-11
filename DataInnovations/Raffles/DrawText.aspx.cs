using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class DrawText : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_send_Click(object sender, EventArgs e)
        {
            string filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            string result = "";

            Boolean live = cb_live.Checked;

            Generic.Functions gFunctions = new Generic.Functions();

            SQLiteConnection m_dbConnection;
            m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
            m_dbConnection.Open();

            LitRows.Text = "";
            string sql = "select number, person, details, emailaddress, mobile, paid, payment, notes, greeting, splitticket, cast(taken as nvarchar(20)) as taken from ticket where raffle_id = '" + dd_raffle.SelectedValue + "' order by [Number]";
            SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
            SQLiteDataReader reader = command.ExecuteReader();

            LitRows.Text += "<table border=\"1\">";
            LitRows.Text += "<tr>";
            LitRows.Text += "<td>Number</td>";
            LitRows.Text += "<td>Person</td>";
            LitRows.Text += "<td>Details</td>";
            LitRows.Text += "<td>Emailaddress</td>";
            LitRows.Text += "<td>Mobile</td>";
            LitRows.Text += "<td>Taken</td>";
            LitRows.Text += "<td>Greeting</td>";
            LitRows.Text += "<td>Result</td>";
            LitRows.Text += "</tr>";

            string mobile = "";
            while (reader.Read())
            {
                result = "";
                Boolean doit = false;
                mobile = reader["mobile"].ToString();
                if (!mobile.StartsWith("02"))
                {
                    result += "Invalid mobile number";
                } else
                {
                    if (tb_onlynumbers.Text != "")
                    {
                        if (tb_onlynumbers.Text.Contains(mobile))
                        {
                            doit = true;
                            result = "Do this one";
                        }
                    }
                    else {
                        doit = true;
                    }
                    if (live && doit)
                    {
                        string message = "Hi " + reader["greeting"] + ", " + tb_message.Text;
                        //result = "GREG";
                        result = gFunctions.SendRemoteMessage(mobile, message);
                    }
                }

                LitRows.Text += "<tr>";
                LitRows.Text += "<td>" + reader["number"] + "</td>";
                LitRows.Text += "<td>" + reader["person"] + "</td>";
                LitRows.Text += "<td>" + reader["details"] + "</td>";
                LitRows.Text += "<td>" + reader["emailaddress"] + "</td>";
                LitRows.Text += "<td>" + mobile + "</td>";
                //LitRows.Text += "<td>" + reader["paid"] + "</td>";
                //LitRows.Text += "<td>" + reader["payment"] + "</td>";
                //LitRows.Text += "<td>" + reader["notes"] + "</td>";
                LitRows.Text += "<td>" + reader["greeting"] + "</td>";
                //LitRows.Text += "<td>" + reader["splitticket"] + "</td>";
                LitRows.Text += "<td>" + reader["taken"] + "</td>";
                LitRows.Text += "<td>" + result + "</td>";

                LitRows.Text += "</tr>";
            }
            LitRows.Text += "</table>";


            m_dbConnection.Close();
            GC.Collect();
        }
    }
}
