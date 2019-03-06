using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DataInnovations.Raffles
{
    public partial class Raffles : System.Web.UI.Page
    {
        public string html = "";
        public string tabledata;

        protected void Page_Load(object sender, EventArgs e)
        {
            tabledata = "var tableData = [";
            string delim = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string sql1 = "select * from raffle order by raffle_id desc";

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
                html += "<thead><tr>";
                for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                {
                    html += "<th>";
                    html += dr.GetName(f1).ToString();
                    html += "</th>";
                }
                html += "</tr></thead><tbody>";


                while (dr.Read())
                {
                    html += "<tr>";
                    tabledata += delim + "{id:" + dr[0].ToString();
                    for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                    {
                        html += "<td>";
                        html += dr[f1].ToString();
                        html += "</td>";
                        tabledata += ", " + dr.GetName(f1).ToString() + ":\"" + dr[f1].ToString() + "\"";
                    }
                    html += "</tr>";
                    tabledata += "}";
                    delim = ",";

                }
                html += "</tbody>";

                dr.Close();
                con.Close();
                con.Dispose();
                tabledata += "]";

            }
        }
    }
}
