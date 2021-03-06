﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class BankImport : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            //try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "Accounts_Transaction_Summary";



                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string Account_number = dr["Account_number"].ToString();
                        string FirstDate = dr["First Date"].ToString();
                        string LastDate = dr["Last Date"].ToString();
                        string transactions = dr["transactions"].ToString();
                        string Credits = dr["Credits"].ToString();
                        string Debits = dr["Debits"].ToString();
                        string Net = dr["Net"].ToString();


                        html += "<tr>";
                        html += "<td>" + Account_number + "</td>";
                        html += "<td>" + Convert.ToDateTime(FirstDate).ToShortDateString() + "</td>";
                        html += "<td>" + Convert.ToDateTime(LastDate).ToShortDateString() + "</td>";
                        html += "<td style=\"text-align:right\">" + transactions + "</td>";
                        html += "<td style=\"text-align:right\">" + Convert.ToDecimal(Credits).ToString("0.00") + "</td>";
                        html += "<td style=\"text-align:right\">" + Convert.ToDecimal(Debits).ToString("0.00") + "</td>";
                        html += "<td style=\"text-align:right\">" + Convert.ToDecimal(Net).ToString("0.00") + "</td>";
                        html += "</tr>";

                    }
                }
                dr.Close();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            Generic.Functions gFunctions = new Generic.Functions();

            //string datetimestamp = new DateTime().ToString("ddMMyyHHmmss");

            string datetimestamp = DateTime.Now.ToString("ddMMyyHHmmss");

            string filename = Server.MapPath("Uploads\\Bank") + "\\" + datetimestamp + fu_bankfile.FileName;

            fu_bankfile.SaveAs(filename);
            try
            {
                string messageresponse = gFunctions.SendRemoteMessage("0272495088", "Bank Import file submitted", "Bank Import");

            }
            catch (Exception ex)
            {
                //gFunctions.Log("", @"BankImport.aspx", "Error: gFunctions.SendRemoteMessage", "");
            }

            Thread.Sleep(2);

            int c0 = 0;

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            //try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "insert_bank_transaction";


                Boolean firstline = true;

                using (var reader = new StreamReader(filename))
                {
                    while (!reader.EndOfStream)
                    {
                        c0++;
                        var line = reader.ReadLine();
                        line = line.Replace("\"", "");
                        var values = line.Split(',');

                        if (!firstline)
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("@format", SqlDbType.VarChar).Value = dd_format.SelectedItem.ToString();

                            int c1 = 0;
                            foreach (string value in values)
                            {
                                string usevalue = value;
                                c1++;
                                if(c1 == 2)
                                {
                                    usevalue = DateTime.Parse(value).ToString("dd-MMM-yyyy");
                                }
                                cmd.Parameters.Add("@Parameter" + c1.ToString(), SqlDbType.VarChar).Value = usevalue;
                            }
                            string response = cmd.ExecuteScalar().ToString();
                        }
                        else
                        {
                            firstline = false;
                        }
                    }
                }
            }
            //catch (Exception ex)
            {
                //lit_response.Text = ex.Message;
            }
            //finally
            {
                con.Close();
                con.Dispose();
            }

            Response.Write(c0.ToString() + " lines processed.<br /><a href=\"BankAllocate.aspx\">Allocate</a>");

            //Response.Redirect("BankAllocate.aspx");
        }
        private string Q(string value)
        {
            return (string.Format("'{0}'", value));
        }
    }
}
