using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace DataInnovations.Raffles.UBC2019B
{
    public partial class Winners : System.Web.UI.Page
    {
        public string tabledata;

        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            tabledata = "var tableData = [";
            string delim = "";

            string guid = Request.QueryString["id"];

            string sql1 = "select W.RaffleWinner_ID, T.RaffleTicket_ID, W.Draw, W.status, W.Notes, W.Response, W.DrawnDate, W.itiNinjaID, W.GUID, W.voucher, " +
                        "T.TicketNumber, T.Purchaser, T.Greeting, T.Detail, T.EmailAddress, T.mobile, T.Notes, " +
                        "R.seller, R.Identifier " +
                        "from rafflewinner W " +
                        "inner join RaffleTicket T on T.RaffleTicket_ID = W.RaffleTicket_ID " +
                        "inner join Raffle R on R.Raffle_ID = T.Raffle_ID " +
                        "where R.Code = 'UBC2019b' " +
                        "order by R.Identifier, W.Draw, T.TicketNumber";

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
                while (dr.Read())
                {
                    string delim1 = "";
                    tabledata += delim + "{"; // id:" + dr[0].ToString();
                    for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                    {
                        string fldname = dr.GetName(f1).ToString();
                        string fldvalue = dr[f1].ToString();
                        switch (fldname)
                        {
                            case "DrawnDate":
                                fldvalue = Convert.ToDateTime(fldvalue).ToString("dd MMM yyyy");
                                break;
                        }
                       
                        tabledata += delim1 + fldname + ":\"" + fldvalue + "\"";
                        delim1 = ",";
                    }
                    tabledata += "}";
                    delim = ",";
                }
            }
            dr.Close();
            con.Close();
            con.Dispose();
            tabledata += "]";

        }
    }
}
