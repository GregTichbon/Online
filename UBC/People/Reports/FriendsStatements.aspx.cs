using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class FriendsStatements : System.Web.UI.Page
    {

        string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string emailBCC = "greg@datainn.co.nz";
            string host = "70.35.207.87";
            string emailfrom = "UnionBoatClub@datainn.co.nz";
            string emailfromname = "Union Boat Club";
            string password = "39%3Zxon";
            Generic.Functions gFunctions = new Generic.Functions();
            ReportDocument rpt = new ReportDocument();
            DataSet ds = new DataSet();

            if (IsPostBack)
            {
                string report;

                emailBCC = "greg@datainn.co.nz";
                host = "70.35.207.87";
                emailfrom = "UnionBoatClub@datainn.co.nz";
                emailfromname = "Union Boat Club";
                password = "39%3Zxon";

                report = Server.MapPath("~/people/reports/crystal/FriendsStatements.rpt");
                rpt.Load(report);
            }

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_people_for_statements", con);
            //cmd1.Parameters.Add("@asatDate", SqlDbType.VarChar).Value = person_id;
            cmd1.Parameters.Add("@include_zero", SqlDbType.VarChar).Value = "Yes";
            cmd1.Parameters.Add("@system", SqlDbType.VarChar).Value = "Friends";

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();

            decimal totalbalance = 0;
            html = "<table><thead><tr><th>Select</th><th>Name</th><th>Invoice Recipient</th><th>Recipient Address Type</th><th>Recipient Address</th><th class=\"number\">Balance</th></tr></thead><tbody>";

            while (dr.Read())
            {
                string person_id = dr["person_id"].ToString();
                string name = dr["name"].ToString();
                string invoicerecipient = dr["invoicerecipient"].ToString();
                string invoiceaddresstype = dr["invoiceaddresstype"].ToString();
                string invoiceaddress = dr["invoiceaddress"].ToString();
                decimal balance = (decimal)dr["balance"];
                totalbalance += balance;
                string balance_display = balance.ToString("0.00");
                if(balance < 0)
                {
                    balance_display += "Cr";
                }
                string sent = "";

                if (IsPostBack)
                {
                    if (Request.Form["chk_person" + "_" + person_id] == person_id)
                    {
                        if (1 == 1)
                        {
                            SqlConnection con4 = new SqlConnection(strConnString);
                            SqlDataAdapter adp4 = new SqlDataAdapter("Report_Person_Transactions", con4);
                            adp4.SelectCommand.CommandType = CommandType.StoredProcedure;
                            adp4.SelectCommand.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                            ds.Clear();
                            adp4.Fill(ds);

                            //DataTable dt = ds.Tables["Table"];
                            //Literal1.Text = dt.Rows.Count.ToString();
                            //Response.Write(person_id + "=" + dt.Rows.Count.ToString() + "<br />");

                            rpt.SetDataSource(ds.Tables["Table"]);
                            //crv_report.ReportSource = rpt;

                            string filename = "C:\\inetpub\\ubc.org.nz\\people\\Statement " + name + ".pdf";
                            rpt.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, filename);
                            string[] attachments = new string[0];

                            Array.Resize(ref attachments, attachments.Length + 1);
                            attachments[attachments.GetUpperBound(0)] = filename;
                        }
                        
                        Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                        //functionoptions.Add("storedprocedure", "");

                        string emailhtml = "<html><head></head><body>";
                        emailhtml += "<p>To: " + invoicerecipient + "</p>";
                        emailhtml += "<p>Please find attached the current statement for " + name + " being regatta fees.</p>";
                        emailhtml += "<p>This statement represents transport, boat transportation, accomodation, meals and other incidentals which are handled by theFriends of UBC.<br />";
                        emailhtml += "Please note this does not include club subs and regatta races fees which are managed through the Club.</p>";
                        if (balance < 0)
                        {
                            emailhtml += "<p>Your account is in credit.  There is nothing to pay</p>";
                        }
                        else if (balance == 0)
                        {
                            emailhtml += "<p>Your account is paid up to date.  There is nothing to pay</p>";
                        }
                        else
                        {
                            emailhtml += "<p>It is payable to the \"Friends of Union Boat Club\" KiwiBank: 38-9018-0421031-00 <br />";
                            emailhtml += "Please use: \"" + name + "\" as the reference.</p>";
                        }
                        emailhtml += "<p>Please contact us at <a href=\"mailto:" + emailfrom + "\">" + emailfrom + "</a> (027) 2495088 if you have any queries.</p>";

                        emailhtml += "</body></html>";

                        string emailto = "";
                        if (invoiceaddresstype == "Email" && invoiceaddress != "")
                        {
                            emailto = invoiceaddress;
                            //emailto = "greg@datainn.co.nz";
                        }
                        else
                        {
                            emailto = "greg@datainn.co.nz";
                        }
                        //gFunctions.sendemailV4(host, emailfrom, emailfromname, password, "Friends of Union Boat Club Regattas Statement for " + name, emailhtml, emailto, emailBCC, "", attachments, functionoptions);
                        sent = " Sent";
                    }
                }

                html += "<tr>";
                html += "<td><input name=\"chk_person_" + person_id + "\" type=\"checkbox\" value=\"" + person_id + "\" />" + sent + " </td>";
                html += "<td>" + name + "</td>";
                html += "<td>" + invoicerecipient + "</td>";
                html += "<td>" + invoiceaddresstype + "</td>";
                html += "<td>" + invoiceaddress + "</td>";
                html += "<td class=\"number\">" + balance_display + "</td>";
                html += "</tr>";
            }
            dr.Close();
            con.Close();
            con.Dispose();
            html += "<tr><td colspan=\"5\"><td class=\"number\"><b>" + totalbalance.ToString("0.00") + "</b></td></tr>";
            html += "</tbody></table>";


            /*
            string report;
            DataSet ds = new DataSet();
            rpt = new ReportDocument();

            //string emailbodyTemplate = "RegisterEmail.xslt";
            string emailBCC = "greg@datainn.co.nz";
            string host = "70.35.207.87";
            string emailfrom = "UnionBoatClub@datainn.co.nz";
            string emailfromname = "Union Boat Club";
            string password = "39%3Zxon";
            Generic.Functions gFunctions = new Generic.Functions();


            report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
            rpt.Load(report);

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_people_for_statements", con);
            //cmd1.Parameters.Add("@asatDate", SqlDbType.VarChar).Value = person_id;
            cmd1.Parameters.Add("@include_zero", SqlDbType.VarChar).Value = "Yes";
            cmd1.Parameters.Add("@system", SqlDbType.VarChar).Value = "Friends";

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();

                while (dr.Read())
                //dr.Read();
                {
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
            */
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}