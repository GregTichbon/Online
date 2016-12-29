using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace TeOranganui
{
    public partial class Main : System.Web.UI.Page
    {
        public int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["IDS"] == null)
            {
                Response.Redirect("Search.aspx");
            }
            id = Convert.ToInt16(Session["IDS"]);
            */

            id = 1;
            string name = "";
            string GroupType_ID = "";



            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Group", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    name = dr["name"].ToString();
                    GroupType_ID = dr["GroupType_ID"].ToString();
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

            /*
            con = new SqlConnection(strConnString);

            cmd = new SqlCommand("Get_GroupType_" + GroupType_ID, con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    switch (GroupType_ID)
                    {
                        case "1": //School 
                            break;
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
            */
        }
    }
}