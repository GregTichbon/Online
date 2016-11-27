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
    public partial class ListORIG : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

/*
        public string[] dd_grouptype_values; 
*/
        public string[] dd_list_values; // = new string[3] { "Co-ed", "Female", "Male" };
        #endregion

        #region fields
        //public string dd_grouptype;
        //public string dd_list;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            string options = "";
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("get_grouptype", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    String delim = "";
                    while (dr.Read())
                    {
                        options = options + delim + dr["description"] + "\x00fc" + dr["grouptype_id"];
                        delim = "\x00fd";
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
            dd_grouptype_values = options.Split('\x00fd');
            */
            /*
            string str = "";
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("get_list", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@grouptype_id", SqlDbType.VarChar).Value = null;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    string delim = "";
                    while (dr.Read())
                    {
                        str = str + delim + dr["name"];
                        delim = "|";
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
            dd_list_values = str.Split(new string[] { "|" }, StringSplitOptions.None);
            */
        }
    }
}