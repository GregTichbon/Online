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
    public partial class ControlAll : System.Web.UI.Page
    {
        public string html = "";
        public string head = "";
        public string tabledata;

        protected void Page_Load(object sender, EventArgs e)
        {


            string raffleticket_id = "";
            string identifier = "";
            string ticketnumber = "";
            string purchaser = "";
            string mobile = "";
            string greeting = "";
            string emailaddress = "";
            string notes = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            tabledata = "var tableData = [";
            string delim = "";

            string sql1 = "select T.*, R.Identifier, R.seller from raffleticket T " +
                "inner join raffle R on R.Raffle_ID = T.Raffle_ID " +
                "where R.rafflegroup_id = 1 " +
                "order by R.Identifier, T.TicketNumber";
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
                html += "<th>Identifier</th><th>Ticket</th><th>Purchaser</th><th>Mobile</th><th>Greeting</th><th>Wins</th>";
                html += "</tr></thead><tbody>";

                while (dr.Read())
                {
                    raffleticket_id = dr["raffleticket_id"].ToString();
                    identifier = dr["identifier"].ToString();
                    ticketnumber = dr["ticketnumber"].ToString();
                    purchaser = dr["purchaser"].ToString();
                    mobile = dr["mobile"].ToString();
                    greeting = dr["greeting"].ToString();
                    emailaddress = dr["emailaddress"].ToString();
                    notes = dr["notes"].ToString();

                    html += "<tr>";
                    html += "<td>";
                    html += "</td>";
                    html += "</tr>";

                    tabledata += delim + "{id:" + raffleticket_id;
                    tabledata += ", identifier:\"" + identifier + "\"";
                    tabledata += ", ticketnumber:\"" + ticketnumber + "\"";
                    tabledata += ", purchaser:\"" + purchaser + "\"";
                    tabledata += ", mobile:\"" + mobile + "\"";
                    tabledata += ", greeting:\"" + greeting + "\"";
                    tabledata += ", emailaddress:\"" + emailaddress + "\"";
                    tabledata += ", notes:\"" + notes + "\"";
                    //tabledata += ", ticketnumber:\"" + ticketnumber + "\"";

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
