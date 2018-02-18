using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Maadi01Feb2018 : System.Web.UI.Page
    {
        public string filename;
        public string raffle;
        public int available = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            raffle = "1";
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
                        person = "<input type=\"button\" class=\"iwantthisticket\" value=\"Buy ticket\" id=\"ticket_" + reader["number"] + "\"/>";
                        available++;
                    }
                    else
                    {
                        person = "Taken";
                    }
                    if(c % 10 == 1)
                    {
                        if(c > 1)
                        {
                            if(c > 11)
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
                    line2 += "<td id=\"td_" + reader["number"] + "\" class=\"td" + format + "b\">" + person + "</td>";
                }
                LitRows.Text += "<tr><td colspan=\"11\"><hr /></td></tr>" + line1 + "</tr>" + line2 + "</tr>";

                m_dbConnection.Close();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            //SQLiteConnection m_dbConnection;
            //m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
            //m_dbConnection.Open();
            //lit_debug.Text = filename;
            //return;
            using (SQLiteConnection m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;"))
            {
                m_dbConnection.Open();
                foreach (string key in Request.Form.Keys)
                {
                    string keyname = key.Substring(0, 4);

                    if (keyname == "who-")
                    {
                        string ctr = key.Substring(4);
                        string name = Request.Form["who-" + ctr];
                        string bringing = Request.Form["bringing-" + ctr];
                        string updated = Request.Form["updated-" + ctr];

                        string sql = "";
                        if (ctr.Substring(0, 1) == "N")
                        {
                            sql = "insert into attendees (name, bringing,updated) values ('" + name + "', '" + bringing + "', '" + DateTime.Now.ToString() + "')";
                        }
                        else
                        {
                            sql = "select updated from attendees where attendees_ctr = " + ctr;
                            //SQLiteCommand command1 = new SQLiteCommand(sql, m_dbConnection);
                            //SQLiteDataReader reader = command1.ExecuteReader();
                            using (SQLiteCommand command1 = new SQLiteCommand(sql, m_dbConnection))
                            {
                                using (SQLiteDataReader reader = command1.ExecuteReader())
                                {
                                    reader.Read();
                                    if (reader["updated"].ToString() != updated)
                                    {
                                        sql = "insert into attendees (name, bringing, updated) values ('ORIGINAL RECORD CHANGED: " + name + "', '" + bringing + "', '" + DateTime.Now.ToString() + "')";
                                    }
                                    else
                                    {
                                        sql = "update attendees set name = '" + name + "', bringing = '" + bringing + "', updated = '" + DateTime.Now.ToString() + "' where attendees_ctr = " + ctr;
                                    }
                                }
                                using (SQLiteCommand command2 = new SQLiteCommand(sql, m_dbConnection))
                                {
                                    command2.ExecuteNonQuery();
                                    //SQLiteCommand command2 = new SQLiteCommand(sql, m_dbConnection);
                                    //command2 = new SQLiteCommand(sql, m_dbConnection);
                                    //command2.ExecuteNonQuery();
                                }
                            }
                            //m_dbConnection.Close();
                        }
                    }
                }
            }
            //lit_debug.Text += "<br />" + Request.RawUrl;
            //lit_debug.Text += "<br />" + Request.Url;
            //lit_debug.Text += "<br />" + Request.
            //Response.Redirect(Request.RawUrl);
            Response.Redirect(".");
        }
    }
}