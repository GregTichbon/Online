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
    public partial class AttendanceMatrix : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Events_Attendance", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    Boolean firsttime = true;

                    while (dr.Read())
                    {
                        if (firsttime)
                        {
                            Lit_html.Text = "<div class=\"sticky-table sticky-ltr-cells\">";
                            Lit_html.Text += "<table class=\"table\">";
                            Lit_html.Text += "<thead>";
                            Lit_html.Text += "<tr class=\"sticky-header\">";
                            Lit_html.Text += "<th class=\"sticky-cell\">Name</th>";

                            for (int f1 = 1; f1 < dr.FieldCount; f1++)
                            {
                                Lit_html.Text += "<th nowrap>" + dr.GetName(f1) + "</th>";
                            }
                            Lit_html.Text += "</tr>";
                            Lit_html.Text += "</thead>";
                            firsttime = false;
                        }

                        //string person_id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();
                        Lit_html.Text += "<tbody>";

                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td nowrap class=\"sticky-cell\">" + name + "</td>";

                        for (int f1 = 1; f1 < dr.FieldCount; f1++)
                        {
                            Lit_html.Text += "<td>" + dr[f1] + "</td>";
                        }

                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "</tbody>";
                    }
                }
                Lit_html.Text += "</table>";
                Lit_html.Text += "</div>";

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