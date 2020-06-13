using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Response
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"].ToString();
            string type = Request.QueryString["type"].ToString();
            string response = Request.QueryString["response"].ToString();

            string connectionString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("Update_Response", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
                cmd.Parameters.Add("@response", SqlDbType.VarChar).Value = response;
                con.Open();

                cmd.ExecuteScalar();
                con.Close();

            }
        }

    }
}