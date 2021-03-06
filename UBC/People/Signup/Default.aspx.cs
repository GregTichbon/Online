﻿using System;
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

namespace UBC.People.Signup
{
    public partial class Default : System.Web.UI.Page
    {
        public string hf_guid = "";
        public string hf_signup_ctr;
        public string signupprogram_ctr = "3";
        public string tb_firstname;
        public string tb_lastname;
        public string tb_knownas;
        public string tb_birthdate;
        public string dd_gender = "";
        //public string tb_medical;
        //public string tb_dietry;
        public string tb_emailaddress;
        public string tb_homephone;
        public string tb_mobilephone;
        public string dd_school = "";
        public string dd_schoolyear = "";
        //public string tb_facebook;
        //public string tb_residentialaddress;
        //public string tb_postaladdress;
        public string dd_swimmer = "";
        public string tb_parentcaregiver1;
        public string tb_parentcaregiver1mobilephone;
        public string tb_parentcaregiver1emailaddress;
        public string tb_parentcaregiver1phone;
        public string tb_parentcaregiver2;
        public string tb_parentcaregiver2mobilephone;
        public string tb_parentcaregiver2emailaddress;
        public string tb_notes;
        public string tb_parentcaregiver1relationship;
        public string tb_parentcaregiver2relationship;
        public string tb_parentcaregiver1homephone;
        public string tb_parentcaregiver2homephone;
        public string tb_parentcaregivercomments;

        public string uploadphoto = " style=\"display:none\"";

        //public string dd_agreement;
        //public string dd_correspondence;


        public string[] school = new string[5] { "None", "City College", "Cullinane", "Girls College", "Other" };
        public string[] gender = new string[2] { "Female", "Male" };
        public string[] yesno = new string[2] { "Yes", "No" };
        public string[] schoolyear = new string[5] { "9", "10", "11", "12", "13" };
        public string[] swimmer = new string[2] { "I CAN swim 50 meters in light clothes unassisted", "I CAN NOT swim 50 meters in light clothes unassisted" };

        protected void Page_Load(object sender, EventArgs e)
        {

            hf_guid = Request.QueryString["id"] + "";
            if (hf_guid != "")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "get_signup";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                cmd.Connection = con;
                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        hf_signup_ctr = dr["signup_ctr"].ToString();
                        hf_guid = dr["guid"].ToString();

                        uploadphoto = "";

                        signupprogram_ctr = dr["signupprogram_ctr"].ToString();

                        tb_firstname = dr["firstname"].ToString();
                        tb_lastname = dr["lastname"].ToString();
                        tb_knownas = dr["knownas"].ToString();
                        tb_birthdate = dr["birthdate"].ToString();
                        dd_gender = dr["gender"].ToString();
                        //tb_medical = dr["medical"].ToString();
                        //tb_dietry = dr["dietry"].ToString();
                        //tb_facebook = dr["facebook"].ToString();
                        dd_school = dr["school"].ToString();
                        dd_schoolyear = dr["schoolyear"].ToString();
                        //tb_residentialaddress = dr["residentialaddress"].ToString();
                        //tb_postaladdress = dr["postaladdress"].ToString();
                        tb_emailaddress = dr["emailaddress"].ToString();
                        tb_homephone = dr["homephone"].ToString();
                        tb_mobilephone = dr["mobilephone"].ToString();
                        dd_swimmer = dr["swimmer"].ToString();
                        tb_notes = dr["notes"].ToString();

                        tb_parentcaregiver1 = dr["parentcaregiver1"].ToString();
                        tb_parentcaregiver1relationship = dr["parentcaregiver1_relationship"].ToString();
                        tb_parentcaregiver1mobilephone = dr["parentcaregiver1_mobile"].ToString();
                        tb_parentcaregiver1homephone = dr["parentcaregiver1_home"].ToString();
                        tb_parentcaregiver1emailaddress = dr["parentcaregiver1_email"].ToString();
                        tb_parentcaregiver2 = dr["parentcaregiver2"].ToString();
                        tb_parentcaregiver2relationship = dr["parentcaregiver2_relationship"].ToString();
                        tb_parentcaregiver2mobilephone = dr["parentcaregiver2_mobile"].ToString();
                        tb_parentcaregiver2homephone = dr["parentcaregiver2_home"].ToString();
                        tb_parentcaregiver2emailaddress = dr["parentcaregiver2_email"].ToString();

                        tb_parentcaregivercomments = dr["parentcaregiver_comments"].ToString();
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            Boolean sendEmail = false;
            Boolean sendText = false;

            Functions gfunctions = new Functions();

            if (hf_guid == "")
            {
                hf_guid = gfunctions.getReference();
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region fields
            //hf_guid = Request.Form["hf_guid"].Trim();

            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_knownas = Request.Form["tb_knownas"].Trim();
            tb_birthdate = Request.Form["tb_birthdate"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_school = Request.Form["dd_school"].Trim();
            dd_schoolyear = Request.Form["dd_schoolyear"].Trim();
            //tb_dietry = Request.Form["tb_dietry"].Trim();
            //tb_medical = Request.Form["tb_medical"].Trim();
            //tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            //tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            //tb_facebook = Request.Form["tb_facebook"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            //tb_homephone = Request.Form["tb_homephone"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            tb_homephone = Request.Form["tb_homephone"].Trim();
            dd_swimmer = Request.Form["dd_swimmer"].Trim();
            tb_notes = Request.Form["tb_notes"].Trim();

            tb_parentcaregiver1 = Request.Form["tb_parentcaregiver1"].Trim();
            tb_parentcaregiver1relationship = Request.Form["tb_parentcaregiver1relationship"].Trim();
            //tb_parentcaregiver1phone = Request.Form["tb_parentcaregiver1phone"].Trim();
            tb_parentcaregiver1mobilephone = Request.Form["tb_parentcaregiver1mobilephone"].Trim();
            tb_parentcaregiver1homephone = Request.Form["tb_parentcaregiver1homephone"].Trim();
            tb_parentcaregiver1emailaddress = Request.Form["tb_parentcaregiver1emailaddress"].Trim();

            tb_parentcaregiver2 = Request.Form["tb_parentcaregiver2"].Trim();
            tb_parentcaregiver2relationship = Request.Form["tb_parentcaregiver2relationship"].Trim();
            tb_parentcaregiver2mobilephone = Request.Form["tb_parentcaregiver2mobilephone"].Trim();
            tb_parentcaregiver2homephone = Request.Form["tb_parentcaregiver2homephone"].Trim();
            tb_parentcaregiver2emailaddress = Request.Form["tb_parentcaregiver2emailaddress"].Trim();

            tb_parentcaregivercomments = Request.Form["tb_parentcaregivercomments"].Trim();
            //dd_agreement = Request.Form["dd_agreement"].Trim();
            //dd_correspondence = Request.Form["dd_correspondence"].Trim();

            #endregion

            #region setup specific data
            cmd.CommandText = "Update_signup";
            cmd.Parameters.Add("@signupprogram_ctr", SqlDbType.VarChar).Value = signupprogram_ctr;

            cmd.Parameters.Add("@signup_ctr", SqlDbType.VarChar).Value = hf_signup_ctr;
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@knownas", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@birthdate", SqlDbType.VarChar).Value = tb_birthdate;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = dd_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = dd_schoolyear;
            //cmd.Parameters.Add("@dietry", SqlDbType.VarChar).Value = tb_dietry;
            //cmd.Parameters.Add("@medical", SqlDbType.VarChar).Value = tb_medical;
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = dd_gender;
            //cmd.Parameters.Add("@residentialaddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            //cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            //cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@mobilephone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@homephone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@swimmer", SqlDbType.VarChar).Value = dd_swimmer;
            cmd.Parameters.Add("@notes", SqlDbType.VarChar).Value = tb_notes;

            cmd.Parameters.Add("parentcaregiver1", SqlDbType.VarChar).Value = tb_parentcaregiver1;
            cmd.Parameters.Add("parentcaregiver1relationship", SqlDbType.VarChar).Value = tb_parentcaregiver1relationship;
            //cmd.Parameters.Add("parentcaregiver1_phone", SqlDbType.VarChar).Value = tb_parentcaregiver1phone;
            cmd.Parameters.Add("parentcaregiver1_homephone", SqlDbType.VarChar).Value = tb_parentcaregiver1homephone;
            cmd.Parameters.Add("parentcaregiver1_mobilephone", SqlDbType.VarChar).Value = tb_parentcaregiver1mobilephone;
            cmd.Parameters.Add("parentcaregiver1_emailaddress", SqlDbType.VarChar).Value = tb_parentcaregiver1emailaddress;

            cmd.Parameters.Add("parentcaregiver2", SqlDbType.VarChar).Value = tb_parentcaregiver2;
            cmd.Parameters.Add("parentcaregiver2relationship", SqlDbType.VarChar).Value = tb_parentcaregiver2relationship;
            cmd.Parameters.Add("parentcaregiver2_mobilephone", SqlDbType.VarChar).Value = tb_parentcaregiver2mobilephone;
            cmd.Parameters.Add("parentcaregiver2_homephone", SqlDbType.VarChar).Value = tb_parentcaregiver2homephone;
            cmd.Parameters.Add("parentcaregiver2_emailaddress", SqlDbType.VarChar).Value = tb_parentcaregiver2emailaddress;

            cmd.Parameters.Add("parentcaregivercomments", SqlDbType.VarChar).Value = tb_parentcaregivercomments;

            //cmd.Parameters.Add("@agreement", SqlDbType.VarChar).Value = dd_agreement;
            //cmd.Parameters.Add("@correspondence", SqlDbType.VarChar).Value = dd_correspondence;





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

            if (1 == 2)
            {

                #region BuildXML
                XElement rootXml = new XElement("root");
                DataTable repeatertable = new DataTable("Repeater");

                repeatertable.Columns.Add("Name", typeof(string));
                repeatertable.Columns.Add("Index", typeof(int));
                repeatertable.Columns.Add("Field", typeof(string));
                repeatertable.Columns.Add("Value", typeof(string));

                rootXml.Add(new XElement("reference", hf_signup_ctr));

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

                string emailbodyTemplate = "SignupEmail.xslt";
                string emailSubject = "Union Boat Club Rower Registration";
                string emailBCC = "";
                string screenTemplate = "RegisterScreen.xslt";
                //string host = "datainn.co.nz";
                string host = "70.35.207.87";
                string emailfrom = "ltr@datainn.co.nz";
                string emailfromname = "Union Boat Club";
                string password = "m33t1ng";
                string emailRecipient = "greg@datainn.co.nz; gtichbon@teorahou.org.nz; info@unionboatclub.co.nz; thenielsens@xtra.co.nz";  //info@unionboatclub.co.nz


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
                    functions.Log("", Request.RawUrl, ex.Message, "greg@datainn.co.nz");

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

            if (sendText)
            {
                string messageresponse = gfunctions.SendRemoteMessage("0272495088", "'Interested in Rowing' registration: " + tb_firstname + " " + tb_lastname + " " + dd_school, "'Interested in Rowing' registration");
                if (tb_mobilephone != "")
                {
                    //string message = "Hi " + tb_firstname + "\r\nThanks for registering for the Union Boat Club Schools Learn to Row weekend on Friday 23 - Sunday 25 August.\r\nInformation can be found at: <a href=\"https://ubc.org.nz/learntorow/SchoolLearntoRowAug2019.pdf\">ubc.org.nz/learntorow/SchoolLearntoRowAug2019.pdf</a>";
                    string message = "Hi " + tb_firstname + "\r\nThanks for registering for the Union Boat Club Schools Learn to Row weekend on Friday 23 - Sunday 25 August.\r\nInformation can be found at: https://ubc.org.nz/learntorow/SchoolLearntoRowAug2019.pdf";
                    //message = HttpUtility.UrlEncode(message);
                    messageresponse = gfunctions.SendRemoteMessage(tb_mobilephone, message, "Interested in ");
                }
            }
            if (sendEmail)
            {
                if (tb_emailaddress != "" || tb_parentcaregiver1emailaddress != "" || tb_parentcaregiver2emailaddress != "")
                {
                    string emailRecipients = tb_emailaddress + "; " + tb_parentcaregiver1emailaddress + "; " + tb_parentcaregiver2emailaddress;
                    string host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
                    string emailfrom = "info@unionboatclub.co.nz";
                    string password = "R0wtheboat";
                    int port = 587; // 465; // 25;
                    Boolean enableSsl = true;
                    string emailBCC = "greg@datainn.co.nz";
                    string emailfromname = "Union Boat Club";
                    string emailSubject = "Union Boat Club Rower Registration";

                    string[] attachments = new string[0];
                    Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                    string emaildocument = "<p>Hi " + tb_firstname + "</p><p>Thanks for registering your interest in rowing.</p>"; 
                    //<p>Information can be found at: <a href=\"https://ubc.org.nz/learntorow/SchoolLearntoRowAug2019.pdf\">ubc.org.nz/learntorow/SchoolLearntoRowAug2019.pdf</a></p><p>You can contact us on 0800 002 541 if you have any questions.</p>"; ;
                    emaildocument = "<html><head></head><body>" + emaildocument + "</body></html>";

                    gfunctions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailSubject, emaildocument, emailRecipients, emailBCC, "", attachments, emailoptions);

                }
            }


            Response.Redirect("complete.aspx");
        }

    }
}