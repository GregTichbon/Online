using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Database
{
    public partial class TodaysBirthdays : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Birthdays-Today", con);
            //cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = id;


            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            if (dr.HasRows)
            {

                string html = "<table class=\"table table-striped\">";
                html += "<tr><th>Name</th><th>Age</th></tr>";

                string text = "TOH Birthdays: " + DateTime.Now.ToShortDateString();

                while (dr.Read())
                {
                    string name = dr["name"].ToString();
                    string age = dr["age"].ToString();

                    html += "<tr>";
                    html += "<td>" + name + "</td><td>" + age + "</td>";
                    html += "</tr>";

                    text += System.Environment.NewLine + name + " - " + age;
                }

                html += "</table>";

                Generic.Functions gFunctions = new Generic.Functions();
                string response = gFunctions.SendRemoteMessage("0272495088", text, "TOH Birthdays");

                string host = "70.35.207.87";
                string emailfrom = "no-reply@datainn.co.nz";
                string emailfromname = "Te Ora Hou Whanganui Birthdays";
                string password = "39%3Zxon";
                gFunctions.sendemailV3(host, emailfrom, emailfromname, password, "Te Ora Hou Whanganui Birthdays", html, "gtichbon@teorahou.org.nz", "", "");



            }

            dr.Close();

            con.Close();
            con.Dispose();
        }
    }
}