using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.Raffles
{
    public partial class Data : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "Get_Ticket_Wins":
                    string raffleticket_id = Request.QueryString["raffleticket_id"];

                    html = "<table class=\"mytable\" id=\"tab_Wins\"><thead><tr><th>Draw</th><th>Status</th><th>Notes</th><th><span class=\"edit\">Add</span></th></tr></thead><tbody>";
                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("select * from RaffleWinner where RaffleTicket_ID = " + raffleticket_id + " order by draw" , con);
                    //cmd1.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                    cmd1.CommandType = CommandType.Text;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                string id = dr["RaffleWinner_ID"].ToString();
                                string Draw = dr["Draw"].ToString();
                                string Status = dr["Status"].ToString();
                                string Notes = dr["Notes"].ToString();
                                string Response = dr["Response"].ToString();

                                html += "<tr id=\"tr_" + id + "\"><td>" + Draw + "</td><td>" + Status + "</td><td>" + Notes + "</td><td><span class=\"edit\">Edit</span></td></tr>";
                            }
                        }
                        dr.Close();
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                    html += "</tbody></table>";

                    break;
            }
        }
    }
}