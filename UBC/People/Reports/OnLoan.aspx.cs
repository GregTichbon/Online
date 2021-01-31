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
    public partial class OnLoan : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            Generic.Functions gFunctions = new Generic.Functions();

            if (Session["UBC_person_id"] == null)
            {
                //string url = "../reports/SchoolRowers.aspx";
                //Response.Redirect("~/people/security/login.aspx?return=" + url);
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }

            Boolean access = false;
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                access = true;
            }
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("report_onloan", con);


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
                    html += "<th>Person</th><th>XXXX</th><th>XXXX</th><th>XXXX</th><th>XXXX</th>";
                    html += "</tr>";
                    html += "</thead><tbody>";

                    while (dr.Read())
                    {

                        string person_guid = dr["guid"].ToString();
                        string person = dr["person"].ToString();
                        string key = dr["key"].ToString();
                        string keyactive = dr["keyactive"].ToString();
                        string onloanfromclub = dr["onloanfromclub"].ToString();
                        string onloanfromclubactive = dr["onloanfromclubactive"].ToString();
                        string uniform = dr["uniform"].ToString();
                        string uniformactive = dr["uniformactive"].ToString();

                        html += "<tr>";
                        html += "<td><a href=\"../maint.aspx?id=" + person_guid + "\" target=\"link\">" + person + "</a></td><td>" + "XXXX" + " </td><td>" + "XXXX" + "</td><td>" + "XXXX" + "</td><td>" + "XXXX" + "</td>";

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