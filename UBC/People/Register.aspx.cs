using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
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
        public string guid;
        public string person_id;
        public string firstname;
        public string lastname;
        //public string knownas;
        public string birthdate;
        public string gender;
        public string medical;
        public string dietary;
        public string emailaddress;
        //public string homephone;
        //public string mobilephone;
        public string school;
        public string schoolyear;
        //public string facebook;
        public string residentialaddress;
        //public string postaladdress;
        public string swimmer;
        /*
        public string parentcaregiver1;
        public string parentcaregiver1mobilephone;
        public string parentcaregiver2;
        public string parentcaregiver2mobilephone;
        public string parentcaregiver1emailaddress;
        public string parentcaregiver2emailaddress;
        */
        public string invoicerecipient;
        public string invoicetype;
        public string invoiceaddress;
        public string invoicenote;
        public string membershiptype;
        public string familydiscount;
        public string previousclub;
        public string boatinstorage;

        public string agreement;
        public string correspondence;
        public string html_phone = "";
        public string html_parent = "";


        public int phonectr = 0;
        public int parentctr = 0;
        public int parentphonectr = 0;

        public string season = "2019/20";

        public string[] schoolvalues = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gendervalues = new string[2] { "Female", "Male" };
        public string[] yesnovalues = new string[2] { "Yes", "No" };
        public string[] schoolyearvalues = new string[5] { "9", "10", "11", "12", "13" };
        public string[] swimmervalues = new string[2] { "I CAN swim 50 meters in light clothes unassisted", "I CAN NOT swim 50 meters in light clothes unassisted" };
        public string[] phonetypevalues = new string[4] { "Home", "Work", "Mobile", "Other" };
        //public string[] phonetypevalues = new string[] { };
        public string[] relationshipvalues = new string[4] { "Mother", "Father", "Caregiver", "Other" };
        public string[] invoicetypevalues = new string[3] { "Email", "Mail", "Hand deliver" }; //[4] { "Email", "Text", "Mail", "Hand deliver" };
        public string[] membershipvalues = new string[7] { "Full (Competitive) Membership", "Club Recreation Membership", "Novice Membership", "Coxswain Membership", "Life Membership", "Honorary Membership", "Gym Membership Only" };

        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"] ?? "";
            if (id != "")
            {
                Session["UBC_guid"] = id;
            }
            if (Session["UBC_guid"] == null)
            {
                Response.Redirect("registeraccess.aspx");
            }
            if (!Page.IsPostBack)
            {
                string scripts = "";
                if (Request.QueryString["populate"] != null)
                {
                    scripts += "$.getScript('../Dependencies/populate.js');";
                }
                if (Request.QueryString["showfields"] != null)
                {
                    scripts += "$.getScript('../Dependencies/showfields.js');";
                }
                if (Request.QueryString["showhidden"] != null)
                {
                    scripts += "$.getScript('../Dependencies/showhidden.js');";
                }
                if (scripts != "")
                {
                    scripts = "<script type='text/javascript'>" + scripts + "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", scripts);
                }

                guid = Session["UBC_guid"].ToString(); //   Request.QueryString["id"];


                if (guid != "new")
                {
                    string xml = "";
                    XmlDocument XMLdoc = new XmlDocument();

                    string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "get_last_Registration";
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
                    cmd.Connection = con;

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        xml = dr["xml"].ToString();
                        XMLdoc.LoadXml(xml);

                    }
                    else
                    {
                        dr.Close();

                        cmd.CommandText = "get_person";
                        dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();
                            string person_id = dr["person_id"].ToString();
                            string firstname = dr["firstname"].ToString();
                            string lastname = dr["lastname"].ToString();
                            string birthdate = dr["birthdate"].ToString();
                            string gender = dr["gender"].ToString();
                            string school = dr["school"].ToString();
                            string schoolyear = dr["schoolyear"].ToString();


                            string medical = dr["medical"].ToString();
                            string dietary = dr["dietry"].ToString();
                            string emailaddress = dr["emailaddress"].ToString();
                            string[] emailaddressparts = emailaddress.Split('|');
                            emailaddress = emailaddressparts[0];

                            string residentialaddress = dr["residentialaddress"].ToString();

                            string swimmer = dr["swimmer"].ToString();
                            switch (swimmer)
                            {
                                case "Yes":
                                    swimmer = "I CAN swim 50 meters in light clothes unassisted";
                                    break;
                                case "No":
                                    swimmer = "I CAN NOT swim 50 meters in light clothes unassisted";
                                    break;
                                default:
                                    break;
                            }


                            string invoicerecipient = dr["invoicerecipient"].ToString();
                            string invoicetype = dr["invoiceaddresstype"].ToString();
                            string invoiceaddress = dr["invoiceaddress"].ToString();
                            //string invoicenote = dr["financialnote"].ToString();
                            string membershiptype = dr["feecategory"].ToString();
                            string familydiscount = dr["familymember"].ToString();
                            if (familydiscount != "")
                            {
                                familydiscount = "Yes";
                            }
                            else
                            {
                                familydiscount = "No";
                            }
                            string boatinstorage = dr["boatstorage"].ToString();


                            if (birthdate != "")
                            {
                                birthdate = Convert.ToDateTime(birthdate).ToString("dd MMM yyyy");
                            }

                            dr.Close();

                            cmd.CommandText = "get_person_phone";
                            dr = cmd.ExecuteReader();

                            XElement phonerepeater = new XElement("PhoneRepeater");

                            while (dr.Read())
                            {
                                string phonenumber = dr["Phone"].ToString();

                                XElement phone = new XElement("Phone",
                                    new XElement("number", phonenumber),
                                    new XElement("type"),
                                    new XElement("note")
                                    );

                                phonerepeater.Add(phone);
                            }
                            dr.Close();

                            cmd.CommandText = "get_person_parentcargiver";
                            dr = cmd.ExecuteReader();

                            XElement parentrepeater = new XElement("ParentRepeater");

                            while (dr.Read())
                            {
                                string parentname = dr["name"].ToString();
                                string parentemail = dr["emailaddress"].ToString();
                                string[] parentemailparts = parentemail.Split('|');
                                parentemail = parentemailparts[0];

                                string parentphone = dr["phone"].ToString();

                                XElement parent = new XElement("Parent",
                                     new XElement("name", parentname),
                                     new XElement("relationship"),
                                     new XElement("email", parentemail),
                                     new XElement("note")
                               );

                                //XElement Xparentphone = new XElement("phone");
                                string[] parentphoneparts = parentphone.Split('|');
                                foreach (string part in parentphoneparts)
                                {
                                    XElement Xparentphone = new XElement("Phone",
                                        new XElement("number", part),
                                        new XElement("type"),
                                        new XElement("note")
                                        );
                                    parent.Add(Xparentphone);
                                }

                                parentrepeater.Add(parent);
                            }
                            dr.Close();

                            XDocument Xdoc = new XDocument(new XElement("root",
                                    new XElement("firstname", firstname),
                                    new XElement("lastname", lastname),
                                    new XElement("person_id", person_id),
                                    new XElement("firstname", firstname),
                                    new XElement("lastname", lastname),
                                    new XElement("birthdate", birthdate),
                                    new XElement("gender", gender),
                                    new XElement("school", school),
                                    new XElement("schoolyear", schoolyear),
                                    new XElement("medical", medical),
                                    new XElement("dietary", dietary),
                                    new XElement("emailaddress", emailaddress),
                                    new XElement("residentialaddress", residentialaddress),
                                    new XElement("swimmer", swimmer),
                                    new XElement("invoicerecipient", invoicerecipient),
                                    new XElement("invoicetype", invoicetype),
                                    new XElement("invoiceaddress", invoiceaddress),
                                    new XElement("invoicenote"),
                                    new XElement("membershiptype"),// membershiptype),
                                    new XElement("familydiscount", familydiscount),
                                    new XElement("previousclub"),
                                    new XElement("boatinstorage", boatinstorage),
                                    phonerepeater,
                                    parentrepeater
                               ));


                            using (var xmlReader = Xdoc.CreateReader())
                            {
                                XMLdoc.Load(xmlReader);
                            }
                        }
                        else
                        {
                            Response.Redirect("../usercode.aspx");
                        }
                    }
                    dr.Close();
                    con.Close();
                    con.Dispose();


                    firstname = XMLdoc.DocumentElement.SelectSingleNode("/root/firstname").InnerText;
                    lastname = XMLdoc.DocumentElement.SelectSingleNode("/root/lastname").InnerText;
                    birthdate = XMLdoc.DocumentElement.SelectSingleNode("/root/birthdate").InnerText;
                    gender = XMLdoc.DocumentElement.SelectSingleNode("/root/gender").InnerText;
                    medical = XMLdoc.DocumentElement.SelectSingleNode("/root/medical").InnerText;
                    dietary = XMLdoc.DocumentElement.SelectSingleNode("/root/dietary").InnerText;
                    school = XMLdoc.DocumentElement.SelectSingleNode("/root/school").InnerText;
                    schoolyear = XMLdoc.DocumentElement.SelectSingleNode("/root/schoolyear").InnerText;
                    residentialaddress = XMLdoc.DocumentElement.SelectSingleNode("/root/residentialaddress").InnerText;
                    emailaddress = XMLdoc.DocumentElement.SelectSingleNode("/root/emailaddress").InnerText;
                    swimmer = XMLdoc.DocumentElement.SelectSingleNode("/root/swimmer").InnerText;
                    invoicerecipient = XMLdoc.DocumentElement.SelectSingleNode("/root/invoicerecipient").InnerText;
                    invoicetype = XMLdoc.DocumentElement.SelectSingleNode("/root/invoicetype").InnerText;
                    invoiceaddress = XMLdoc.DocumentElement.SelectSingleNode("/root/invoiceaddress").InnerText;
                    invoicenote = XMLdoc.DocumentElement.SelectSingleNode("/root/invoicenote").InnerText;
                    membershiptype = XMLdoc.DocumentElement.SelectSingleNode("/root/membershiptype").InnerText;
                    familydiscount = XMLdoc.DocumentElement.SelectSingleNode("/root/familydiscount").InnerText;
                    previousclub = XMLdoc.DocumentElement.SelectSingleNode("/root/previousclub").InnerText;
                    boatinstorage = XMLdoc.DocumentElement.SelectSingleNode("/root/boatinstorage").InnerText;

                    XmlNodeList x1 = XMLdoc.SelectNodes("/root/PhoneRepeater/Phone");
                    foreach (XmlNode x2 in x1)
                    {
                        phonectr++;
                        string phonenumber = x2.SelectSingleNode("number").InnerText;
                        string phonetype = x2.SelectSingleNode("type").InnerText;
                        string phonenote = x2.SelectSingleNode("note").InnerText;
                        //html_phone += "<tr><td>" + phonenumber + "</td><td>" + phonetype + "</td><td>" + phonenote + "</td></tr>";


                        html_phone += "<tr>";
                        html_phone += "<td>";
                        html_phone += "<input type=\"text\" class=\"form-control\" name=\"repeat_phone_number_" + phonectr.ToString() + "\" value=\"" + phonenumber + "\" required></td>";
                        html_phone += "<td>";
                        html_phone += "<select class=\"form-control\" name=\"repeat_phone_type_" + phonectr.ToString() + "\" required>";
                        html_phone += "<option></option>";
                        html_phone += Generic.Functions.populateselect(phonetypevalues, phonetype, "None");
                        html_phone += "</select>";
                        html_phone += "</td>";
                        html_phone += "<td>";
                        html_phone += "<input type=\"text\" class=\"form-control\" name=\"repeat_phone_note_" + phonectr.ToString() + "\" value=\"" + phonenote + "\"></td>";
                        html_phone += "<td>";
                        html_phone += "<input type=\"button\" value=\"Remove\" class=\"btn_phone_remove btn btn-info btn-sm\"></td>";
                        html_phone += "</tr>";
                    }

                    XmlNodeList y1 = XMLdoc.SelectNodes("/root/ParentRepeater/Parent");
                    foreach (XmlNode y2 in y1)
                    {
                        parentctr++;
                        string parentname = y2.SelectSingleNode("name").InnerText;
                        string parentrelationship = y2.SelectSingleNode("relationship").InnerText;
                        string parentemail = y2.SelectSingleNode("email").InnerText;
                        string parentnote = y2.SelectSingleNode("note").InnerText;

                        html_parent += "<tr>";
                        html_parent += "<td>";
                        html_parent += "<input type=\"text\" class=\"form-control\" name=\"repeat_parent_name_" + parentctr.ToString() + "\" value=\"" + parentname + "\"  required></td>";
                        html_parent += "<td>";
                        html_parent += "<select class=\"form-control\" name=\"repeat_parent_relationship_" + parentctr.ToString() + "\" value=\"" + parentrelationship + "\" required>";
                        html_parent += "<option></option>";
                        html_parent += Generic.Functions.populateselect(relationshipvalues, parentrelationship, "None");
                        html_parent += "</select>";
                        html_parent += "</td>";
                        html_parent += "<td>";
                        html_parent += "<input type=\"text\" class=\"form-control\" name=\"repeat_parent_email_" + parentctr.ToString() + "\" value=\"" + parentemail + "\" required></td>";
                        html_parent += "<td>";
                        html_parent += "<input type=\"text\" class=\"form-control\" name=\"repeat_parent_note_" + parentctr.ToString() + "\" value=\"" + parentnote + "\"></td>";
                        html_parent += "<td>";
                        html_parent += "<input type=\"button\" value=\"Remove Person\" class=\"btn_parent_remove btn btn-info btn-sm\"></td>";
                        html_parent += "</tr> ";
                        html_parent += "<tr>";
                        html_parent += "<td colspan=\"5\">";
                        html_parent += "<table id=\"tbl_parent_ctr_" + parentctr + "\" class=\"table table-condensed table-bordered\">";
                        html_parent += "<thead>";
                        html_parent += "<tr>";
                        html_parent += "<th>Number</th>";
                        html_parent += "<th>Type</th>";
                        html_parent += "<th>Note</th>";
                        html_parent += "<th style=\"width: 10px\">";
                        html_parent += "<input type=\"button\" class=\"btn_parent_aphone btn btn-info btn-sm\" value=\"Add Phone\"></th>";
                        html_parent += "</tr>";
                        html_parent += "</thead>";
                        html_parent += "<tbody>";

                        XmlNodeList z1 = y2.SelectNodes("Phone");
                        foreach (XmlNode z2 in z1)
                        {
                            parentphonectr++;
                            string parentphonenumber = z2.SelectSingleNode("number").InnerText;
                            string parentphonetype = z2.SelectSingleNode("type").InnerText;
                            string parentphonenote = z2.SelectSingleNode("note").InnerText;

                            html_parent += "<tr>";
                            html_parent += "<td>";
                            html_parent += "<input type=\"text\" class=\"form-control\" name=\"repeat_parent_phone_number_" + parentctr + "_" + parentphonectr + "\" value=\"" + parentphonenumber + "\" required></td>";
                            html_parent += "<td>";
                            html_parent += "<select class=\"form-control\" name=\"repeat_parent_phone_type_" + parentctr + "_" + parentphonectr + "\" required>";
                            html_parent += "<option></option>";
                            html_parent += Generic.Functions.populateselect(phonetypevalues, parentphonetype, "None");
                            html_parent += "</select>";
                            html_parent += "</td>";
                            html_parent += "<td>";
                            html_parent += "<input type=\"text\" class=\"form-control\" name=\"repeat_parent_phone_note_" + parentctr + "_" + parentphonectr + "\" value=\"" + parentphonenote + "\"></td>";
                            html_parent += "<td>";
                            html_parent += "<input type=\"button\" value=\"Remove Phone\" class=\"btn_parent_remove_phone btn btn-info btn-sm\"></td>";
                            html_parent += "</tr>";
                        }
                        html_parent += "</tbody>";
                        html_parent += "</table>";
                        html_parent += "</td>";
                        html_parent += "</tr>";
                    }

                }
                else
                {
                    guid = Guid.NewGuid().ToString();
                }
            }
            
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            Functions functions = new Functions();

            string EmailRecipients = Request.Form["emailaddress"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            repeatertable.Columns.Add("Parent", typeof(string));
            repeatertable.Columns.Add("ParentIndex", typeof(int));
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            string keypartparent = "";
            string keypartparentindex = "";
            string keypartname = "";
            string keypartindex = "";
            string keypartfield = "";

            foreach (string key in Request.Form)
            {
                //if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                if (!key.StartsWith("__") && !key.StartsWith("ctl") && !key.StartsWith("clientsideonly_") && !key.StartsWith("btn_"))
                {
                    if (key.StartsWith("repeat_"))
                    {
                        string[] keyparts = key.Split('_');
                        int keypartscnt = keyparts.Count();

                        switch (keypartscnt)
                        {
                            case 4:
                                keypartparent = "";
                                keypartparentindex = "0";
                                keypartname = keyparts[1];
                                keypartfield = keyparts[2];
                                keypartindex = keyparts[3];
                                break;
                            case 6:
                                keypartparent = keyparts[1];
                                keypartname = keyparts[2];
                                keypartfield = keyparts[3];
                                keypartparentindex = keyparts[4];
                                keypartindex = keyparts[5];
                                break;
                            default:
                                break;

                        }

                        repeatertable.Rows.Add(keypartparent, keypartparentindex, keypartname, keypartindex, keypartfield, Request.Form[key]);
                    }
                    else
                    {
                        rootXml.Add(new XElement(key, Request.Form[key]));
                    }
                }
            }
            rootXml.Add(new XElement("submitted", DateTime.Now.ToString("dd MMM yyyy HH:mm:ss")));

            /*
            string x = "";
            foreach (DataColumn xcol in repeatertable.Columns)
            {
                x += xcol.ColumnName + "|";
            }
            foreach (DataRow xrow in repeatertable.Rows)
            {
                x = "";
                foreach(DataColumn xcol in repeatertable.Columns)
                {
                    x += xrow[xcol.ColumnName] + "|";
                }
                System.Diagnostics.Debug.WriteLine(x);
            }
            */
            string sel = "";

            sel = "[Name] = 'Phone' and [ParentIndex] = 0";
            DataView dv = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
            DataTable dt = dv.ToTable(true, "Index");
            if (dt.Rows.Count > 0)
            {
                XElement repeaterXml = new XElement("PhoneRepeater");

                foreach (DataRow indexrow in dt.Rows)
                {
                    XElement subXml = new XElement("Phone");
                    //subXml.Add(new XElement("Index", indexrow["Index"].ToString()));

                    sel = "[Name] = 'Phone' and [ParentIndex] = 0 and [index] = " + indexrow["Index"];
                    DataView dv4 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                    DataTable dvfields = dv4.ToTable();

                    foreach (DataRow fieldrow in dvfields.Rows)
                    {
                        string field = fieldrow["Field"].ToString();
                        string value = fieldrow["Value"].ToString();
                        subXml.Add(new XElement(field, value));
 
                    }
                    repeaterXml.Add(subXml);
                }
                rootXml.Add(repeaterXml);
            }

            sel = "[Name] = 'Parent'";
            dv = new DataView(repeatertable, sel, "[Index]", DataViewRowState.CurrentRows);
            dt = dv.ToTable(true, "Index");
            if (dt.Rows.Count > 0)
            {
                XElement repeaterXml = new XElement("ParentRepeater");

                foreach (DataRow indexrow in dt.Rows)
                {
                    XElement subXml = new XElement("Parent");
                    //subXml.Add(new XElement("Index", indexrow["Index"].ToString()));

                    sel = "[Name] = 'Parent' and [Index] = " + indexrow["Index"];
                    DataView dv4 = new DataView(repeatertable, sel, "[Index]", DataViewRowState.CurrentRows);
                    DataTable dvfields = dv4.ToTable();

                    foreach (DataRow fieldrow in dvfields.Rows)
                    {
                        string field = fieldrow["Field"].ToString();
                        string value = fieldrow["Value"].ToString();
                        subXml.Add(new XElement(field, value));
                        if (field == "email")
                        {
                            EmailRecipients += ";" + fieldrow["Value"].ToString();
                        }
                    }
                    sel = "[Parent] = 'Parent' and [ParentIndex] = " + indexrow["Index"] + " and [Name] = 'Phone'";
                    DataView dv1 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                    DataTable dt1 = dv1.ToTable(true, "Index");
                    if (dt1.Rows.Count > 0)
                    {

                        XElement repeaterXml2 = new XElement("PhoneRepeater");

                        foreach (DataRow indexrow2 in dt1.Rows)
                        {
                            XElement subXml2 = new XElement("Phone");
                            //subXml2.Add(new XElement("Index", indexrow2["Index"].ToString()));

                            sel = "[Parent] = 'Parent' and [ParentIndex] = " + indexrow["Index"] + " and [Name] = 'Phone' and [index] = " + indexrow2["Index"];
                            DataView dv5 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                            DataTable dvfields2 = dv5.ToTable();
                            foreach (DataRow fieldrow in dvfields2.Rows)
                            {
                                string field = fieldrow["Field"].ToString();
                                string value = fieldrow["Value"].ToString();
                                subXml2.Add(new XElement(field, value));
                            }
                            subXml.Add(subXml2);
                        }
                        repeaterXml.Add(subXml);
                    }
                }
                rootXml.Add(repeaterXml);
            }

            string emailbodyTemplate = "RegisterEmail.xslt";

            string path = Server.MapPath(".");
            XmlDocument reader = new XmlDocument();
            reader.LoadXml(rootXml.ToString());

            XslCompiledTransform EmailXslTrans = new XslCompiledTransform();
            EmailXslTrans.Load(path + "\\" + emailbodyTemplate);

            StringBuilder EmailOutput = new StringBuilder();
            TextWriter EmailWriter = new StringWriter(EmailOutput);

            EmailXslTrans.Transform(reader, null, EmailWriter);
            string emailbodydocument = EmailOutput.ToString();

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

            cmd.CommandText = "Update_Registration";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = Request.Form["guid"].ToString(); ;
            cmd.Parameters.Add("@xml", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());
            cmd.Parameters.Add("@document", SqlDbType.VarChar).Value = emaildocument;

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

            string emailSubject = "Union Boat Club Rower Registration";
            string screenTemplate = "RegisterScreen.xslt";
            //string host = "datainn.co.nz";
            string host = "70.35.207.87";
            string emailfrom = "UnionBoatClub@datainn.co.nz";
            string emailBCC = emailfrom + ";greg@datainn.co.nz;gtichbon@teorahou.org.nz; normcarter@hotmail.com; info@unionboatclub.co.nz; thenielsens@xtra.co.nz";
            string emailfromname = "Union Boat Club";
            string password = "39%3Zxon";
            //string emailRecipient = Request.Form["emailaddress"];

            string emailtext = functions.HTMLtoText(emaildocument);

             //functions.sendemailV2(host, emailfrom, emailfromname, password, emailSubject, emailtext, emaildocument, emailRecipient, emailBCC, "");
            functions.sendemailV3(host, emailfrom, emailfromname, password, emailSubject, emaildocument, EmailRecipients, emailBCC, "");

            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);
            Session["UBC_body"] = ScreenOutput.ToString();
            Response.Redirect("../completed/default.aspx");

        }
    }
}