using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DataInnovations.Finance
{
    public partial class BankTransactions : System.Web.UI.Page
    {


        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            string sql = "Get_Finance_Bank_Transactions";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                string id = dr[0].ToString();
                string Type = dr[1].ToString();
                string Details = dr[2].ToString();
                string Particulars = dr[3].ToString();
                string Code = dr[4].ToString();
                string Reference = dr[5].ToString();
                string Amount = dr[6].ToString();
                string Date = genericfunctions.formatdate(dr[7].ToString(), "dd MMM yyyy");

                string TotalAllocated = dr[8].ToString();
                string transactions = dr[9].ToString();
                string items = dr[10].ToString();

                string allocated = " unallocated";
                if (Convert.ToDecimal(dr[6].ToString()) == Convert.ToDecimal(dr[8].ToString()))
                {
                    allocated = " allocated";
                }

                html += "<tr class=\"select" + allocated + "\" id=\"" + id + "\">";
                html += "<td>" + Date + "</td>";
                html += "<td>" + Type + "</td>";
                html += "<td>" + Details + "</td>";
                html += "<td>" + Particulars + "</td>";
                html += "<td>" + Code + "</td>";
                html += "<td>" + Reference + "</td>";
                html += "<td style=\"text-align:right\">" + Convert.ToDecimal(Amount).ToString("0.00") + "</td>";
                html += "<td style=\"text-align:right\">" + Convert.ToDecimal(TotalAllocated).ToString("0.00") + "</td>";
                html += "<td>" + transactions + "/" + items + "</td>";
                html += "</tr>";
            }
            dr.Close();
            con.Close();
            con.Dispose();
        }
    }
}