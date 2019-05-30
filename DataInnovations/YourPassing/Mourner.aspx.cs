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
    public partial class Mourner : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Deceased", con);
            cmd.Parameters.Add("@agent_ctr", SqlDbType.VarChar).Value = Session["K4U_Agent_CTR"];

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html = "<table>";
            html += "<thead>";
            html += "<tr><th>First name</th><th>Last name</th><th>Known as</th><th>Date of Death</th><th>View</th></tr>";
            html += "</thead>";
            html += "<tbody>";


            while (dr.Read())
            {

                html += "<tr data-id=\"" + dr["deceased_ctr"].ToString() + "\" data-name=\"" + dr["name"].ToString() + "\">";
                html += "<td>" + dr["firstname"].ToString() + "</td>";
                //html += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";
                html += "<td>" + dr["lastname"].ToString() + "</td>";
                html += "<td>" + "" + "</td>";
                html += "<td>" + "" + "</td>";
                html += "<td><button data-id=\"btn_view\" type=\"button\">" + "View" + "</button></td>";
                html += "</tr>";
            }
            dr.Close();
            html += "</tbody>";
            html += "</table>";
            dr.Close();
            con.Close();
            con.Dispose();
        }
    }
}