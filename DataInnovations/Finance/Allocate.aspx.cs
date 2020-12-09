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
    public partial class Allocate : System.Web.UI.Page
    {


        public string html_transactions = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            

            string sql1 = "Get_Finance_Transactions";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html_transactions = "<table>";
            html_transactions += "<thead>";
            html_transactions += "<tr><th>Date</th><th>Dr/Cr</th><th>Type</th><th>Reference</th><th>Name</th><th>Statement</th><th style=\"text-align:right\">Amount</th><th style=\"text-align:right\">Allocated</th></tr>";
            html_transactions += "</thead>";
            html_transactions += "<tbody>";

            //	T.ID, T.DebitCredit, T.type, T.Reference, T.Date, T.Name, T.Entity, T.Type, T.StatementDate, T.StatementPage, T.StatementLine, T.amount, 
            //  E.Name as [EntityName], isnull(Sum(I.amount),0) as [TotalAllocated] 

            while (dr.Read())
            {
                string transaction_CTR = dr["ID"].ToString();
                string DebitCredit = dr["DebitCredit"].ToString();
                string type = dr["type"].ToString();
                string Reference = dr["Reference"].ToString();
                string Date = genericfunctions.formatdate(dr["Date"].ToString(), "dd-MMM-yyyy");
                string Name = dr["Name"].ToString();
                string Entity = dr["Entity"].ToString();
                
                string StatementDate = genericfunctions.formatdate(dr["StatementDate"].ToString(),"dd-MMM-yyyy");
                string StatementPage = dr["StatementPage"].ToString();
                string StatementLine = dr["StatementLine"].ToString();
                string amount = dr["Amount"].ToString();
                string EntityName = dr["entityName"].ToString();
                string TotalAllocated = dr["TotalAllocated"].ToString();

                string allocated = " unallocated";
                if (Convert.ToDecimal(amount) == Convert.ToDecimal(TotalAllocated))
                {
                    allocated = " allocated";
                }

                html_transactions += "<tr class=\"select" + allocated + "\" id=\"" + transaction_CTR + "\">";
                html_transactions += "<td>" + Date + "</td>";
                html_transactions += "<td>" + DebitCredit + "</td>";
                html_transactions += "<td>" + type + "</td>";
                html_transactions += "<td>" + Reference + "</td>";
                html_transactions += "<td>" + Name + "<br />" + EntityName + "</td>";
                html_transactions += "<td>" + StatementDate + "<br />" + StatementPage  + "<br /> " + StatementLine + "</td>";
                html_transactions += "<td style=\"text-align:right\">" + Convert.ToDecimal(amount).ToString("0.00") + "</td>";
                html_transactions += "<td style=\"text-align:right\">" + Convert.ToDecimal(TotalAllocated).ToString("0.00") + "</td>";
                html_transactions += "</tr>";
            }
            dr.Close();
            html_transactions += "</tbody>";
            html_transactions += "</table>";
            dr.Close();
            con.Close();
            con.Dispose();
        }
    }
}