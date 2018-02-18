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
        public int available = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            raffle = "1";
            int available = 0;
            if (!IsPostBack)
            {
                SQLiteConnection m_dbConnection;
                m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
                m_dbConnection.Open();

                LitRows.Text = "";
                string sql = "select * from ticket where raffle_id = '" + raffle + "' order by [Number]";
                SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
                SQLiteDataReader reader = command.ExecuteReader();
                
                while (reader.Read())
                {
                    LitRows.Text += "<tr>";
                    LitRows.Text += "<td>" + reader["number"] + "</td>";
                    LitRows.Text += "<td>" + reader["person"] + "</td>";
                    //LitRows.Text += "<td>" + reader["details"] + "</td>";
                    //LitRows.Text += "<td>" + reader["emailaddress"] + "</td>";
                    //LitRows.Text += "<td>" + reader["mobile"] + "</td>";
                    LitRows.Text += "<td>" + reader["paid"] + "</td>";
                    //LitRows.Text += "<td>" + reader["payment"] + "</td>";
                    LitRows.Text += "<td>" + "" + "</td>";
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