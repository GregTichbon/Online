using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC.People
{
    public partial class BankAllocate : System.Web.UI.Page
    {

        public string[] transactions_system = new string[2] { "UBC", "Friends" };
        public string[] transactions_code = new string[9] { "Regatta", "Boat Transport", "Accomodation", "Clothing", "Fees", "Race Fees", "Fundraising", "Grant Allocation", "Subsidy" };

        public string html_transactions = "";
        //public string person_financial_events;
        public string people;

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            Functions genericfunctions = new Functions();
            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
            functionoptions.Clear();
            //functionoptions.Add("storedprocedure", "");
            //functionoptions.Add("storedprocedurename", "");
            functionoptions.Add("usevalues", "");
            //people = genericfunctions.buildandpopulateselect(strConnString, "select person_id as [value], dbo.get_name(person_id,'') as [Label] from person order by dbo.get_name(person_id,'')", "", functionoptions, "None");
            people = Functions.buildandpopulateselect(strConnString, "select person_id as [value], dbo.get_name(person_id,'') as [Label] from person order by dbo.get_name(person_id,'')", "", functionoptions, "None");


            string sql1 = "get_bank_transactions";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            html_transactions = "<thead>";
            html_transactions += "<tr><th style=\"width:100px\">View</th><th>Date</th><th>Memo</th><th style=\"text-align:right\">Transaction Amount</th><th style=\"text-align:right\">Person Allocation</th><th style=\"text-align:right\">Other Allocation</th></tr>";
            html_transactions += "</thead>";
            html_transactions += "<tbody>";

            string Last_Kiwibank_Transactions1_ID = "";


            while (dr.Read())
            {
                string Kiwibank_Transactions1_ID = dr["Kiwibank_Transactions1_ID"].ToString();
                string Date = Convert.ToDateTime(dr["Date"]).ToString("dd MMM yy");
                string Memo = dr["Memo"].ToString();
                string BankAmount = Convert.ToDouble(dr["BankAmount"]).ToString("0.00");
                string PersonTotal = Convert.ToDouble(dr["PersonTotal"]).ToString("0.00");
                string OtherTotal = Convert.ToDouble(dr["OtherTotal"]).ToString("0.00");

                string class_allocated = "";
                if(Convert.ToDouble(dr["BankAmount"]) == Convert.ToDouble(dr["PersonTotal"]) + Convert.ToDouble(dr["OtherTotal"]))
                {
                    class_allocated = " class=\"allocated\"";
                }
                html_transactions += "<tr" + class_allocated + " id=\"transactions_" + Kiwibank_Transactions1_ID + "\">";

                if (Kiwibank_Transactions1_ID != Last_Kiwibank_Transactions1_ID || Last_Kiwibank_Transactions1_ID == "")

                {
                    html_transactions += "<td><a href=\"javascript:void(0)\" class=\"transactionsview\" data-mode=\"view\">View</td>";
                    html_transactions += "<td nowrap>" + Date + "</td>";
                    html_transactions += "<td>" + Memo + "</td>";
                    html_transactions += "<td style=\"text-align:right\">" + BankAmount + "</td>";
                } else
                {
                    html_transactions += "<td colspan=\"4\"></td>";
                }

                html_transactions += "<td style=\"text-align:right\">" + PersonTotal + "</td>";
                html_transactions += "<td style=\"text-align:right\">" + OtherTotal + "</td>";

   
                //html_finance += "<td style=\"text-align:center\">').html(action) 
                //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                html_transactions += "</tr>";

                Last_Kiwibank_Transactions1_ID = Kiwibank_Transactions1_ID;


            }
            dr.Close();
            html_transactions += "</tbody>";

            dr.Close();
            con.Close();
            con.Dispose();

        }
    }
}