using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Accounts
{
    public partial class Allocate : System.Web.UI.Page
    {

        //public string[] codes = new string[5] { "Personal", "Reimburse", "Company", "Family Trust", "Transfer" };

        public string html_transactions = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            

            string sql1 = "Get_Accounts_Transactions";

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
            html_transactions += "<tr><th>Account</th><th>Date</th><th>Type</th><th>Details</th><th>Particulars</th><th>Code</th><th>Reference</th><th style=\"text-align:right\">Amount</th><th style=\"text-align:right\">Allocated</th></tr>";  
            html_transactions += "</thead>";
            html_transactions += "<tbody>";


            while (dr.Read())
            {
                string account = dr[1].ToString();
                string accountid = "X";
                if(account.EndsWith("-6216"))
                {
                    account = "ANZ - Credit Card - Greg";
                    accountid = "D1";
                }
                else if(account.EndsWith("-8503"))
                {
                    account = "ANZ - Credit Card - Judy";
                    accountid = "D2";
                }
                else if(account == "06-0996-0956968-00")
                {
                    account = "ANZ - General";
                    accountid = "D3";
                }
                else if (account == "06-0583-0966770-00")
                {
                    account = "ANZ - Family Trust";
                    accountid = "D4";
                }
                else if (account == "4367-****-****-7610")
                {
                    account = "ANZ - Credit Card";
                    accountid = "D5";
                }

                string type = dr[2].ToString();
                string particulars = dr[4].ToString();
                string code = dr[5].ToString();
                string reference = dr[6].ToString();
                if (type == "Eft-Pos")
                {
                    if (particulars == "4367********")
                    {
                        if (code.StartsWith("8503"))
                        {
                            particulars = "Card - Judy";
                            code = "";
                            accountid += " J";
                        }
                        else if (code.StartsWith("6216"))
                        {
                            particulars = "Card - Greg";
                            code = "";
                            accountid += " G";
                        }
                    }
                }
                string allocated = " unallocated";
                if(Convert.ToDecimal(dr[7].ToString()) == Convert.ToDecimal(dr[9].ToString())) {
                    allocated = " allocated";
                }

                html_transactions += "<tr class=\"select" + allocated + " " + accountid + "\" id=\"" + dr[0].ToString() + "\">";
                html_transactions += "<td>" + account + "</td>";
                html_transactions += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";  
                html_transactions += "<td>" + type + "</td>";
                html_transactions += "<td>" + dr[3].ToString() + "</td>";

                html_transactions += "<td>" + particulars + "</td>";
                html_transactions += "<td>" + code + "</td>";
                html_transactions += "<td>" + reference + "</td>";

                html_transactions += "<td style=\"text-align:right\">" + Convert.ToDecimal(dr[7].ToString()).ToString("0.00") + "</td>";
                html_transactions += "<td style=\"text-align:right\">" + Convert.ToDecimal(dr[9].ToString()).ToString("0.00") + "</td>";
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