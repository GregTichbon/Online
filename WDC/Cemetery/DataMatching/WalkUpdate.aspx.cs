using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace Online.Cemetery.DataMatching
{
    public partial class WalkUpdate : System.Web.UI.Page
    {
        #region fields
        public string client_id;
        public string plot_id;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client_id = Request.QueryString["ID"];

            //List<BurialRecord> BurialRecordList = new List<BurialRecord>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_PlotLocation", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@accessid", SqlDbType.VarChar).Value = client_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();

                    plot_id = client_id.Substring(0, 1) + dr["PlotID"].ToString();
                    string Location = dr["Location"].ToString();
                    string GISID = dr["GISID"].ToString();
                    string GISOverride = dr["GISOverride"].ToString();
                    string GISLocation = dr["GISLocation"].ToString();

                    lit_GIS.Text = client_id;
                    if(client_id.Substring(0,1) == "S")
                    {
                        lit_GIS.Text += " (" + plot_id + ")";
                    }
                    lit_GIS.Text += " " + Location + "<br />";

                    if (GISOverride != "0")
                    {
                        lit_GIS.Text += "Override: " + GISLocation;
                    }
                    else if (GISID != "0")
                    {
                        lit_GIS.Text += "Matched: " + GISLocation;
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

        protected void btn_update_Click(object sender, EventArgs e)
        {

        }
    }
}