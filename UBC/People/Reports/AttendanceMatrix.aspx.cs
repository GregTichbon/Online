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
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11110001"))
            {
                Response.Redirect("~/default.aspx");
            }

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
                            html = "<div class=\"sticky-table sticky-ltr-cells\">";
                            html += "<table class=\"table\">";
                            html += "<thead>";
                            html += "<tr class=\"sticky-header\">";
                            html += "<th class=\"sticky-cell\">Name</th>";

                            for (int f1 = 2; f1 < dr.FieldCount; f1++)
                            {
                                html += "<th nowrap class=\"c" + f1 + "\">" + dr.GetName(f1) + "</th>";
                            }
                            html += "</tr>";
                            html += "</thead>";
                            html += "<tbody>";

                            firsttime = false;
                        }

                        //string person_id = dr["person_id"].ToString();
                        string name = dr["name"].ToString();

                        string trclass = "";
                        if (dr["person_id"].ToString() == Session["UBC_person_id"].ToString())
                        {
                            trclass = " class=\"me\"";
                        }
                        html += "<tr" + trclass + ">";
                        html += "<td nowrap class=\"sticky-cell\">" + name + "</td>";

                        for (int f1 = 2; f1 < dr.FieldCount; f1++)
                        {
                            html += "<td class=\"c" + f1 + "\">" + dr[f1] + "</td>";
                        }

                        html += "</tr>";
                    }
                    html += "</tbody>";
                    html += "</table>";
                    html += "</div>";
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