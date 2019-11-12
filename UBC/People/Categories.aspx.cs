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

namespace UBC.People
{
    public partial class Categories : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_all_person_category", con);
            //cmd1.Parameters.Add("@personguid", SqlDbType.VarChar).Value = guid;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            string lastname = "";

            try
            {
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string person_category_id = dr["person_category_id"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();
                        string category_id = dr["category_id"].ToString();
                        string category = dr["category"].ToString();
                        string startdate = dr["startdate"].ToString();
                        string enddate = dr["enddate"].ToString();
                        string current = dr["current"].ToString();
                        string note = dr["note"].ToString();
                        if (startdate != "")
                        {
                            startdate = Convert.ToDateTime(startdate).ToString("dd MMM yyyyy");
                        }
                        if (enddate != "")
                        {
                            enddate = Convert.ToDateTime(enddate).ToString("dd MMM yyyyy");
                        }
                        string theclass = "";
                        if (current == "0")
                        {
                            theclass += "notcurrent";
                        }
                        if (name == lastname)
                        {
                            name = "";
                        }
                        else
                        {

                            html += "<tr><td colspan=\"5\"><b>" + name + "</b></td><td><a href=\"javascript:void(0)\" class=\"add\" data-mode=\"add\">Add</a></td></tr>";
                            lastname = name;
                        }

                        //html += "<tr class=\"" + theclass + "\" data-person=\"" + person_id + "\">";
                        html += "<tr class=\"" + theclass + "\" id=\"id_" + person_category_id + "\" data-category=\"category_" + category_id + "\">";
                        //html += "<td><b>" + name + "</b></td>";
                        html += "<td style=\"text-align:center\"></td>";
                        html += "<td>" + category + "</td>";
                        html += "<td><input type=\"text\" class=\"form-control\" name=\"start_" + person_id + "_" + category_id + "\" value=\"" + startdate + "\" /></td>";
                        html += "<td><input type=\"text\" class=\"form-control\" name=\"end_" + person_id + "_" + category_id + "\" value=\"" + enddate + "\" /></td>";
                        html += "<td><input type=\"text\" class=\"form-control\" name=\"note_" + person_id + "_" + category_id + "\" value=\"" + note + "\" /></td>";
                        html += "<td><a href=\"javascript:void(0)\" class=\"delete\" data-mode=\"delete\">Delete</a></td>";
                        html += "</tr>";
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
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}