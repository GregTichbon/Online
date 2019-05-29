using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YourPassing
{
    public partial class deceased : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string deceased_ctr = Request.QueryString["id"];
            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Deceased", con);
            cmd.Parameters.Add("@deceased_ctr", SqlDbType.VarChar).Value = deceased_ctr;

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html = "<table>";
            html += "<thead>";
            html += "</thead>";
            html += "<tbody>";


            while (dr.Read())
            {
                html += "<tr><td>First name</td><td>" + dr["firstname"].ToString() + "</td></tr>";
                html += "<tr><td>Last name</td><td>" + dr["lastname"].ToString() + "</td></tr>";
                html += "<tr><td>Known as</td><td>" + "</td></tr>";
                html += "<tr><td>Date of birth</td><td>" + "</td></tr>";
                html += "<tr><td>Last residence</td><td>" + "</td></tr>";
                html += "<tr><td>Date of death</td><td>" + "</td></tr>";
                html += "<tr><td>Place of death</td><td>" + "</td></tr>";
                //html += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";
            }
            dr.Close();
            html += "</tbody>";
            html += "</table>";

            html += "<br /><br /><br /><br /><br /><br /><br />";
            html += "<button id=\"btn_message\" type=\"button\">Leave a message (NB: this will still lead on to making a koha)</button><br /><br />";
            html += "<button id=\"btn_support\" type=\"button\">Help support the family</button>";

            dr.Close();
            con.Close();
            con.Dispose();
        }
    }
}