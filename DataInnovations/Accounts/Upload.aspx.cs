﻿using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Accounts
{
    public partial class Upload : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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
                        string bank_account = dr["bank_account"].ToString();
                        string FirstDate = dr["First Date"].ToString();
                        string LastDate = dr["Last Date"].ToString();
                        string transactions = dr["transactions"].ToString();
                        string Credits = dr["Credits"].ToString();
                        string Debits = dr["Debits"].ToString();
                        string Net = dr["Net"].ToString();


                        html += "<tr>";
                        html += "<td>" + bank_account + "</td>";
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
            Functions gFunctions = new Functions();

            //string datetimestamp = new DateTime().ToString("ddMMyyHHmmss");

            string datetimestamp = DateTime.Now.ToString("ddMMyyHHmmss");

            if (fu_bankfile.HasFiles)
            {
                foreach (var file in fu_bankfile.PostedFiles)
                {
                    string extension = Path.GetExtension(file.FileName);
                    string filename = Path.GetFileNameWithoutExtension(file.FileName);

                    filename = Server.MapPath("Uploads\\Bank") + "\\" + filename + "_" + datetimestamp + "." + extension;

                    file.SaveAs(filename);
                    try
                    {
                        //string messageresponse = gFunctions.SendRemoteMessage("0272495088", "Bank Import file submitted", "Bank Import");

                    }
                    catch (Exception ex)
                    {
                        //gFunctions.Log("", @"BankImport.aspx", "Error: gFunctions.SendRemoteMessage", "");
                    }

                    Thread.Sleep(2);

                    int c0 = 0;

                    string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                    SqlConnection con = new SqlConnection(strConnString);

                    con = new SqlConnection(strConnString);
                    //try
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "Accounts_Upload";


                        //Boolean firstline = true;

                        using (var reader = new StreamReader(filename))
                        {
                            while (!reader.EndOfStream)
                            {
                                c0++;
                                var line = reader.ReadLine();
                                line = line.Replace("\"", "");
                                var values = line.Split('\t');


                                if (!new[] { "Card", "Type" }.Contains(values[0].ToString()))
                                {
                                    cmd.Parameters.Clear();
                                    cmd.Parameters.Add("@format", SqlDbType.VarChar).Value = dd_format.SelectedItem.ToString();
                                    cmd.Parameters.Add("@filename", SqlDbType.VarChar).Value = file.FileName;

                                    int c1 = 0;
                                    foreach (string value in values)
                                    {
                                        string usevalue = value;
                                        c1++;
                                        /*
                                        if (c1 == 2)
                                        {
                                            usevalue = DateTime.Parse(value).ToString("dd-MMM-yyyy");
                                        }

                                        */
                                        Regex regex = new Regex(@"^([0-3][0-9][/][0-1][0-9][/]20[0-9][0-9])$");
                                        Match match = regex.Match(usevalue);
                                        if (match.Success)
                                        {
                                            usevalue = DateTime.Parse(usevalue).ToString("dd-MMM-yyyy");
                                        }

                                        cmd.Parameters.Add("@Parameter" + c1.ToString(), SqlDbType.VarChar).Value = usevalue;
                                    }
                                    string response = cmd.ExecuteScalar().ToString();
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

                        Response.Write(c0.ToString() + " lines processed.<br /><a href=\"Allocate.aspx\">Allocate</a>");

                        //Response.Redirect("BankAllocate.aspx");
                    }
                }
            }
        }
        private string Q(string value)
        {
            return (string.Format("'{0}'", value));
        }

    }
}