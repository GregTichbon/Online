using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Generic;

namespace UBC.People
{
    public partial class data1 : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            SqlConnection con;
            SqlCommand cmd;
            SqlDataReader dr;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "eventpeople":
                    string event_id = Request.QueryString["event_id"];

                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    con = new SqlConnection(strConnString);
                    cmd = new SqlCommand("[get_event_person]", con);
                    cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
                    cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Recorded";

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        dr = cmd.ExecuteReader();
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

                    con = new SqlConnection(strConnString);
                    cmd = new SqlCommand("get_kiwibank_transaction1", con);
                    cmd.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        dr = cmd.ExecuteReader();
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
                            html += "<table id=\"tab_transactions\" class=\"table\">";
                            html += "<thead>";
                            html += "<tr><th>Person</th><th class=\"number\">Amount</th><th>Edit / <span class=\"person_transaction\">Add</span></th>";
                            html += "</thead>";
                            html += "<tbody>";

                            SqlCommand cmd2B = new SqlCommand("get_transaction_person_allocations", con);
                            cmd2B.Parameters.Add("@Source", SqlDbType.VarChar).Value = "Kiwibank1";
                            cmd2B.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                            cmd2B.CommandType = CommandType.StoredProcedure;
                            cmd2B.Connection = con;
                            //try
                            {
                                //con2.Open();
                                dr = cmd2B.ExecuteReader();
                                if (dr.HasRows)
                                {

                                    while (dr.Read())
                                    {
                                        //html += "<tr><td>" + dr["person"].ToString() + "</td><td class=\"number\">" + Convert.ToDouble(dr["amount"]).ToString("0.00") + "</td><td class=\"person_transaction\">Edit</td></tr>";
                                        string person_transaction = "<tr id=\"person_transaction_" + dr["person_transaction_id"].ToString() + "\" system=\"" + dr["system"].ToString() + "\" person_id=\"" + dr["person_id"].ToString() + "\" event_id=\"" + dr["event_id"].ToString() + "\" note=\"" + dr["note"].ToString() + "\"><td>" + dr["code"].ToString() + "</td><td class=\"number\">" + Convert.ToDouble(dr["amount"]).ToString("0.00") + "</td><td class=\"person_transaction\">Edit</td></tr>";
                                        html += person_transaction;
                                    }
                                }
                                dr.Close();
                            }
                            html += "</tbody>";
                            html += "</table>";

                            html += "<hr />";
                            html += "<h2>Other Transactions</h2>";
                            html += "<div id=\"div_othertransactions\">";
                            html += "<table id=\"tab_othertransactions\" class=\"table\">";
                            html += "<thead>";
                            html += "<tr><th>Code</th><th class=\"number\">Amount</th><th>Edit / <span class=\"othertransaction\">Add</span></th>";
                            html += "</thead>";
                            html += "<tbody>";
                            SqlCommand cmd2C = new SqlCommand("get_transaction_other_allocations", con);
                            cmd2C.Parameters.Add("@Source", SqlDbType.VarChar).Value = "Kiwibank1";
                            cmd2C.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                            cmd2C.CommandType = CommandType.StoredProcedure;
                            cmd2C.Connection = con;
                            //try
                            {
                                //con2.Open();
                                dr = cmd2C.ExecuteReader();
                                if (dr.HasRows)
                                {
                                    while (dr.Read())
                                    {
                                        string othertransaction = "<tr id=\"othertransaction_" + dr["othertransactions_id"].ToString() + "\" system=\"" + dr["system"].ToString() + "\" person_id=\"" + dr["person_id"].ToString() + "\" event_id=\"" + dr["event_id"].ToString() + "\" note=\"" + dr["note"].ToString() + "\"><td>" + dr["code"].ToString() + "</td><td class=\"number\">" + Convert.ToDouble(dr["amount"]).ToString("0.00") + "</td><td class=\"othertransaction\">Edit</td></tr>";
                                        html += othertransaction;
                                    }
                                }
                                dr.Close();
                            }
                            html += "</tbody>";
                            html += "</table>";
                            html += "</div>";
                        }
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
                case "eventselector":
                    string date = Request.QueryString["date"];
                    string days = Request.QueryString["days"];

                    html += "<tr><td colspan=\"3\"><b>" + date + "</b></td></tr>";

                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    con = new SqlConnection(strConnString);
                    cmd = new SqlCommand("get_all_events", con);
                    cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = date;
                    cmd.Parameters.Add("@days", SqlDbType.VarChar).Value = days;

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {

                            //html = "<table><thead><tr><th>Date/Time</th><th>Title</th></tr></thead><tbody>";
                            html = "";

                            while (dr.Read())
                            {
                                string event_id2 = dr["event_id"].ToString();
                                string daterange = dr["daterange"].ToString();
                                string title = dr["title"].ToString();
                                string description = dr["description"].ToString();

                                html += "<tr id=\"" + event_id2 + "\"><td>" + daterange + "</td><td>" + title + "</td><td class=\"select\">Select</td></tr>";

                            }
                            //html += "</tbody></table>";
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
                case "get_event_and_attendance":

                    Boolean access = Functions.accessstringtest(Convert.ToString(Session["UBC_AccessString"]), "1011"); 

                    string event_id3 = Request.Form["Event_ID"];
                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_event", con);
                    cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id3;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        string title = dr["title"].ToString();
                        string daterange = dr["daterange"].ToString();
                        string description = dr["description"].ToString();

                        html += "<div id=\"div_head\">" + daterange + " " + title + "</div>";
                        dr.Close();

                        string showphone = "";
                        if (access)
                        {
                            showphone = "<th>Phone</th>";
                        }
                        html += "<table class=\"table\"><thead><tr><th style=\"width:15%\">Person</th><th style=\"width:15%\">Attendance</th><th>Note</th>" + showphone + "<tbody>";

                        cmd1 = new SqlCommand("get_attending", con);
                        cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id3;
                        //cmd1.Parameters.Clear();
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Connection = con;
                        dr = cmd1.ExecuteReader();

                        while (dr.Read())
                        {
                            string person_id = dr["person_id"].ToString();
                            string person_guid = dr["guid"].ToString();
                            string firstname = dr["firstname"].ToString();
                            string name = dr["name"].ToString();
                            string attendance = dr["attendance"].ToString();
                            string phone = dr["phone"].ToString();

                            

                            string personnote = dr["personnote"].ToString();

                            string selectperson = "";
                            showphone = "";
                            if (access)
                            {
                                selectperson = " class=\"selectperson\"";
                                showphone = "<td>";
                                string delim = "";
                                foreach(string eachphone in phone.Split('|'))
                                {
                                    string myphone = eachphone;
                                    string phonenote = "";
                                    int notestartsat = myphone.IndexOf(" (");
                                    if(notestartsat > 1)
                                    {
                                        phonenote =  myphone.Substring(notestartsat);
                                        myphone = myphone.Substring(0, notestartsat);
                                    }
                                    showphone += delim + "<a href=\"tel:" + myphone + "\">" + myphone + "</a>" + phonenote;
                                    delim = "<br />";
                                }
                                showphone += "</td>";
                            }

                            html += "<tr id=\"tr_" + person_guid + "\"><td" + selectperson + ">" + name + "</td><td class=\"attendance\">" + attendance + "</td><td>" + personnote + "</td>" + showphone + "</tr>";
                        }

                        html += "</tbody></table>";
                    }

                    dr.Close();

                    con.Close();
                    con.Dispose();
                    break;
            }
        }
    }
}
 