using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Maadi08Mar2018 : System.Web.UI.Page
    {
        public string filename;
        public string raffle;
        public int available1 = 0;
        public int available2 = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            int ticketstoarow = 10;
            if (!IsPostBack)
            {
                SQLiteConnection m_dbConnection;
                m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
                m_dbConnection.Open();

                LitRows1.Text = "";
                string person;
                int c;
                string line1;
                string line2;
                string format;

                if (1 == 2)
                {
                    raffle = "3";
                    string sql1 = "select * from ticket where raffle_id = " + raffle + " order by [Number]";
                    SQLiteCommand command1 = new SQLiteCommand(sql1, m_dbConnection);
                    SQLiteDataReader reader1 = command1.ExecuteReader();
                    c = 0;
                    line1 = "";
                    line2 = "";
                    format = "";

                    LitRows1.Text += "<tr><td colspan=\"" + ticketstoarow + 1 + "\"><h2>THE RED RAFFLE</h2></td></tr>";

                    while (reader1.Read())
                    {
                        c++;
                        //var markup = "<tr><td><textarea name='who-N" + ctr + "' style='width:90%'></textarea></td><td><textarea name='bringing-N" + ctr + "'style='width:90%'></textarea></td></tr>";
                        //LitRows.Text += "<tr><td><textarea name='who-" + reader["attendees_ctr"] + "' style='width:90%'>" + reader["name"] + "</textarea></td><td><textarea name='bringing-" + reader["attendees_ctr"] + "'style='width:90%'>" + reader["bringing"] + "</textarea></td><td>" + reader["updated"] + "<input type='hidden' name='updated-" + reader["attendees_ctr"] + "' value='" + reader["updated"] + "'</td></tr>";

                        person = reader1["Person"].ToString();
                        if (person == "")
                        {
                            person = "<input type=\"button\" class=\"iwantthisticket\" value=\"Buy ticket\" id=\"ticket_" + raffle + "-" + reader1["number"] + "\" />";
                            available1++;
                        }
                        else
                        {
                            if (reader1["Paid"].ToString() == "")
                            {
                                person = "On hold";
                            }
                            else
                            {
                                person = "Taken";
                            }
                        }
                        if (c % ticketstoarow == 1)
                        {
                            if (c > 1)
                            {
                                if (c > ticketstoarow + 1)
                                {
                                    LitRows1.Text += "<tr><td colspan=\"" + ticketstoarow + 1 + "\"><hr /></td></tr>";
                                }
                                LitRows1.Text += line1 + "</tr>" + line2 + "</tr>";
                                line1 = "";
                                line2 = "";
                            }
                            line1 += "<tr><td>Ticket</td>";
                            line2 += "<tr><td>Status</td>";
                        }
                        format = (c % 2).ToString();
                        line1 += "<td class=\"td" + format + "a\">" + reader1["number"] + "</td>";
                        line2 += "<td id=\"td_" + raffle + "-" + reader1["number"] + "\" class=\"td" + format + "b\">" + person + "</td>";
                    }
                    LitRows1.Text += "<tr><td colspan=\"11\"><hr /></td></tr>" + line1 + "</tr>" + line2 + "</tr>";
                }
                if (1 == 1)
                {

                    raffle = "4";
                    string sql2 = "select * from ticket where raffle_id = " + raffle + " order by [Number]";
                    SQLiteCommand command2 = new SQLiteCommand(sql2, m_dbConnection);
                    SQLiteDataReader reader2 = command2.ExecuteReader();
                    c = 0;
                    line1 = "";
                    line2 = "";
                    format = "";

                    LitRows2.Text += "<tr><td colspan=\"" + ticketstoarow + 1 + "\"><h2>THE WHITE RAFFLE</h2></td></tr>";

                    while (reader2.Read())
                    {
                        c++;
                        //var markup = "<tr><td><textarea name='who-N" + ctr + "' style='width:90%'></textarea></td><td><textarea name='bringing-N" + ctr + "'style='width:90%'></textarea></td></tr>";
                        //LitRows.Text += "<tr><td><textarea name='who-" + reader["attendees_ctr"] + "' style='width:90%'>" + reader["name"] + "</textarea></td><td><textarea name='bringing-" + reader["attendees_ctr"] + "'style='width:90%'>" + reader["bringing"] + "</textarea></td><td>" + reader["updated"] + "<input type='hidden' name='updated-" + reader["attendees_ctr"] + "' value='" + reader["updated"] + "'</td></tr>";

                        person = reader2["Person"].ToString();
                        if (person == "")
                        {
                            person = "<input type=\"button\" class=\"iwantthisticket\" value=\"Buy ticket\" id=\"ticket_" + raffle + "-" + reader2["number"] + "\" />";
                            available2++;
                        }
                        else
                        {
                            if (reader2["Paid"].ToString() == "")
                            {
                                person = "On hold";
                            }
                            else
                            {
                                person = "Taken";
                            }
                        }
                        if (c % ticketstoarow == 1)
                        {
                            if (c > 1)
                            {
                                if (c > ticketstoarow + 1)
                                {
                                    LitRows2.Text += "<tr><td colspan=\"" + ticketstoarow + 1 + "\"><hr /></td></tr>";
                                }
                                LitRows2.Text += line1 + "</tr>" + line2 + "</tr>";
                                line1 = "";
                                line2 = "";
                            }
                            line1 += "<tr><td>Ticket</td>";
                            line2 += "<tr><td>Status</td>";
                        }
                        format = (c % 2).ToString();
                        line1 += "<td class=\"td" + format + "a\">" + reader2["number"] + "</td>";
                        line2 += "<td id=\"td_" + raffle + "-" + reader2["number"] + "\" class=\"td" + format + "b\">" + person + "</td>";
                    }
                    LitRows2.Text += "<tr><td colspan=\"11\"><hr /></td></tr>" + line1 + "</tr>" + line2 + "</tr>";
                }

                m_dbConnection.Close();
            }
        }
    }
}