using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using Generic;

namespace UBC.People
{
    public partial class RegisterDisplay : System.Web.UI.Page
    {

        public string tb_firstname;
        public string tb_lastname;
        //public string tb_knownas;
        public string tb_birthdate;
        public string dd_gender;
        public string tb_medical;
        public string tb_dietry;
        public string tb_emailaddress;
        public string tb_homephone;
        public string tb_mobilephone;
        public string dd_school;
        public string dd_schoolyear;
        //public string tb_facebook;
        public string tb_residentialaddress;
        //public string tb_postaladdress;
        public string dd_swimmer;
        public string tb_parentcaregiver1;
        public string tb_parentcaregiver1mobilephone;
        public string tb_parentcaregiver2;
        public string tb_parentcaregiver2mobilephone;
        public string tb_parentcaregiver1emailaddress;
        public string tb_parentcaregiver2emailaddress;

        public string dd_agreement;
        public string dd_correspondence;


        public string[] school = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gender = new string[2] { "Female", "Male" };
        public string[] yesno = new string[2] { "Yes", "No" };
        public string[] schoolyear = new string[5] { "9", "10", "11", "12", "13" };
        public string[] swimmer = new string[2] { "I CAN swim 50 meters in light clothes unassisted", "I CAN NOT swim 50 meters in light clothes unassisted" };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            string id = Request.QueryString["id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_Registration";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = id;


            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    tb_firstname = dr["firstname"].ToString();
                    tb_lastname = dr["lastname"].ToString();
                    //tb_knownas = dr["knownas"].ToString();
                    tb_birthdate = dr["birthdate"].ToString();
                    dd_gender = dr["gender"].ToString();
                    tb_medical = dr["medical"].ToString();
                    tb_dietry = dr["dietry"].ToString();
                    //tb_facebook = dr["facebook"].ToString();
                    dd_school = dr["school"].ToString();
                    dd_schoolyear = dr["schoolyear"].ToString();
                    tb_residentialaddress = dr["residentialaddress"].ToString();
                    //tb_postaladdress = dr["postaladdress"].ToString();
                    tb_emailaddress = dr["emailaddress"].ToString();
                    tb_homephone = dr["homephone"].ToString();
                    tb_mobilephone = dr["mobilephone"].ToString();
                    dd_swimmer = dr["swimmer"].ToString();
                    tb_parentcaregiver1 = dr["parentcaregiver1"].ToString();
                    tb_parentcaregiver1mobilephone = dr["parentcaregiver1_mobilephone"].ToString();
                    tb_parentcaregiver1emailaddress = dr["parentcaregiver1_emailaddress"].ToString();
                    tb_parentcaregiver2 = dr["parentcaregiver2"].ToString();
                    tb_parentcaregiver2mobilephone = dr["parentcaregiver2_mobilephone"].ToString();
                    tb_parentcaregiver2emailaddress = dr["parentcaregiver2_emailaddress"].ToString();
                    dd_agreement = dr["agreement"].ToString();
                    dd_correspondence = dr["correspondence"].ToString();


                    if (tb_birthdate != "")
                    {
                        tb_birthdate = Convert.ToDateTime(tb_birthdate).ToString("dd MMM yyyy");
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
                con.Close();
                con.Dispose();
            }

        }
    }
}
 