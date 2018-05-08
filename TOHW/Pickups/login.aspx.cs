using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Pickups
{
    public partial class login : System.Web.UI.Page
    {
        public string formattedDate; 
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Parameter", con);
            cmd.Parameters.Add("@pName", SqlDbType.VarChar).Value = "CurrentPickupDate";


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string DBDate = dr["pdate1"].ToString();
                    DateTime theDate;
                    if (DateTime.TryParse (DBDate, out theDate))
                    {
                        formattedDate = theDate.ToString("d MMM yyyy");
                    }
                }
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
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (tb_password.Text == "dontrump" && tb_name.Text != "")
            {
                Session["pickups_loggedin"] = "Yes";
                DateTime now = DateTime.Now;
                Session["pickups_name"] = tb_name.Text + " " + now.ToString();
                Response.Redirect("default.aspx");
            }
            else {
                Session.Remove("pickups_loggedin");
                Session.Remove("pickups_name");
            }
        }
    }
}
 