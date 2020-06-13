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
    public partial class Payment : System.Web.UI.Page
    {
        string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
        static string guid;
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                guid = Request.QueryString["id"];
                ViewState["guid"] = guid;

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Get_Payment_Details", con);
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                dr.Read();
                html = "Ask for credit card details for payment of " + dr["amount"].ToString() + " being for " + dr["name"].ToString();

                dr.Close();
                con.Close();
                con.Dispose();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
         
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_Payment";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = ViewState["guid"];
            

            con.Open();
            cmd.ExecuteScalar();

            //SqlDataReader dr = cmd.ExecuteReader();
            //dr.Read();

            //string guid = dr[0].ToString();
            con.Close();

            con.Dispose();
            Response.Redirect("paymentprocess.aspx");
             
        }


    }
}