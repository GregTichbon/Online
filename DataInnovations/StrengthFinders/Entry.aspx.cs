﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.StrengthFinders
{
    public partial class Entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=StrengthFinders;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_People_Strengths", con);
            //cmd.Parameters.Add("@???????", SqlDbType.VarChar).Value = ??????;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    LitRows.Text = "<div class=\"sticky-table sticky-headers sticky-ltr-cells\">";

                    LitRows.Text += "<table class=\"table table-bordered table-striped\"><thead>";

                    LitRows.Text += "<tr id=\"groups\" class=\"sticky-row\">";
                    LitRows.Text += "<th class=\"sticky-cell\"></th>";
                    LitRows.Text += "<th colspan=\"9\">Executing</th>";
                    LitRows.Text += "<th colspan=\"9\">Relationship Building</th>";
                    LitRows.Text += "<th colspan=\"8\">Influencing</th>";
                    LitRows.Text += "<th colspan=\"8\">Strategic Thinking</th>";
                    LitRows.Text += "</tr>";

                    LitRows.Text += "<tr class=\"sticky-row\">";
                    LitRows.Text += "<th class=\"left sticky-cell\">Name</th>";
                    for (int f1 = 5; f1 <= dr.FieldCount-1; f1++)
                    {
                        string[] fieldname = dr.GetName(f1).ToString().Split('.');
                        LitRows.Text += "<th id=\"S" + (f1-4) + "\" class=\"strength\">" + fieldname[1] + "</th>";
                    }

                    LitRows.Text += "</tr></thead><tbody>";

                    do
                    {
                        string person = dr["person_ctr"].ToString();
                        LitRows.Text += "<tr>";
                        LitRows.Text += "<td id=\"P" + person + "\" class=\"person left sticky-cell\">" +  (dr["firstname"] + " " + dr["lastname"]).Trim() + "<br /><span class=\"subgroup\">" + dr["subgroup"] + "</span></td>";
                        
                        for (int f1 = 5; f1 <= dr.FieldCount - 1; f1++)
                        {
                            string[] fieldname = dr.GetName(f1).ToString().Split('.');
                            string id = "R_" + person + "_" + fieldname[0];
                            string rank = dr.GetValue(f1).ToString();
                            LitRows.Text += "<td id=\"" + id + "\" class=\"rank\" person=\"" + person + "\" strength=\"" + fieldname[0] + "\" rank=\"" + rank + "\">" + rank + "</td>";
                        }
                        LitRows.Text += "</tr>";
                    }
                    while (dr.Read());
                    LitRows.Text += "</tbody></table></div>";

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
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            HashSet<string> persons = new HashSet<string>();

            string strConnString = "Data Source=toh-app;Initial Catalog=StrengthFinders;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            foreach (string key in Request.Form.Keys)
            {
                if (key.StartsWith("R_"))
                {
                    string[] keysplit = key.Split('_');
                    string person = keysplit[1];
                    persons.Add(person);
                    string strength = keysplit[2];
                    string rank = Request.Form[key].ToString();

                    SqlCommand cmd = new SqlCommand("Update_Person_Strength", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    con.Open();
                    cmd.Parameters.Add("@person_ctr", SqlDbType.VarChar).Value = person;
                    cmd.Parameters.Add("@strength_ctr", SqlDbType.VarChar).Value = strength;
                    cmd.Parameters.Add("@rank", SqlDbType.VarChar).Value = rank;

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                    }

                    dr.Close();
                    con.Close();
                }
                else if (key.StartsWith("newname_"))
                {
                    string person_ctr = "0";
                    string name = Request.Form[key].ToString();

                    SqlCommand cmd = new SqlCommand("Update_Person", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    con.Open();
                    cmd.Parameters.Add("@person_ctr", SqlDbType.VarChar).Value = 0;
                    cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        person_ctr = dr["person_ctr"].ToString();
                    }
                    dr.Close();
                    con.Close();


                    string newname_id = key.Substring(8);

                    foreach (string key2 in Request.Form.Keys)
                    {
                        if (key2.StartsWith("new_" + newname_id + "_"))
                        {
                            string[] key2split = key2.Split('_');
                            string strength = key2split[2];
                            string rank = Request.Form[key2].ToString();

                            SqlCommand cmd2 = new SqlCommand("Update_Person_Strength", con);
                            cmd2.CommandType = CommandType.StoredProcedure;
                            cmd2.Connection = con;
                            con.Open();
                            cmd2.Parameters.Add("@person_ctr", SqlDbType.VarChar).Value = person_ctr;
                            cmd2.Parameters.Add("@strength_ctr", SqlDbType.VarChar).Value = strength;
                            cmd2.Parameters.Add("@rank", SqlDbType.VarChar).Value = rank;

                            SqlDataReader dr2 = cmd2.ExecuteReader();
                            if (dr2.HasRows)
                            {
                                dr2.Read();
                            }
                            dr2.Close();
                            con.Close();
                        }
                    }

                }
            }

            foreach (string person in persons)
            {
                SqlCommand cmd = new SqlCommand("Match_People", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                con.Open();
                cmd.Parameters.Add("@pass_person_ctr", SqlDbType.VarChar).Value = person;
                cmd.Parameters.Add("@return_top", SqlDbType.VarChar).Value = 0;

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                }

                dr.Close();
                con.Close();
            }

            con.Dispose();

            Response.Redirect(Request.RawUrl);
        }
    }
}