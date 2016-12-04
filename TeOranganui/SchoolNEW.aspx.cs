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
    public partial class SchoolNEW : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string[] dd_groupname_values;
        public string[] dd_gendertype_values; // = new string[3] { "Co-ed", "Female", "Male" };
        public string[] dd_authority_values;
        public string[] dd_type_values;
        public string[] dd_decile_values = new string[10] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };
        public string[] dd_startyear_values = new string[13] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" };
        public string[] dd_endyear_values = new string[13] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" };

        #endregion

        #region fields
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            dd_gendertype_values = Functions.Functions.populatelist("School", "GenderType");
            dd_authority_values = Functions.Functions.populatelist("School", "Authority");
            dd_type_values = Functions.Functions.populatelist("School", "Type");

            string liststring = "";
            string delim = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Schools", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        liststring += delim + dr["name"].ToString() + "\x00FD" + dr["group_id"].ToString();
                        delim = "\x00FE";
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
            dd_groupname_values = liststring.Split('\x00FE');
        }
    }
}