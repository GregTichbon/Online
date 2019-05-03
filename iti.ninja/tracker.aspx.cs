using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iti.ninja
{
    public partial class tracker : System.Web.UI.Page
    {

        //public string[] codes = new string[5] { "Personal", "Reimburse", "Company", "Family Trust", "Transfer" };

        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=localhost\\MSSQLSERVER2016;Initial Catalog=Iti_Ninja;Integrated Security=False;user id=iti_ninja;password=Whanganui497";

            string sql = "Tracker";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html = "<table>";
            html += "<thead>";
            html += "<tr><th>Link</th><th>URL</th><th>Description</th><th>DateTime</th><th>ID</th><th>QueryString</th></tr>";
            html += "</thead>";
            html += "<tbody>";


            while (dr.Read())
            {  
                string Link = dr[0].ToString();
                string URL = dr[1].ToString();
                string Description = dr[2].ToString();
                string TheDateTime = dr[3].ToString();
                if(TheDateTime != "")
                {
                    TheDateTime = DateTime.Parse(TheDateTime).ToString("ddd dd-MMM-yy");
                }

                string ID = dr[4].ToString();
                string QueryString = dr[5].ToString();

                html += "<tr>";
                html += "<td>" + Link + "</td>";
                html += "<td><a href=\"" + URL + QueryString + "\">" + URL + "</td>";
                html += "<td>" + Description + "</td>";
                html += "<td>" + TheDateTime + "</td>";
                html += "<td>" + ID + "</td>";
                html += "<td>" + QueryString + "</td>";
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