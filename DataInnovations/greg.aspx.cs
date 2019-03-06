using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace SMSChecker
{
    public partial class greg : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string IPAddress = "";
            String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_PARAMETER", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@parameter", SqlDbType.VarChar).Value = "IPAddress";

            cmd.Connection = con;
            try
            {
                con.Open();
                //SqlDataReader dr = cmd.ExecuteReader();
                IPAddress = cmd.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.Message);
                //Console.WriteLine(ex.InnerException);
                throw ex;
            }
            finally
            {
                con.Close();
            }
            html = "IP Address: " + IPAddress;

        }
    }
}