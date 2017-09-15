using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.BBQ
{
    public partial class _default : System.Web.UI.Page
    {
        public string filename;
        protected void Page_Load(object sender, EventArgs e)
        {
            filename = HttpContext.Current.Server.MapPath(".") + "\\BBQ.sqlite";
            if (!IsPostBack)
            {
                SQLiteConnection m_dbConnection;
                m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
                m_dbConnection.Open();

                LitRows.Text = "";
                string sql = "select * from attendees";
                SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
                SQLiteDataReader reader = command.ExecuteReader();
                while (reader.Read())
                    //                var markup = "<tr><td><textarea name='who-N" + ctr + "' style='width:90%'></textarea></td><td><textarea name='bringing-N" + ctr + "'style='width:90%'></textarea></td></tr>";
                    LitRows.Text += "<tr><td><textarea name='who-" + reader["attendees_ctr"] + "' style='width:90%'>" + reader["name"] + "</textarea></td><td><textarea name='bringing-" + reader["attendees_ctr"] + "'style='width:90%'>" + reader["bringing"] + "</textarea></td><td>" + reader["updated"] + "<input type='hidden' name='updated-" + reader["attendees_ctr"] + "' value='" + reader["updated"] + "'</td></tr>";
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