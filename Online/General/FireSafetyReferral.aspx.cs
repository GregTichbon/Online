using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.IO;
using System.Xml;
using System.Xml.Serialization;


namespace Online.General
{
    public partial class FireSafetyReferral : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = "selected";

        static string moduleName = "FireSafetyReferral";
        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };

        string emailaddress = WebConfigurationManager.AppSettings[moduleName + ".emailaddress"];
        string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
        string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];
        //string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        //string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        string screenTemplate = moduleName + "Screen.html";
        string emailbodyTemplate = moduleName + "Email.html";
        #endregion

        #region fields

        public string tb_address;
        public string tb_contact1surname;
        public string tb_contact1firstname;
        public string tb_contact1emailaddress;
        public string tb_contact1emailaddressconfirm;
        public string tb_contact1mobilephone;
        public string tb_contact1homephone;
        public string tb_contact1workphone;
        //public string dd_contact1gender;
        //public string tb_contact1age;
        //public string tb_contact1ethnicity;
        public string tb_contact1role;
        public string cb_secondcontact;
        public string tb_contact2surname;
        public string tb_contact2firstname;
        public string tb_contact2emailaddress;
        public string tb_contact2emailaddressconfirm;
        public string tb_contact2mobilephone;
        public string tb_contact2homephone;
        public string tb_contact2workphone;
        //public string dd_contact2gender;
        //public string tb_contact2age;
        //public string tb_contact2ethnicity;
        public string tb_contact2role;
        public string dd_referraltype;
        public string tb_agencyname;
        public string tb_agencyaddress;
        public string tb_agencyphone;
        public string tb_agencyemailaddress;
        public string tb_agencyemailaddressconfirm;
        public string tb_agencycontact1surname;
        public string tb_agencycontact1firstname;
        public string tb_agencycontact1emailaddress;
        public string tb_agencycontact1emailaddressconfirm;
        public string tb_agencycontact1mobilephone;
        public string tb_agencycontact1officephone;
        public string tb_agencycontact1role;
        public string cb_secondagencycontact;
        public string tb_agencycontact2surname;
        public string tb_agencycontact2firstname;
        public string tb_agencycontact2emailaddress;
        public string tb_agencycontact2emailaddressconfirm;
        public string tb_agencycontact2mobilephone;
        public string tb_agencycontact2officephone;
        public string tb_agencycontact2role;
        public string tb_referrersurname;
        public string tb_referrerfirstname;
        public string tb_referreremailaddress;
        public string tb_referreremailaddressconfirm;
        public string tb_referrermobilephone;
        public string tb_referrerhomephone;
        public string tb_referrerworkphone;
        public string tb_referrerrole;
        public string tb_assistance; 
        public string tb_smokealarms;
        public string tb_smokealarmschecked;
        public string dd_ownedrented;
        public string tb_bedrooms;
        public string tb_people;
        public string tb_under5;
        public string tb_over65;
        public string tb_disabilities;
        public string tb_ethnicity;
        public string dd_communityservicescard;
        public string dd_consent;
        public string dd_civildefenceconsent;

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["populate"] == "True")
            {
                tb_address = "Household Address";
                tb_contact1surname = "tb_contact1surname";
                tb_contact1firstname = "tb_contact1firstname";
                //tb_contact1emailaddress = "tb_contact1emailaddress";
                //tb_contact1emailaddressconfirm = "tb_contact1emailaddressconfirm";
                tb_contact1mobilephone = "tb_contact1mobilephone";
                tb_contact1homephone = "tb_contact1homephone";
                tb_contact1workphone = "tb_contact1workphone";
                //dd_contact1gender = "dd_contact1gender";
                //tb_contact1age = "tb_contact1age";
                //tb_contact1ethnicity = "tb_contact1ethnicity";
                tb_contact1role = "tb_contact1role";
                cb_secondcontact = "cb_secondcontact";
                tb_contact2surname = "tb_contact2surname";
                tb_contact2firstname = "tb_contact2firstname";
                tb_contact2emailaddress = "tb_contact2emailaddress";
                tb_contact2emailaddressconfirm = "tb_contact2emailaddressconfirm";
                tb_contact2mobilephone = "tb_contact2mobilephone";
                tb_contact2homephone = "tb_contact2homephone";
                tb_contact2workphone = "tb_contact2workphone";
                //dd_contact2gender = "dd_contact2gender";
                //tb_contact2age = "tb_contact2age";
                //tb_contact2ethnicity = "tb_contact2ethnicity";
                tb_contact2role = "tb_contact2role";
                //dd_referraltype = "dd_referraltype";
                tb_agencyname = "tb_agencyname";
                tb_agencyaddress = "tb_agencyaddress";
                tb_agencyphone = "tb_agencyphone";
                tb_agencyemailaddress = "tb_agencyemailaddress";
                tb_agencyemailaddressconfirm = "tb_agencyemailaddressconfirm";
                tb_agencycontact1surname = "tb_agencycontact1surname";
                tb_agencycontact1firstname = "tb_agencycontact1firstname";
                tb_agencycontact1emailaddress = "tb_agencycontact1emailaddress";
                tb_agencycontact1emailaddressconfirm = "tb_agencycontact1emailaddressconfirm";
                tb_agencycontact1mobilephone = "tb_agencycontact1mobilephone";
                tb_agencycontact1officephone = "tb_agencycontact1officephone";
                tb_agencycontact1role = "tb_agencycontact1role";
                cb_secondagencycontact = "cb_secondagencycontact";
                tb_agencycontact2surname = "tb_agencycontact2surname";
                tb_agencycontact2firstname = "tb_agencycontact2firstname";
                tb_agencycontact2emailaddress = "tb_agencycontact2emailaddress";
                tb_agencycontact2emailaddressconfirm = "tb_agencycontact2emailaddressconfirm";
                tb_agencycontact2mobilephone = "tb_agencycontact2mobilephone";
                tb_agencycontact2officephone = "tb_agencycontact2officephone";
                tb_agencycontact2role = "tb_agencycontact2role";
                tb_referrersurname = "tb_referrersurname";
                tb_referrerfirstname = "tb_referrerfirstname";
                tb_referreremailaddress = "tb_referreremailaddress";
                tb_referreremailaddressconfirm = "tb_referreremailaddressconfirm";
                tb_referrermobilephone = "tb_referrermobilephone";
                tb_referrerhomephone = "tb_referrerhomephone";
                tb_referrerworkphone = "tb_referrerworkphone";
                tb_referrerrole = "tb_referrerrole";
                tb_assistance = "tb_assistance";
                tb_smokealarms = "tb_smokealarms";
                tb_smokealarmschecked = "tb_smokealarmschecked";
                //dd_ownedrented = "dd_ownedrented";
                tb_bedrooms = "tb_bedrooms";
                tb_people = "tb_people";
                tb_under5 = "tb_under5";
                tb_over65 = "tb_over65";
                tb_disabilities = "tb_disabilities";
                tb_ethnicity = "tb_ethnicity";
                //dd_communityservicescard = "dd_communityservicescard";

                //dd_consent = "dd_consent";



            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            /*
            foreach (string key in Request.Form.Keys)
            {
                if(key.Substring(0,2) != "__") {
                    Response.Write(key + "=" + Request.Form[key] + "<br />");
                }
            }
            */

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            #endregion

            string reference = WDCFunctions.WDCFunctions.getReference("datetime");

            #region fields
            tb_address = Request.Form["tb_address"];
            tb_contact1surname = Request.Form["tb_contact1surname"];
            tb_contact1firstname = Request.Form["tb_contact1firstname"];
            tb_contact1emailaddress = Request.Form["tb_contact1emailaddress"];
            tb_contact1mobilephone = Request.Form["tb_contact1mobilephone"];
            tb_contact1homephone = Request.Form["tb_contact1homephone"];
            tb_contact1workphone = Request.Form["tb_contact1workphone"];
            //dd_contact1gender = Request.Form["dd_contact1gender"];
            //tb_contact1age = Request.Form["tb_contact1age"];
            //tb_contact1ethnicity = Request.Form["tb_contact1ethnicity"];
            tb_contact1role = Request.Form["tb_contact1role"];
            cb_secondcontact = Request.Form["cb_secondcontact"];
            tb_contact2surname = Request.Form["tb_contact2surname"];
            tb_contact2firstname = Request.Form["tb_contact2firstname"];
            tb_contact2emailaddress = Request.Form["tb_contact2emailaddress"];
            tb_contact2mobilephone = Request.Form["tb_contact2mobilephone"];
            tb_contact2homephone = Request.Form["tb_contact2homephone"];
            tb_contact2workphone = Request.Form["tb_contact2workphone"];
            //dd_contact2gender = Request.Form["dd_contact2gender"];
            //tb_contact2age = Request.Form["tb_contact2age"];
            //tb_contact2ethnicity = Request.Form["tb_contact2ethnicity"];
            tb_contact2role = Request.Form["tb_contact2role"];
            dd_referraltype = Request.Form["dd_referraltype"];
            tb_agencyname = Request.Form["tb_agencyname"];
            tb_agencyaddress = Request.Form["tb_agencyaddress"];
            tb_agencyphone = Request.Form["tb_agencyphone"];
            tb_agencyemailaddress = Request.Form["tb_agencyemailaddress"];
            tb_agencycontact1surname = Request.Form["tb_agencycontact1surname"];
            tb_agencycontact1firstname = Request.Form["tb_agencycontact1firstname"];
            tb_agencycontact1emailaddress = Request.Form["tb_agencycontact1emailaddress"];
            tb_agencycontact1mobilephone = Request.Form["tb_agencycontact1mobilephone"];
            tb_agencycontact1officephone = Request.Form["tb_agencycontact1officephone"];
            tb_agencycontact1role = Request.Form["tb_agencycontact1role"];
            cb_secondagencycontact = Request.Form["cb_secondagencycontact"];
            tb_agencycontact2surname = Request.Form["tb_agencycontact2surname"];
            tb_agencycontact2firstname = Request.Form["tb_agencycontact2firstname"];
            tb_agencycontact2emailaddress = Request.Form["tb_agencycontact2emailaddress"];
            tb_agencycontact2mobilephone = Request.Form["tb_agencycontact2mobilephone"];
            tb_agencycontact2officephone = Request.Form["tb_agencycontact2officephone"];
            tb_agencycontact2role = Request.Form["tb_agencycontact2role"];
            tb_referrersurname = Request.Form["tb_referrersurname"];
            tb_referrerfirstname = Request.Form["tb_referrerfirstname"];
            tb_referreremailaddress = Request.Form["tb_referreremailaddress"];
            tb_referrermobilephone = Request.Form["tb_referrermobilephone"];
            tb_referrerhomephone = Request.Form["tb_referrerhomephone"];
            tb_referrerworkphone = Request.Form["tb_referrerworkphone"];
            tb_referrerrole = Request.Form["tb_referrerrole"];
            tb_assistance = Request.Form["tb_assistance"];
            tb_smokealarms = Request.Form["tb_smokealarms"];
            tb_smokealarmschecked = Request.Form["tb_smokealarmschecked"];
            dd_ownedrented = Request.Form["dd_ownedrented"];
            tb_bedrooms = Request.Form["tb_bedrooms"];
            tb_people = Request.Form["tb_people"];
            tb_under5 = Request.Form["tb_under5"];
            tb_over65 = Request.Form["tb_over65"];
            tb_disabilities = Request.Form["tb_disabilities"];
            tb_ethnicity = Request.Form["tb_ethnicity"];
            dd_communityservicescard = Request.Form["dd_communityservicescard"];
            dd_consent = Request.Form["dd_consent"];
            dd_civildefenceconsent = Request.Form["dd_civildefenceconsent"];

            #endregion



            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>();

            //foreach (string key in Request.Form.Keys)
            //{
            //    Debug.WriteLine(key + "=" + Request.Form[key]);
            //}

            documentvalues["reference"] = reference;
            documentvalues["tb_address"] = tb_address;
            documentvalues["tb_contact1surname"] = tb_contact1surname;
            documentvalues["tb_contact1firstname"] = tb_contact1firstname;
            documentvalues["tb_contact1emailaddress"] = tb_contact1emailaddress;
            documentvalues["tb_contact1emailaddressconfirm"] = tb_contact1emailaddressconfirm;
            documentvalues["tb_contact1mobilephone"] = tb_contact1mobilephone;
            documentvalues["tb_contact1homephone"] = tb_contact1homephone;
            documentvalues["tb_contact1workphone"] = tb_contact1workphone;
            //documentvalues["dd_contact1gender"] = dd_contact1gender;
            //documentvalues["tb_contact1age"] = tb_contact1age;
            //documentvalues["tb_contact1ethnicity"] = tb_contact1ethnicity;
            documentvalues["tb_contact1role"] = tb_contact1role;
            documentvalues["cb_secondcontact"] = cb_secondcontact;
            documentvalues["tb_contact2surname"] = tb_contact2surname;
            documentvalues["tb_contact2firstname"] = tb_contact2firstname;
            documentvalues["tb_contact2emailaddress"] = tb_contact2emailaddress;
            documentvalues["tb_contact2emailaddressconfirm"] = tb_contact2emailaddressconfirm;
            documentvalues["tb_contact2mobilephone"] = tb_contact2mobilephone;
            documentvalues["tb_contact2homephone"] = tb_contact2homephone;
            documentvalues["tb_contact2workphone"] = tb_contact2workphone;
            //documentvalues["dd_contact2gender"] = dd_contact2gender;
            //documentvalues["tb_contact2age"] = tb_contact2age;
            //documentvalues["tb_contact2ethnicity"] = tb_contact2ethnicity;
            documentvalues["tb_contact2role"] = tb_contact2role;
            documentvalues["dd_referraltype"] = dd_referraltype;
            documentvalues["tb_agencyname"] = tb_agencyname;
            documentvalues["tb_agencyaddress"] = tb_agencyaddress;
            documentvalues["tb_agencyphone"] = tb_agencyphone;
            documentvalues["tb_agencyemailaddress"] = tb_agencyemailaddress;
            documentvalues["tb_agencyemailaddressconfirm"] = tb_agencyemailaddressconfirm;
            documentvalues["tb_agencycontact1surname"] = tb_agencycontact1surname;
            documentvalues["tb_agencycontact1firstname"] = tb_agencycontact1firstname;
            documentvalues["tb_agencycontact1emailaddress"] = tb_agencycontact1emailaddress;
            documentvalues["tb_agencycontact1emailaddressconfirm"] = tb_agencycontact1emailaddressconfirm;
            documentvalues["tb_agencycontact1mobilephone"] = tb_agencycontact1mobilephone;
            documentvalues["tb_agencycontact1officephone"] = tb_agencycontact1officephone;
            documentvalues["tb_agencycontact1role"] = tb_agencycontact1role;
            documentvalues["cb_secondagencycontact"] = cb_secondagencycontact;
            documentvalues["tb_agencycontact2surname"] = tb_agencycontact2surname;
            documentvalues["tb_agencycontact2firstname"] = tb_agencycontact2firstname;
            documentvalues["tb_agencycontact2emailaddress"] = tb_agencycontact2emailaddress;
            documentvalues["tb_agencycontact2emailaddressconfirm"] = tb_agencycontact2emailaddressconfirm;
            documentvalues["tb_agencycontact2mobilephone"] = tb_agencycontact2mobilephone;
            documentvalues["tb_agencycontact2officephone"] = tb_agencycontact2officephone;
            documentvalues["tb_agencycontact2role"] = tb_agencycontact2role;
            documentvalues["tb_referrersurname"] = tb_referrersurname;
            documentvalues["tb_referrerfirstname"] = tb_referrerfirstname;
            documentvalues["tb_referreremailaddress"] = tb_referreremailaddress;
            documentvalues["tb_referreremailaddressconfirm"] = tb_referreremailaddressconfirm;
            documentvalues["tb_referrermobilephone"] = tb_referrermobilephone;
            documentvalues["tb_referrerhomephone"] = tb_referrerhomephone;
            documentvalues["tb_referrerworkphone"] = tb_referrerworkphone;
            documentvalues["tb_referrerrole"] = tb_referrerrole;
            documentvalues["tb_assistance"] = tb_assistance;
            documentvalues["tb_smokealarms"] = tb_smokealarms;
            documentvalues["tb_smokealarmschecked"] = tb_smokealarmschecked;
            documentvalues["dd_ownedrented"] = dd_ownedrented;
            documentvalues["tb_bedrooms"] = tb_bedrooms;
            documentvalues["tb_people"] = tb_people;
            documentvalues["tb_under5"] = tb_under5;
            documentvalues["tb_over65"] = tb_over65;
            documentvalues["tb_disabilities"] = tb_disabilities;
            documentvalues["tb_ethnicity"] = tb_ethnicity;
            documentvalues["dd_communityservicescard"] = dd_communityservicescard;
            documentvalues["dd_consent"] = dd_consent;
            documentvalues["dd_civildefenceconsent"] = dd_civildefenceconsent;

         

            //Uri MyUrl = Request.Url;
            //Response.Write(MyUrl.Scheme + "://" + MyUrl.Authority + "/Payment/default.aspx");
            //documentvalues["PaymentReference"] = MyUrl.Scheme + "://" + MyUrl.Authority + "/Payment?reference=" + paymentreference;
            #endregion

            #region set up email, redirection, final processing (Standard)
            string path = Server.MapPath(".");

            // THE SUMMARY DISPLAYED ON THE EMAIL
            string screenpath = path + "\\" + screenTemplate;
            string screendocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(screenpath))
                {
                    screendocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
            screendocument = a.documentfill(screendocument, documentvalues);
         
            
            //save a copy of formatdocument in submissions
            path = Server.MapPath("~");
            try
            {
                using (StreamWriter outfile = new StreamWriter(submissionpath + reference + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            // THE EMAIL
            path = Server.MapPath(".");
            string emailbodypath = path + "\\" + emailbodyTemplate;
            string emailbodydocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(emailbodypath))
                {
                    emailbodydocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

         
            emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

            //THE EMAIL TEMPLATE
            path = Server.MapPath("..");
            string emailtemplate = path + "\\EmailTemplate\\standard.html";
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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region send email

            string[] otheremailaddresses = new string[6] { "tb_contact1emailaddress","tb_contact2emailaddress","tb_agencyemailaddress","tb_agencycontact1emailaddress","tb_agencycontact2emailaddress","tb_referreremailaddress"};

            foreach (string otheremailaddress in otheremailaddresses) {
                if (documentvalues[otheremailaddress] != "")
                {
                    emailaddress = emailaddress + ";" + documentvalues[otheremailaddress];
                }
            } 

            WDCFunctions.WDCFunctions.sendemail(emailSubject, emaildocument, emailaddress, emailBCC);

            
            Session["body"] = screendocument;
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");
            #endregion



        }

        private void SerializeElement(string filename)
        {
            XmlSerializer ser = new XmlSerializer(typeof(XmlElement));
            XmlElement myElement =  new XmlDocument().CreateElement("MyElement", "ns");
            myElement.InnerText = "Hello World";
            TextWriter writer = new StreamWriter(filename);
            ser.Serialize(writer, myElement);
            writer.Close();
        }

        private void SerializeNode(string filename)
        {
            XmlSerializer ser = new XmlSerializer(typeof(XmlNode));
            XmlNode myNode = new XmlDocument().
            CreateNode(XmlNodeType.Element, "MyNode", "ns");
            myNode.InnerText = "Hello Node";
            TextWriter writer = new StreamWriter(filename);
            ser.Serialize(writer, myNode);
            writer.Close();
        }
    }
}