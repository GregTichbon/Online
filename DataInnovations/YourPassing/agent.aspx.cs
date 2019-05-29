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
    public partial class agent : System.Web.UI.Page
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

            cmd.CommandText = "agent_signin";
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress.Text;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = tb_password.Text;


            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.HasRows)
            {
                dr.Read();
                Session["K4U_Agent_CTR"] = dr["Agent_CTR"].ToString();

            } else
            {

            }
            con.Close();
            con.Dispose();

            if (Session["K4U_Agent_CTR"] != null)
            {
                Response.Redirect("AgentDeceasedManagement.aspx");
            }
        }
    }
}