using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Maadi05mar2018 : System.Web.UI.Page
    {
        public string filename;
        public string raffle;
        public int available = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            raffle = "2";
            int ticketstoarow = 6;
            if (!IsPostBack)
            {
                SQLiteConnection m_dbConnection;
                m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
                m_dbConnection.Open();

                LitRows.Text = "";
                string sql = "select * from ticket where raffle_id = '" + raffle + "' order by [Number]";
                SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
                SQLiteDataReader reader = command.ExecuteReader();
                string person;
                int c = 0;
                string line1 = "";
                string line2 = "";
                string format = "";
                while (reader.Read())
                {
                    c++;
                    //var markup = "<tr><td><textarea name='who-N" + ctr + "' style='width:90%'></textarea></td><td><textarea name='bringing-N" + ctr + "'style='width:90%'></textarea></td></tr>";
                    //LitRows.Text += "<tr><td><textarea name='who-" + reader["attendees_ctr"] + "' style='width:90%'>" + reader["name"] + "</textarea></td><td><textarea name='bringing-" + reader["attendees_ctr"] + "'style='width:90%'>" + reader["bringing"] + "</textarea></td><td>" + reader["updated"] + "<input type='hidden' name='updated-" + reader["attendees_ctr"] + "' value='" + reader["updated"] + "'</td></tr>";
                    person = reader["Person"].ToString();
                    if (person == "")
                    {
                        person = "<input type=\"button\" class=\"iwantthisticket\" value=\"Buy ticket\" id=\"ticket_" + raffle + "-" + reader["number"] + "\"/>";
                        available++;
                    }
                    else
                    {
                        if(reader["Paid"].ToString() == "" )
                        {
                            person = "On hold";
                        } else { 
                            person = "Taken";
                        }
                    }
                    if (c % ticketstoarow == 1)
                    {
                        if (c > 1)
                        {
                            if (c > 11)
                            {
                                LitRows.Text += "<tr><td colspan=\"11\"><hr /></td></tr>";
                            }
                            LitRows.Text += line1 + "</tr>" + line2 + "</tr>";
                            line1 = "";
                            line2 = "";
                        }
                        line1 += "<tr><td>Ticket</td>";
                        line2 += "<tr><td>Status</td>";
                    }
                    format = (c % 2).ToString();
                    line1 += "<td class=\"td" + format + "a\">" + reader["number"] + "</td>";
                    line2 += "<td id=\"td_" + raffle + "-" + reader["number"] + "\" class=\"td" + format + "b\">" + person + "</td>";
                }
                LitRows.Text += "<tr><td colspan=\"11\"><hr /></td></tr>" + line1 + "</tr>" + line2 + "</tr>";

                m_dbConnection.Close();
            }
        }
    }
}