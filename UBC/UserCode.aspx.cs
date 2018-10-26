using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC
{
    public partial class UserCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("UBC_guid");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_Registration";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = Request.Form["tb_usercode"].ToString();
            cmd.Parameters.Add("@limit", SqlDbType.VarChar).Value = 5;


            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    Session["UBC_guid"] = dr["guid"].ToString();
   
                } else
                {
                    lit_error.Text = "Sorry that was an invalid user code";
                }
                dr.Close();
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
            if(Session["UBC_guid"] != null)
            {
                Response.Redirect("People/register.aspx");
            }
        }
    }
}