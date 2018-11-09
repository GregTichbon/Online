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
    public partial class Register : System.Web.UI.Page
    {
        public string hf_guid;
        public string hf_person_id;
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
            if(Session["UBC_guid"] == null)
            {
                Response.Redirect("../usercode.aspx");
            }
            hf_guid = Session["UBC_guid"].ToString(); //   Request.QueryString["id"];
           
      
            if (hf_guid != "new")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "get_Registration";
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


                        if (tb_birthdate != "")
                        {
                            tb_birthdate = Convert.ToDateTime(tb_birthdate).ToString("dd MMM yyyy");
                        }
                    } else
                    {
                        Response.Redirect("../usercode.aspx");
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region fields
            //hf_guid = Request.Form["hf_guid"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            //tb_knownas = Request.Form["tb_knownas"].Trim();
            tb_birthdate = Request.Form["tb_birthdate"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_school = Request.Form["dd_school"].Trim();
            dd_schoolyear = Request.Form["dd_schoolyear"].Trim();
            tb_dietry = Request.Form["tb_dietry"].Trim();
            tb_medical = Request.Form["tb_medical"].Trim();
            tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            //tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            //tb_facebook = Request.Form["tb_facebook"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_homephone = Request.Form["tb_homephone"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            dd_swimmer = Request.Form["dd_swimmer"].Trim();

            tb_parentcaregiver1 = Request.Form["tb_parentcaregiver1"].Trim();
            tb_parentcaregiver1mobilephone = Request.Form["tb_parentcaregiver1mobilephone"].Trim();
            tb_parentcaregiver1emailaddress = Request.Form["tb_parentcaregiver1emailaddress"].Trim();
            tb_parentcaregiver2 = Request.Form["tb_parentcaregiver2"].Trim();
            tb_parentcaregiver2mobilephone = Request.Form["tb_parentcaregiver2mobilephone"].Trim();
            tb_parentcaregiver2emailaddress = Request.Form["tb_parentcaregiver2emailaddress"].Trim();

            dd_agreement = Request.Form["dd_agreement"].Trim();
            dd_correspondence = Request.Form["dd_correspondence"].Trim();
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_Registration";
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = hf_person_id;
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            //cmd.Parameters.Add("@knownas", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@birthdate", SqlDbType.VarChar).Value = tb_birthdate;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = dd_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = dd_schoolyear;
            cmd.Parameters.Add("@dietry", SqlDbType.VarChar).Value = tb_dietry;
            cmd.Parameters.Add("@medical", SqlDbType.VarChar).Value = tb_medical;
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@residentialaddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            //cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            //cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@mobilephone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@homephone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@swimmer", SqlDbType.VarChar).Value = dd_swimmer;

            cmd.Parameters.Add("parentcaregiver1", SqlDbType.VarChar).Value = tb_parentcaregiver1;
            cmd.Parameters.Add("parentcaregiver1_mobilephone", SqlDbType.VarChar).Value = tb_parentcaregiver1mobilephone;
            cmd.Parameters.Add("parentcaregiver1_emailaddress", SqlDbType.VarChar).Value = tb_parentcaregiver1emailaddress;
            cmd.Parameters.Add("parentcaregiver2", SqlDbType.VarChar).Value = tb_parentcaregiver2;
            cmd.Parameters.Add("parentcaregiver2_mobilephone", SqlDbType.VarChar).Value = tb_parentcaregiver2mobilephone;
            cmd.Parameters.Add("parentcaregiver2_emailaddress", SqlDbType.VarChar).Value = tb_parentcaregiver2emailaddress;

            cmd.Parameters.Add("@agreement", SqlDbType.VarChar).Value = dd_agreement;
            cmd.Parameters.Add("@correspondence", SqlDbType.VarChar).Value = dd_correspondence;



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


            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            rootXml.Add(new XElement("reference", hf_person_id));

            string[] keynames = new string[11] { "name", "breed1", "breed2", "years", "months", "colour1", "colour2", "gender", "neutered", "chip", "marks" };

            foreach (string key in Request.Form)
            {
                //if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                if (!key.StartsWith("__") && !key.StartsWith("ctl") && !key.StartsWith("clientsideonly_") && !key.StartsWith("btn_"))
                {
                    
                    string[] keyparts = key.Split('_');
                    if (key.StartsWith("item_"))
                    {

                        string ctr = keyparts[2];

                        string[] values = Request.Form[key].Split(new char[] { 'þ' });

                        for (int i = 0; i <= values.Length - 2; i++)
                        {
                            repeatertable.Rows.Add("Dog", ctr, keynames[i], values[i]);
                        }
                    }
                    else
                    {
                        rootXml.Add(new XElement(keyparts[1], Request.Form[key]));
                    }
                }
            }

            Functions functions = new Functions();
            functions.populateXML(repeatertable, rootXml);
            #endregion //BuildXML

            string emailbodyTemplate = "RegisterEmail.xslt";
            string emailSubject = "Union Boat Club Rower Registration";
            string emailBCC = "";
            string screenTemplate = "RegisterScreen.xslt";
            //string host = "datainn.co.nz";
            string host = "70.35.207.87";
            string emailfrom = "ltr@datainn.co.nz";
            string emailfromname = "Union Boat Club";
            string password = "m33t1ng";
            string emailRecipient = "greg@datainn.co.nz; gtichbon@teorahou.org.nz; normcarter@hotmail.com; info@unionboatclub.co.nz; thenielsens@xtra.co.nz";  //info@unionboatclub.co.nz
 

            string path = Server.MapPath(".");
            XmlDocument reader = new XmlDocument();
            reader.LoadXml(rootXml.ToString());

            #region email
            XslCompiledTransform EmailXslTrans = new XslCompiledTransform();
            EmailXslTrans.Load(path + "\\" + emailbodyTemplate);

            StringBuilder EmailOutput = new StringBuilder();
            TextWriter EmailWriter = new StringWriter(EmailOutput);

            EmailXslTrans.Transform(reader, null, EmailWriter);
            string emailbodydocument = EmailOutput.ToString();

            //THE EMAIL TEMPLATE
            string emailtemplate = Server.MapPath("..") + "\\EmailTemplate\\standard.html";
            string emaildocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(emailtemplate))
                {
                    emaildocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");

            }

            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

            string emailtext = functions.HTMLtoText(emaildocument);



            #endregion //email

            #region send email
            //functions.sendemail(emailSubject, emaildocument, "xxxx", emailBCC, "");
            functions.sendemailV2(host, emailfrom, emailfromname, password, emailSubject, emailtext, emaildocument, emailRecipient, emailBCC, "");
            #endregion


            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);


            //save a copy of formatdocument in submissions
            /*
            try
            {
                using (StreamWriter outfile = new StreamWriter(hf_person_id + ".html"))
                {
                    outfile.Write(ScreenOutput.ToString());
                }
            }
            catch (Exception ex)
                       {
                functions.Log(Request.RawUrl, ex.Message,"greg@datainn.co.nz");
            }
            */





            Session["UBC_body"] = ScreenOutput.ToString();
            Response.Redirect("../completed/default.aspx");
        }
    }
}