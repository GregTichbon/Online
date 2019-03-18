using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Online.Payment
{
    public partial class DatacomOption1 : System.Web.UI.Page
    {
        public string paymentrequestreference;
        public string amount;
        public string detail;


        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions functions = new WDCFunctions.WDCFunctions();
            paymentrequestreference = Request.QueryString["reference"];
            /*
            if (paymentrequestreference is null)
            {

                paymentrequestreference = "Test1";

                //paymentrequestreference = "91545cb3-f3b7-4262-a25d-92f106f70fca"; 
            }
            */

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Payment_Request", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = paymentrequestreference;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    detail = dr["detail"].ToString();
                    amount = dr["amount"].ToString();

                }
            }
            catch (Exception ex)
            {
                functions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}