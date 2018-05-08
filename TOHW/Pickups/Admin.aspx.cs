using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Pickups
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["pickups_loggedin"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Get_Parameters", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pname", SqlDbType.VarChar).Value = "CurrentPickupDate";
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            DateTime theDate;
                            theDate = Convert.ToDateTime(dr["pdate1"]);
                            tb_date.Text = theDate.ToString("d MMM yyyy");
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
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {

        }

        protected void btn_setdate_Click(object sender, EventArgs e)
        {
            DateTime theDate;
            //if (DateTime.TryParseExact(tb_date.Text, "d/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out theDate))
            if(DateTime.TryParse(tb_date.Text, out theDate))
            {
                String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Update_Parameter", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pname", SqlDbType.VarChar).Value = "CurrentPickupDate";
                cmd.Parameters.Add("@pdate1", SqlDbType.VarChar).Value = tb_date.Text;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {

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
          
                Response.Redirect ("default.aspx");
            }
            else
            {
                //Invalid date
            }
        }
    }
}