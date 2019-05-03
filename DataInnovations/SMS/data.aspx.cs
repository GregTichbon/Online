using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.SMS
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
                case "xxxx":
                    string xxxx_ID = Request.QueryString["xxxx_ID"];

                    html = "<table id=\"tab_allocate\"><thead><tr><th>Area</th><th>Note</th><th style=\"text-align:right\">Amount</th><th><span class=\"edit\">Add</span></th></tr></thead><tbody>";
                    strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    string sql = "Select * from smslog where smslog_id = " + xxxx_ID;
                    SqlCommand cmd1 = new SqlCommand(sql, con);
                    //cmd1.Parameters.Add("@SMSLog_ID", SqlDbType.VarChar).Value = SMSLog_ID;

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
                                string id = dr["Accounts_Transactions_Items_ID"].ToString();
                                string area = dr["area"].ToString();
                                string note = dr["note"].ToString();
                                string amount = dr["amount"].ToString();

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
                    html += "<tr><th colspan=\"3\" style=\"text-align:right\">" + "xxxx" + "</th></tr>";
                    html += "</tfoot></table>";

                    break;
            }
        }
    }
}