using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class Check : System.Web.UI.Page
    {
        public string hf_guid;
        public string hf_person_id;
        public string tb_firstname;
        public string tb_lastname;
        public string tb_knownas;
        public string tb_birthdate;
        public string dd_gender;
        public string tb_medical;
        public string tb_dietry;
        public string tb_emailaddress;
        public string tb_mobilephone;
        public string dd_school;
        public string tb_schoolyear;
        public string tb_facebook;
        public string tb_residentialaddress;
        public string tb_postaladdress;



        public string[] school = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gender = new string[2] { "Female", "Male" };
        public string[] yesno = new string[2] { "Yes", "No" };


        protected void Page_Load(object sender, EventArgs e)
        {
            hf_guid = Request.QueryString["id"];

            if (hf_guid != "new")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "get_person";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;


                cmd.Connection = con;
                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        hf_person_id = dr["person_id"].ToString();
                        tb_firstname = dr["firstname"].ToString();
                        tb_lastname = dr["lastname"].ToString();
                        tb_knownas = dr["knownas"].ToString();
                        tb_birthdate = dr["birthdate"].ToString();
                        dd_gender = dr["gender"].ToString();
                        tb_medical = dr["medical"].ToString();
                        tb_dietry = dr["dietry"].ToString();
                        //tb_facebook = dr["facebook"].ToString();
                        dd_school = dr["school"].ToString();
                        tb_schoolyear = dr["schoolyear"].ToString();
                        tb_residentialaddress = dr["residentialaddress"].ToString();
                        tb_postaladdress = dr["postaladdress"].ToString();
                        tb_emailaddress = dr["emailaddress"].ToString();
                        tb_mobilephone = dr["mobilephone"].ToString();

                        if (tb_birthdate != "")
                        {
                            tb_birthdate = Convert.ToDateTime(tb_birthdate).ToString("dd MMM yy");
                        }


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }                
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region fields
            hf_guid = Request.Form["hf_guid"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_knownas = Request.Form["tb_knownas"].Trim();
            tb_birthdate = Request.Form["tb_birthdate"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_school = Request.Form["dd_school"].Trim();
            tb_schoolyear = Request.Form["tb_schoolyear"].Trim();
            tb_dietry = Request.Form["tb_dietry"].Trim();
            tb_medical = Request.Form["tb_medical"].Trim();
            tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            //tb_facebook = Request.Form["tb_facebook"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_Person";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@knownas", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@birthdate", SqlDbType.VarChar).Value = tb_birthdate;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = dd_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = tb_schoolyear;
            cmd.Parameters.Add("@dietry", SqlDbType.VarChar).Value = tb_dietry;
            cmd.Parameters.Add("@medical", SqlDbType.VarChar).Value = tb_medical;
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@residentialaddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@mobilephone", SqlDbType.VarChar).Value = tb_mobilephone;

            #endregion

            cmd.Connection = con;
            try
            {
                con.Open();
                string result = cmd.ExecuteScalar().ToString();
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

            Response.Redirect("check_acknowledgment.aspx");
        }
    }
}