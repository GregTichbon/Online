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
    public partial class SchoolRowers : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UBC_person_id"] == null)
            {
                //string url = "../reports/SchoolRowers.aspx";
                //Response.Redirect("~/people/security/login.aspx?return=" + url);
 				Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");           }

            Boolean access = false;
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                access = true;
            }
            string atdate = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("school_rowers", con);


            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<table id=\"rower\" class=\"table table-striped\">";
                    html += "<thead>";
                    html += "<tr>";
                    html += "<th>School</th><th>Person</th><th>Gender</th><th>Age</th>";
                    html += "</tr>";
                    html += "</thead><tbody>";

                    while (dr.Read())
                    {
                        if(atdate == "")
                        {
                            atdate = dr["atdate"].ToString();
                            html = "<h2>Ages as at " + atdate + "</h2>" + html;
                        }
                        string person = dr["person"].ToString();
                        string school = dr["school"].ToString();
                        string ageatdate = dr["ageatdate"].ToString();
                        string gender = dr["gender"].ToString();

                        html += "<tr>";
                        html += "<td>" + school + "</td><td>" + person + "</td><td>" + gender + "</td><td>" + ageatdate + "</td>";

                        html += "</tr>";
                    }
                }
                html += "</tbody>";
                html += "</table>";


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