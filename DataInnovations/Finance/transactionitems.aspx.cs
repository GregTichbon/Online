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
    public partial class transactionitems : System.Web.UI.Page
    {


        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();

            using (SqlConnection con = new SqlConnection(strConnString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("Get_Finance_Items", con))
                {
                    html += "<table class=\"table\"><thead><tr><th>Description</th><th>Type</th><th>Invoice</th><th style=\"text-align: right\">Amount</th><th style=\"text-align: right\">GST</th><th>Add</th></tr></thead><tbody>";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Finance_Transaction_id", SqlDbType.VarChar).Value = id;
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            string t_id = dr["ID"].ToString();
                            string t_description = dr["description"].ToString();
                            string t_amount = dr["Amount"].ToString();
                            string t_GST = dr["GST"].ToString();
                            string t_InvoiceItemID = dr["Invoice"].ToString();
                            string t_type = dr["type"].ToString();
                            string t_invoiceid = dr["Invoiceid"].ToString();
                            
                            html += "<tr class=\"select" + "\" id=\"" + t_id + "\">";
                            html += "<td>" + t_description + "</td>";
                            html += "<td>" + t_type + "</td>";
                            html += "<td>" + t_InvoiceItemID + "</td>";
                            html += "<td style=\"text-align:right\">" + Convert.ToDecimal(t_amount).ToString("0.00") + "</td>";
                            html += "<td style=\"text-align:right\">" + Convert.ToDecimal(t_GST).ToString("0.00") + "</td>";
                            html += "</tr>";
                        }
                    }
                    dr.Close();
                }
                html += "</tbody></table>";

            }

        }
    }
}