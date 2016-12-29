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
    public partial class Person : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string[] dd_gender_values = new string[3] { "Female", "Male", "Gender Diverse" };
        public string[] dd_selectperson_values;

        #endregion

        #region fields
        public int hf_person_id;
        public string tb_lastname;
        public string tb_firstname;
        public string dd_gender;
        public string tb_notes;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["IDS"] == null)
            {
                Response.Redirect("Search.aspx");
            }
            id = Convert.ToInt16(Session["IDS"]);
            */

            string liststring = "";
            string delim = "";

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con;
            SqlCommand cmd;

            con = new SqlConnection(strConnString);
            cmd = new SqlCommand("Get_dropdown", con);
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "person";

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
                        liststring += delim + dr["label"].ToString() + "\x00FD" + dr["value"].ToString();
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
            dd_selectperson_values = liststring.Split('\x00FE');

/*
            hf_person_id = 1;

            liststring = "";
            delim = "";

            con = new SqlConnection(strConnString);
            cmd = new SqlCommand("Get_Person", con);
            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = hf_person_id;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    tb_lastname = dr["lastname"].ToString();
                    tb_firstname = dr["firstname"].ToString();
                    dd_gender = dr["gender"].ToString();
                    tb_notes = dr["notes"].ToString();

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