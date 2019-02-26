using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class UBC2019A : System.Web.UI.Page
    {
        public string filename;
        public string raffle;
        public int available1 = 0;
        public int available2 = 0;
        public string colour;


        protected void Page_Load(object sender, EventArgs e)
        {
            filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";
            int ticketstoarow = 10;
            if (!IsPostBack)
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";


                string purchaser;
                int c;
                string line1;
                string line2;
                string format;


                raffle = Request.QueryString["id"];
                raffle = "5";
                string sql1 = "select * from raffle where raffle_id = " + raffle;

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand(sql1, con);

                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                //try
                //{
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {


                }
                dr.Close();
                LitRows2.Text += "<tr><td colspan=\"" + (ticketstoarow + 1) + "\"><h2>THE " + colour + " RAFFLE</h2></td></tr>";

                c = 0;
                line1 = "";
                line2 = "";
                format = "";

                string sql2 = "select * from raffleticket where raffle_id = " + raffle + " order by [TicketNumber]";

                cmd = new SqlCommand(sql2, con)
                {
                    CommandType = CommandType.Text,
                    Connection = con
                };
                //try
                //{

                dr = cmd.ExecuteReader();
    

                while (dr.Read())
                {
                    c++;

                    purchaser = dr["Purchaser"].ToString();
                    if (purchaser == "")
                    {
                        purchaser = "<input type=\"button\" class=\"iwantthisticket\" value=\"Buy\" id=\"ticket_" + raffle + "-" + dr["ticketnumber"] + "\" />";
                        available2++;
                    }
                    else
                    {
                        if (dr["Paid"].ToString() == "")
                        {
                            purchaser = "On hold";
                        }
                        else
                        {
                            purchaser = "Taken";
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
                    line1 += "<td class=\"td" + format + "a\">" + dr["ticketnumber"] + "</td>";
                    line2 += "<td id=\"td_" + raffle + "-" + dr["ticketnumber"] + "\" class=\"td" + format + "b\">" + purchaser + "</td>";
                }
                LitRows2.Text += "<tr><td colspan=\"11\"><hr /></td></tr>" + line1 + "</tr>" + line2 + "</tr>";
                dr.Close();

                dr.Close();
                con.Close();
                con.Dispose();
            }
        }
    }
}