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
    public partial class Control : System.Web.UI.Page
    {
        public string html = "";
        public string tabledata;

        protected void Page_Load(object sender, EventArgs e)
        {

            int firstticket = 1;
            int lastticket = 50;
            string raffle = "";

            string identifier = "";
            string bankaccount = "";
            string rafflename = "";
            string detail = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string val;
            tabledata = "var tableData = [";
            string delim = "";

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
            html += "<tr><td><h2>" + rafflename + "</h2></td></tr>";
           

            string sql2 = "select * from raffleticket where raffle_id = " + raffle + " order by ticketnumber ";
            cmd = new SqlCommand(sql2, con)
            {
                CommandType = CommandType.Text,
                Connection = con
            };

            //con.Open();
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                html += "<thead><tr>";
                for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                {
                    html += "<th>";
                    val = dr.GetName(f1).ToString();
                    html += val;
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
                        val = dr[f1].ToString();
                        html += val;
                        html += "</td>";

                        tabledata += ", " + dr.GetName(f1).ToString() + ":\"" + dr[f1].ToString() + "\"";
                    }
                    html += "</tr>";
                    tabledata += "}";
                    delim = ",";

                    /*var tableData = [
    {id:1, name:"Billy Bob", age:"12", gender:"male", height:1, col:"red", dob:"", cheese:1},
    {id:2, name:"Mary May", age:"1", gender:"female", height:2, col:"blue", dob:"14/05/1982", cheese:true},
]*/

                }
                html += "</tbody>";
            }
            dr.Close();
            con.Close();
            con.Dispose();
            tabledata += "]";

        }
    }
}
 