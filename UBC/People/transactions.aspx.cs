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
    public partial class transactions : System.Web.UI.Page
    {
 
        public string[] transactions_system = new string[2] { "UBC", "Friends" };
        public string[] transactions_code = new string[9] { "Regatta", "Boat Transport", "Accomodation", "Clothing", "Fees", "Race Fees", "Fundraising", "Grant Allocation", "Subsidy" };

        public string html_transactions = "";
        public string person_financial_events;
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
            people = genericfunctions.buildandpopulateselect(strConnString, "select person_id as [value], dbo.get_name(person_id,'') as [Label] from person order by dbo.get_name(person_id,'')", "", functionoptions, "None");

            string personid = Request.QueryString["person"];
            string eventid = Request.QueryString["event"];


            string sql1 = "get_all_transactions";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = personid;
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;



            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            
            html_transactions = "<thead>";
            html_transactions += "<tr><th>Person</th><th>Date</th><th>System</th><th>Code</th><th>Event</th><th>Amount</th><th>Note</th><th>Bank</th><th style=\"width:100px\">Action / <a class=\"transactionsedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
            html_transactions += "</thead>";
            html_transactions += "<tbody>";
            double total = 0;

            while (dr.Read())
            {
                string person_transaction_id = dr["person_transaction_id"].ToString();
                string person_id = dr["person_id"].ToString();
                string person = dr["person"].ToString();
                string date = Convert.ToDateTime(dr["TransactionDate"]).ToString("dd MMM yy");
                string system = dr["system"].ToString();
                string detail = dr["detail"].ToString();
                string amount = Convert.ToDouble(dr["amount"]).ToString("0.00");
                string note = dr["note"].ToString();
                string code = dr["code"].ToString();
                string event_id = dr["event_id"].ToString();
                string event_title = dr["event_title"].ToString();
                string person_event_id = dr["person_event_id"].ToString();
                string kb1transaction_id = dr["Kiwibank_Transactions1_id"].ToString();
                /*
                string banked = dr["banked"].ToString();
                if (kb1transaction_id != "" && banked != "")
                {
                    banked = Convert.ToDateTime(banked).ToString("dd MMM yy");
                }
                */

                total += Convert.ToDouble(amount);


                html_transactions += "<tr id=\"transactions_" + person_transaction_id + "\">";
                html_transactions += "<td person_id=\"" + person_id + "\">" + person + "</td>";
                html_transactions += "<td>" + date + "</td>";
                html_transactions += "<td>" + system + "</td>";
                html_transactions += "<td>" + code + "</td>";
                html_transactions += "<td event_id=\"" + event_id + "\">" + event_title + "</td>";
                html_transactions += "<td>" + amount + "</td>";
                html_transactions += "<td>" + note + "</td>";
                //html_transactions += "<td>" + banked + "</td>";
                if(kb1transaction_id != "") { 
                    html_transactions += "<td class=\"kbtransaction\" id=\"kb1_" + kb1transaction_id + "\">" + kb1transaction_id + "</td>";
                } else
                {
                    html_transactions += "<td>-</td>";
                }
                html_transactions += "<td><a href=\"javascript:void(0)\" class=\"transactionsedit\" data-mode=\"edit\">Edit</td>";
                //html_finance += "<td style=\"text-align:center\">').html(action) 
                //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                html_transactions += "</tr>";


            }
            dr.Close();
            html_transactions += "</tbody>";

            dr.Close();
            con.Close();
            con.Dispose();

        }
    }
}