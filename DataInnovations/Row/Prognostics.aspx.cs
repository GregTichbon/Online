using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Row
{
    public partial class Prognostics : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);

            

            SqlCommand cmd = new SqlCommand("Get_Prognostics", con);
            cmd.Parameters.Add("@Discipline", SqlDbType.VarChar).Value = "";

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    html += "<tr><th>Discipline</th><th>Boat</th><th>Gender</th><th>Division</th><th>Prognostic Time</th></tr>";
                    while (dr.Read())
                    {

                        html += "<tr>";
                        html += "<td>" + dr["Discipline"].ToString() + "</td>";
                        html += "<td>" + dr["Boat"].ToString() + "</td>";
                        html += "<td>" + dr["Gender"].ToString() + "</td>";
                        html += "<td>" + dr["Division"].ToString() + "</td>";
                        html += "<td>" + dr["PrognosticTime"].ToString() + "</td>";
                        html += "</tr>";
                    }

                    dr.Close();
                }
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