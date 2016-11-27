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
    public partial class School : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string[] dd_gender_values; // = new string[3] { "Co-ed", "Female", "Male" };
        public string[] dd_authority_values;
        public string[] dd_type_values;
        public string[] dd_decile_values = new string[10] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };
        public string[] dd_startyear_values = new string[13] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10","11","12","13" };
        public string[] dd_endyear_values = new string[13] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10","11","12","13" };


        #endregion

        #region fields
        public int hf_groupid;
        public string tb_groupname;
        public string tb_moenumber;
        public string dd_gender;
        public string dd_authority;
        public string dd_type;
        public string dd_decile;
        public string dd_startyear;
        public string dd_endyear;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            dd_gender_values = Functions.Functions.populatelist("School", "Gender");
            dd_authority_values = Functions.Functions.populatelist("School", "Authority");
            dd_type_values = Functions.Functions.populatelist("School", "Type");

            /*
            if (Session["IDS"] == null)
            {
                Response.Redirect("Search.aspx");
            }
            id = Convert.ToInt16(Session["IDS"]);
            */

            hf_groupid = 1;

            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Group", con);
            cmd.Parameters.Add("@groupid", SqlDbType.Int).Value = hf_groupid;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    tb_groupname = dr["groupname"].ToString();
                    //GroupType_ID = dr["GroupType_ID"].ToString();
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