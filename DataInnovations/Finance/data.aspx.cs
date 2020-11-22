using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.Finance
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
                case "Get_Finance_Transaction_Items":
                    string transaction_id = Request.QueryString["transaction_id"];
                    html = "<table id=\"tab_allocate\"><thead><tr><th>Description</th><th>Other Party</th><th>Type</th><th>Invoice</th><th style=\"text-align:right\">Amount</th><th style=\"text-align:right\">GST</th><th><span class=\"edit\">Add</span></th></tr></thead><tbody>";
                    double total = 0;
                    double GSTtotal = 0;
                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("Get_Finance_Transaction_Items", con);
                    cmd1.Parameters.Add("@transaction_id", SqlDbType.VarChar).Value = transaction_id;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                //ID	TransactionID	Description	OtherParty	Amount	GST		Invoice	Type	name

                                string id = dr["ID"].ToString();
                                string Description = dr["Description"].ToString();
                                string OtherParty = dr["OtherParty"].ToString();
                                string name = dr["name"].ToString();
                                string Type = dr["Type"].ToString();
                                string Invoice = dr["Invoice"].ToString();
                                string Amount = dr["amount"].ToString();
                                string GST = dr["GST"].ToString();
                                total += Convert.ToDouble(Amount);
                                GSTtotal += Convert.ToDouble(GST);

                                html += "<tr id=\"tr_" + id + "\"><td>" + Description + "</td><td>" + name + "</td><td>" + Type + "</td><td>" + Invoice + "</td><td style=\"text-align:right\">" + Convert.ToDecimal(Amount).ToString("0.00") + "</td><td style=\"text-align:right\">" + Convert.ToDecimal(GST).ToString("0.00") + "</td><td><span class=\"edit\">Edit</span></td></tr>";
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
                    html += "<tr><th colspan=\"5\" style=\"text-align:right\">" + Convert.ToDecimal(total).ToString("0.00") + "</th><th style=\"text-align:right\">" + Convert.ToDecimal(GSTtotal).ToString("0.00") + "</th></tr>";
                    html += "</tfoot></table>";

                    break;
            }
        }
    }
}