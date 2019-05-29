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
    public partial class agentregister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("K4U_Agent_CTR");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "update_agent";
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress.Text;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = tb_password.Text;


            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string id = dr[0].ToString();
            Session["K4U_Agent_CTR"] = id;
            con.Close();
            con.Dispose();
            Response.Redirect("AgentDeceasedManagement.aspx");
        }
    }
}