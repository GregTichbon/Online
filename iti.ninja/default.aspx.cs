using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Common;

namespace iti.ninja
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string link = Request.Url.ToString();
            string redirect = "";

            string strConnString = "Data Source=localhost\\MSSQLSERVER2016;Initial Catalog=Iti_Ninja;Integrated Security=False;user id=iti_ninja;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd = new SqlCommand("Action_Redirection", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@link", SqlDbType.VarChar).Value = link;
            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.HasRows) {
                    dr.Read();
                    redirect = dr["url"].ToString();
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
            //lit_Error.Text = link;
            if (redirect != "")
            {
                Response.Redirect(redirect);
            }
        }
    }
}