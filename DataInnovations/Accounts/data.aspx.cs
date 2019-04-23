using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.Accounts
{
    public partial class data : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "Get_Accounts_Transaction_Items":
                    string transaction_id = Request.QueryString["transaction_id"];

                    html = "<table id=\"tab_allocate\"><thead><tr><th>Area</th><th>Note</th><th style=\"text-align:right\">Amount</th><th><span class=\"edit\">Add</span></th></tr></thead><tbody>";
                    double total = 0;
                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("Get_Accounts_Transaction_Items", con);
                    cmd1.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                string id = dr["Accounts_Transactions_Items_ID"].ToString();
                                string area = dr["area"].ToString();
                                string note = dr["note"].ToString();
                                string amount = dr["amount"].ToString();
                                total += Convert.ToDouble(amount);

                                html += "<tr id=\"tr_" + id + "\"><td>" + area + "</td><td>" + note + "</td><td style=\"text-align:right\">" + Convert.ToDecimal(amount).ToString("0.00") + "</td><td><span class=\"edit\">Edit</span></td></tr>";
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
                    html += "</tbody><tfoot>";
                    html += "<tr><th colspan=\"3\" style=\"text-align:right\">" + Convert.ToDecimal(total).ToString("0.00") + "</th></tr>";
                    html += "</tfoot></table>";

                    break;
            }
        }
    }
}