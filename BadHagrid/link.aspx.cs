using System;
using System.Data;
using System.Data.SqlClient;

namespace BadHagrid
{
    public partial class link : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            string link;
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand("badhagrid_get_parameter", con);
            cmd.Parameters.Add("@parameter", SqlDbType.VarChar).Value = "link";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();
            link = dr["value"].ToString();
            dr.Close();
            con.Close();
            con.Dispose();
            Response.Redirect(link);
        }
    }
}