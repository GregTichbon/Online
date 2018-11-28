using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class Finance : System.Web.UI.Page
    {
        public string html;
        public string event_id;
        public string export;
        protected void Page_Load(object sender, EventArgs e)
        {
            event_id = Request.QueryString["event"] ?? "";

            if (Session["UBC_person_id"] == null)
            {
                string url = "../reports/finance.aspx";
                Response.Redirect("~/people/security/login.aspx?return=" + url);
            }


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_finance", con);
            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;


            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    /*
                    if (guid == "")
                    {
                        export = "";
                        html = "<table class=\"table table-striped\">";
                        html += "<tr><th>Title</th><th style=\"white-space:nowrap\">When</th><th>Detail</th></tr>";

                        while (dr.Read())
                        {
                            guid = dr["guid"].ToString();
                            string title = dr["title"].ToString();
                            string when = dr["when"].ToString();
                            string description = dr["description"].ToString();

                            html += "<tr>";
                            html += "<td><a href=\"?id=" + guid + "\">" + title + "</a></td><td>" + when + "</td><td>" + description + "</td>";
                            html += "</tr>";
                        }
                    }
                    else
                    {
                    */
                        export = "<input type=\"button\" id=\"export\" class=\"btn btn-info\" value=\"Export\" />";
                        html = "<table id=\"attendance\" class=\"table table-striped\">";


                    //	Person_Finance_ID, person_id, Name, date, system, code, Person_Event_ID, Event_ID, Event Date, Title, Amount, Banked

                    html += "<tr><th>Name</th><th>Event</th><th>Code</th><th>Date</th><th>Amount</th><th>Banked</th></tr>";

                    while (dr.Read())
                    {
                        string Person_Finance_ID = dr["Person_Finance_ID"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string Name = dr["Name"].ToString();
                        string date = Convert.ToDateTime(dr["date"]).ToString("dd MMM yy");
                        string system = dr["system"].ToString();
                        string code = dr["code"].ToString();
                        string Person_Event_ID = dr["Person_Event_ID"].ToString();
                        string Event_ID = dr["Event_ID"].ToString();
                        string Event_Date = dr["Event Date"].ToString();
                        string Title = dr["Title"].ToString();
                        string Amount = Convert.ToDecimal(dr["Amount"]).ToString("0.00");
                        string Banked = dr["Banked"].ToString();
                        if (Banked != "")
                        {
                            Banked = Convert.ToDateTime(Banked).ToString("dd MMM yy");
                        }

                        html += "<tr>";
                        html += "<td>" + Name + "</td><td>" + Title + "</td><td>" + code + "</td><td>" + date + "</td><td>" + Amount + "</td><td>" + Banked + "</td>";
                        html += "</tr>";
                    }
                    //}
                    html += "</table>";
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
        }
    }
}