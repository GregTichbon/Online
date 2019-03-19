using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS.Receive
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Update_SMSLog";
            cmd.Parameters.Add("@direction", SqlDbType.VarChar).Value = "Received";
            cmd.Parameters.Add("@phonenumber", SqlDbType.VarChar).Value = "to do";
            cmd.Parameters.Add("@message", SqlDbType.VarChar).Value = "to do";
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = "to do";
            cmd.Connection = con;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            con.Dispose();
        }
    }
}