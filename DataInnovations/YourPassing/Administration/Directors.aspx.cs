using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YourPassing.Administration
{
    public partial class Directors : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Directors", con);
            //cmd.Parameters.Add("@agent_ctr", SqlDbType.VarChar).Value = Session["K4U_Agent_CTR"];

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html = "<table>";
            html += "<thead>";
            html += "<tr><th>Name</th><th>Address</th><th>Area</th><th>Email Address</th><th>Phone</th><th>Edit</th></tr>";
            html += "</thead>";
            html += "<tbody>";


            while (dr.Read())
            {

                html += "<tr data-id=\"" + dr["director_ctr"].ToString() + "\">";
                html += "<td>" + dr["name"].ToString() + "</td>";
                //html += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";
                html += "<td>" + dr["address"].ToString() + "</td>";
                html += "<td>" + dr["areaname"].ToString() + "</td>";
                html += "<td>" + dr["emailaddress"].ToString() + "</td>";
                html += "<td>" + dr["phonenumber"].ToString() + "</td>";
                html += "<td><button data-id=\"btn_edit\" type=\"button\">" + "Edit" + "</button></td>";
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