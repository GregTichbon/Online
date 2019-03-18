using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration
{
    public partial class InformationUpdate : System.Web.UI.Page
    {
        public string mode;
        public string connection;
        public string key;

        protected void Page_Load(object sender, EventArgs e)
        {
            key = Request.QueryString["key"];
            connection = key.Substring(0, 2) + "OnlineConnectionString";
            //mode = key.Substring(2, 3);

            String strConnString = ConfigurationManager.ConnectionStrings[connection].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Get_information";
            cmd.Parameters.Add("@key", SqlDbType.VarChar).Value = key;
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = key;

            cmd.Connection = con;
            try
            {
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    mode = dr["display"].ToString();
                    lit_display.Text = dr["display"].ToString();
                    switch (mode) {
                        case "001":
                            break;
                        default:
                            break;
                    }
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //con.Close();
                //con.Dispose();
            }



        }
    }
}