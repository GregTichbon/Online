using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace UBC.People
{
    public partial class data1 : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "eventpeople":
                    string event_id = Request.QueryString["event_id"];

                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("[get_event_person]", con);
                    cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
                    cmd1.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Recorded";

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {

                            html = "<table><thead><tr><th>Name</th><th>Attendance</th><th>Note</th><th>Person's Note</th></tr></thead><tbody>";

                            while (dr.Read())
                            {
                                string name = dr["name"].ToString();
                                string attendance = dr["attendance"].ToString();
                                string note = dr["note"].ToString();
                                string personnote = dr["personnote"].ToString();

                                html += "<tr><td>" + name + "</td><td>" + attendance + "</td><td>" + note + "</td><td>" + personnote + "</td></tr>";

                            }
                            html += "</tbody></table>";
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

                    break;
                case "getkiwibanktransaction1":
                    string transaction_id = Request.QueryString["transaction_id"];

                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con2 = new SqlConnection(strConnString);
                    SqlCommand cmd2 = new SqlCommand("get_kiwibank_transaction1", con2);
                    cmd2.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Connection = con2;
                    try
                    {
                        con2.Open();
                        SqlDataReader dr = cmd2.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            html = "<table class=\"table\"><tbody>";

                            string Kiwibank_Transactions1_ID = dr["Kiwibank_Transactions1_ID"].ToString();
                            string Account_number = dr["Account_number"].ToString();
                            string Date = Convert.ToDateTime(dr["Date"]).ToString("dd MMM yy");
                            string Memo = dr["Memo"].ToString();
                            string Scource = dr["Scource"].ToString();
                            string TPReference = dr["TPReference"].ToString();
                            string TPParticulars = dr["TPParticulars"].ToString();
                            string TPCode = dr["TPCode"].ToString();
                            string OPReference = dr["OPReference"].ToString();
                            string OPParticulars = dr["OPParticulars"].ToString();
                            string OPCode = dr["OPCode"].ToString();
                            string OPName = dr["OPName"].ToString();
                            string OPAccountNumber = dr["OPAccountNumber"].ToString();
                            string Credit = Convert.ToDouble(dr["Credit0"]).ToString("0.00");
                            string Debit = Convert.ToDouble(dr["Debit0"]).ToString("0.00");
                            string Amount = Convert.ToDouble(dr["Amount"] ).ToString("0.00");
                            string Balance = Convert.ToDouble(dr["Balance"]).ToString("0.00");
                            string OurNotes = dr["OurNotes"].ToString();



                            html += "<tr><td>ID</td><td id=\"banktransaction_id\">" + Kiwibank_Transactions1_ID + "</td></tr>";
                            //html += "<tr><td>Account_number</td><td>" + Account_number + "</td></tr>";
                            html += "<tr><td>Date</td><td>" + Date + "</td></tr>";
                            html += "<tr><td>Memo</td><td>" + Memo + "</td></tr>";
                            html += "<tr><td>Scource</td><td>" + Scource + "</td></tr>";
                            html += "<tr><td>TPReference</td><td>" + TPReference + "</td></tr>";
                            html += "<tr><td>TPParticulars</td><td>" + TPParticulars + "</td></tr>";
                            html += "<tr><td>TPCode</td><td>" + TPCode + "</td></tr>";
                            html += "<tr><td>OPReference</td><td>" + OPReference + "</td></tr>";
                            html += "<tr><td>OPParticulars</td><td>" + OPParticulars + "</td></tr>";
                            html += "<tr><td>OPCode</td><td>" + OPCode + "</td></tr>";
                            html += "<tr><td>OPName</td><td>" + OPName + "</td></tr>";
                            html += "<tr><td>OPAccountNumber</td><td>" + OPAccountNumber + "</td></tr>";
                            //html += "<tr><td>Credit</td><td>" + Credit + "</td></tr>";
                            //html += "<tr><td>Debit</td><td>" + Debit + "</td></tr>";
                            html += "<tr><td>Amount</td><td>" + Amount + "</td></tr>";
                            //html += "<tr><td>Balance</td><td>" + Balance + "</td></tr>";
                            html += "<tr><td>Our Notes</td><td><textarea style=\"width:100%\">" + OurNotes + "</textarea><br /><input class=\"btn_updatenote\" id=\"note_" + Kiwibank_Transactions1_ID + "\" type=\"button\" value=\"Update\" /></td></tr>";
                            html += "</tbody></table>";
                            dr.Close();

                            html += "<hr />";
                            html += "<h2>People Transactions</h2>";
                            html += "<table class=\"table\">";
                            html += "<thead>";
                            html += "<tr><th>Person</th><th class=\"number\">Amount</th><th>Edit / <span class=\"persontransaction\">Add</span></th>";
                            html += "</thead>";
                            html += "<tbody>";
                            SqlCommand cmd2B = new SqlCommand("get_transaction_person_allocations", con2);
                            cmd2B.Parameters.Add("@Source", SqlDbType.VarChar).Value = "Kiwibank1";
                            cmd2B.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                            cmd2B.CommandType = CommandType.StoredProcedure;
                            cmd2B.Connection = con2;
                            //try
                            {
                                //con2.Open();
                                dr = cmd2B.ExecuteReader();
                                if (dr.HasRows)
                                {

                                    while (dr.Read())
                                    {
                                        html += "<tr><td>" + dr["person"].ToString() + "</td><td class=\"number\">" + Convert.ToDouble(dr["amount"]).ToString("0.00") + "</td><td class=\"persontransaction\">Edit</td></tr>";
                                    }
                                }
                                dr.Close();
                            }
                            html += "</tbody>";
                            html += "</table>";

                            html += "<hr />";
                            html += "<h2>Other Transactions</h2>";
                            html += "<table class=\"table\">";
                            html += "<thead>";
                            html += "<tr><th>Code</th><th class=\"number\">Amount</th><th>Edit / <span class=\"othertransaction\">Add</span></th>";
                            html += "</thead>";
                            html += "<tbody>";
                            SqlCommand cmd2C = new SqlCommand("get_transaction_other_allocations", con2);
                            cmd2C.Parameters.Add("@Source", SqlDbType.VarChar).Value = "Kiwibank1";
                            cmd2C.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                            cmd2C.CommandType = CommandType.StoredProcedure;
                            cmd2C.Connection = con2;
                            //try
                            {
                                //con2.Open();
                                dr = cmd2C.ExecuteReader();
                                if (dr.HasRows)
                                {
                                    while (dr.Read())
                                    {
                                        html += "<tr><td>" + dr["code"].ToString() + "</td><td class=\"number\">" + Convert.ToDouble(dr["amount"]).ToString("0.00") + "</td><td class=\"othertransaction\">Edit</td></tr>";
                                    }
                                }
                                dr.Close();
                            }
                            html += "</tbody>";
                            html += "</table>";
                        }
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    finally
                    {
                        con2.Close();
                        con2.Dispose();
                    }

                    break;
            }
        }
    }
}
 