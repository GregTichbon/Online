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
    public partial class BankTransaction : System.Web.UI.Page
    {
        public string Type;
        public string Details;
        public string Particulars;
        public string Code;
        public string Reference;
        public string Amount;
        public string Date;

        public string TotalAllocated;
        public string transactions;
        public string items;

        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();

            using (SqlConnection con = new SqlConnection(strConnString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("Get_Finance_Bank_Transactions", con))
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Finance_Bank_id", SqlDbType.VarChar).Value = id;

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        html = "<table class=\"table\"><thead><tr><th>Date</th><th>Type</th><th>Details</th><th>Particulars</th><th>Code</th><th>Reference</th><th style=\"text-align: right\">Amount</th><th style=\"text-align: right\">Allocated</th><th>Count</th></tr></thead><tbody>";

                        dr.Read();
                        Type = dr[1].ToString();
                        Details = dr[2].ToString();
                        Particulars = dr[3].ToString();
                        Code = dr[4].ToString();
                        Reference = dr[5].ToString();
                        Amount = dr[6].ToString();
                        Date = genericfunctions.formatdate(dr[7].ToString(), "dd MMM yyyy");

                        TotalAllocated = dr[8].ToString();
                        transactions = dr[9].ToString();
                        items = dr[10].ToString();

                        html += "<tr class=\"select" + "\" id=\"" + id + "\">";
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

                        html += "</tbody></table>";
                    }
                    dr.Close();
                }

                html += "<table class=\"table\"><thead><tr><th>Reference</th><th>Type</th><th>Name</th><th style=\"text-align: right\">Amount</th><th style=\"text-align: right\">Allocated</th><th>Count</th><th>Add</th></tr></thead><tbody>";


                using (SqlCommand cmd = new SqlCommand("Get_Finance_Transactions", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Finance_Bank_Transaction_id", SqlDbType.VarChar).Value = id;
                    SqlDataReader dr = cmd.ExecuteReader();
                    /*ID	DebitCredit	type	Reference	Date	Name	Entity	StatementDate	StatementPage	StatementLine	Amount	EntityName	TotalAllocated*/
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            string t_id = dr["ID"].ToString();
                            string t_DebitCredit = dr["DebitCredit"].ToString();
                            string t_type = dr["type"].ToString();
                            string t_Reference = dr["Reference"].ToString();
                            string t_Date = genericfunctions.formatdate(dr["Date"].ToString(), "dd MMM yyyy");
                            //string t_Name = dr["Name"].ToString();
                            string t_Entity = dr["Entity"].ToString();
                            string t_amount = dr["Amount"].ToString();
                            string t_entityname = dr["EntityName"].ToString();
                            string t_totalallocated = dr["TotalAllocated"].ToString();
                            string itemcount = dr["itemcount"].ToString();
                            /*
                            if(t_entityname != "")
                            {
                                t_Name = t_entityname;
                                if(t_entityname != )
                                {
                                    +"<br />(" + t_Name + ")";
                                }
                            }
                            */
                            html += "<tr class=\"select" + "\" id=\"" + t_id + "\">";
                            html += "<td>" + t_Reference + "</td>";
                            html += "<td>" + Type + "</td>";
                            html += "<td>" + t_entityname + "</td>";
                            html += "<td style=\"text-align:right\">" + Convert.ToDecimal(t_amount).ToString("0.00") + "</td>";
                            html += "<td style=\"text-align:right\">" + Convert.ToDecimal(t_totalallocated).ToString("0.00") + "</td>";
                            html += "<td>" + itemcount + "</td>";
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