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
using System.Diagnostics;
using System.Xml.Linq;
using System.Data.SqlTypes;

using Online.Models;
using System.Xml.Xsl;
using System.Text;
using System.Xml;

namespace Online.FoodStallLicence
{
    public partial class FoodStallLicence : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        static string moduleName = "FoodStallLicence";
        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string[] yes_values = new string[1] { "Yes" };
        public string[] yesna_values = new string[2] { "Yes", "N/A" };
        public string[] dd_fundraiser_values = new string[3] { "N/A", "Charitable organisation", "Community group" };
        public string[] dd_fullyear_values = new string[2] { "Specific dates only", "The whole year" };
        public string[] dd_registered_values = new string[4] { "Whanganui District Council", "Another territorial authority", "MPI", "Not registered" };
        #endregion

        #region fields
        public int Entity_CTR;
        public string tb_reference;
        public string dd_fundraiser;
        public string dd_fullyear;
        public string dd_registered;
        public string dd_confirm;
        public string dd_prepackaged;
        public string dd_sick;
        public string dd_pumpsoap;
        public string dd_allergens;
        public string dd_privateland;
        public string dd_councilland;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            if (!Page.IsPostBack)
            {
                string wdcscripts = "";
                if (Request.QueryString["populate"] != null)
                {
                    wdcscripts += "$.getScript('../scripts/wdc/populate.js');";
                }
                if (Request.QueryString["showfields"] != null)
                {
                    wdcscripts += "$.getScript('../scripts/wdc/showfields.js');";
                }
                if (Request.QueryString["showhidden"] != null)
                {
                    wdcscripts += "$.getScript('../scripts/wdc/showhidden.js');";
                }
                if (wdcscripts != "")
                {
                    wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
                }

                if (Session[moduleName + "Submitted"] == "Yes")
                {
                    Session[moduleName + "Submitted"] = "No";
                    Response.Redirect(Request.RawUrl);
                }
                if (Session["online_entity_ctr"] != null)
                {
                    lit_user.Text = "<a href=\"../entity/account.aspx\" target=\"_blank\"><img id=\"usericon\" src=\"http://wdc.whanganui.govt.nz/online/images/user.png\" title=\"Click on me to view/amend your profile, access other information associated to you, and see previous activity.\" /></a>";
                }

                #region Check Entity Entered (Standard)
                //WDCFunctions.Log(Request.RawUrl, "Starting", "");

                if (Session["reference"] != null)
                {
                    String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                    SqlConnection con = new SqlConnection(strConnString);

                    SqlCommand cmd = new SqlCommand("Get_" + moduleName, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = Session["reference"];

                    DataSet ds = new DataSet();
                    DataTable dt = new DataTable();
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(ds);
                    }
                    catch (Exception ex)
                    {
                        //TO DO
                    }
                    finally
                    {
                        con.Close();
                    }

                    dt = ds.Tables[0];
                    //Session["reference"] = "";
                    Session.Remove("reference");

                    tb_reference = dt.Rows[0]["reference"].ToString();
                    //populate fields
                }
                else
                {
                    if (Session["online_entity_ctr"] == null && inhibit_entity != true)
                    {
                        Response.Redirect("../entity/login.aspx?folder=" + folder + "&Form=" + form);
                    }
                    else
                    {
                        tb_reference = WDCFunctions.getReference("datetime");
                    }
                }
                #endregion
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region Function Parameters
            tb_reference = Request.Form["tb_reference"];
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + tb_reference + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference;
            submissionurl = webprotocol + "://" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = moduleName + "Screen.xslt";
            string emailbodyTemplate = moduleName + "Email.xslt";
            string links = "";
            string links_delim = "";
            #endregion

            #region fields
            Entity_CTR = Convert.ToInt32(Session["online_entity_ctr"]);
            dd_fundraiser = Request.Form["dd_fundraiser"];
            #endregion

            #region map
            string[] lineParts;
            string linenumber;

            //string location_save_delim = "";
            string location_display_delim = "";

            string location = "";
            string coords = "";
            string url = "";
            //string location_save = "";
            string location_display = "";
            /* XML
            string userepeatname = "repeat_location_"; // use "" if not repeater
            int userepeatdelimposition = 2; // use 0 if not repeater

            XElement locationsXML = new XElement("locations");
            foreach (string key in Request.Form)
            {
                if (key.StartsWith(userepeatname + "tb_location_"))
                {
                    location = Request.Form[key];
                    lineParts = key.Split('_');
                    linenumber = lineParts[2 + userepeatdelimposition];
                    coords = Request.Form[userepeatname + "hf_locationcoords_" + linenumber];
                    url = webprotocol + "://" + webserver + "/mapping/showlocation.aspx?p=" + coords;

                    //location_save = location_save + location_save_delim + location + "\x00FD" + coords;
                    //location_save_delim = "\x00FE";

                    location_display = location_display + location_display_delim + "<a href=\"" + url + "\" target=\"_blank\">" + location + "</a>";
                    location_display_delim = "<br />";

                    links = links + links_delim + "Location: " + location + "\x00FD" + url;
                    links_delim = "\x00FE";
         

                    XElement locationXML = new XElement("location");
                    locationXML.Add("name", location);
                    locationXML.Add("url", url);

                    locationsXML.Add(locationXML);


                }
          
        } XML */
            #endregion //map

            if (!Directory.Exists(submissionpath))
        {
            Directory.CreateDirectory(submissionpath);
        }

        List<FileClass> FileList = new List<FileClass>();
        #region uploadfiles
        if (!inhibit_upload)
        {
            WDCFunctions.upload(submissionpath, submissionurl, Request.Files, FileList);
            /* XML
            foreach (var file in FileList)
            {
                links = links + links_delim + file.fieldname + ": " + file.name + "\x00FD" + file.url;
                links_delim = "\x00FE";
            }
            XML */
                }
                #endregion

                #region setup for database (Standard)
                String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_" + moduleName + "XML", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            cmd.Parameters.Add("@module_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference;  //Standard
            cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = Entity_CTR;  //Standard
            cmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;  //Standard
            #endregion //setup specific data

            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            WDCFunctions.createXMLStructureWithFiles(repeatertable, Request.Form, FileList, rootXml);
            WDCFunctions.populateXML(repeatertable, rootXml);
            //rootXml.Add(locationsXML);

            /* XML
            WDCFunctions.createXMLStructure(repeatertable, Request.Form, rootXml);
            WDCFunctions.populateXML(repeatertable, rootXml);
            xml */

            #endregion //BuildXML

            cmd.Parameters.Add("@xml", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());

            #region save data (Standard)
            Int32 ctr = 0;
            string RAM_ID = "";
            Int32 RAM_number = 0;
            Int16 RAM_year = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    ctr = Convert.ToInt32(dr["ctr"].ToString());
                    RAM_ID = dr["RAM_ID"].ToString();
                    RAM_number = Convert.ToInt32(dr["RAM_number"]);
                    RAM_year = Convert.ToInt16(dr["RAM_year"]);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion

            rootXml.Add(new XElement("ram_id", RAM_ID));
            //rootXml.Add(new XElement("location",location_display));
            rootXml.Add(new XElement("locationurl", webprotocol + "://" + webserver + "/mapping/showlocation.aspx?p="));

            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = tb_reference;
            documentvalues["ram_id"] = RAM_ID;
            documentvalues["location"] = location_display;
            documentvalues["dd_fundraiser"] = dd_fundraiser;
            documentvalues["dd_registered"] = dd_registered;
            documentvalues["dd_prepackaged"] = dd_prepackaged;

            if (inhibit_entity)
            {
                documentvalues["showentity"] = "False";
            }
            else
            {
                documentvalues["showentity"] = "True";
                WDCFunctions.entityfields(Entity_CTR, documentvalues);
            }
            #endregion //Setup Dictionary Items

            #region set up email, redirection, final processing (Standard)

            /* XML
            string path = Server.MapPath(".");

            // THE SUMMARY DISPLAYED ON THE SCREEN
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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            screendocument = WDCFunctions.documentfillwithRFandFiles(screendocument, documentvalues, Request.Form, FileList, "", repeatertable, "");

            //path = Server.MapPath("~");
            try
            {
                System.IO.Directory.CreateDirectory(submissionpath);
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            emailbodydocument = WDCFunctions.documentfillwithRFandFiles(emailbodydocument, documentvalues, Request.Form, FileList, "", repeatertable, "");

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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            */

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
                WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            //WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion //email

            #region send email
            string emailrecipient = "";
            if (inhibit_entity) { 
                emailrecipient = "greg.tichbon@whanganui.govt.nz"; ;
            }
            else
            {
                emailrecipient = Request.Form["tb_emailaddress"];
            }


            WDCFunctions.sendemail(emailSubject, emaildocument, emailrecipient, emailBCC);
            #endregion

            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);

            //"<pre><code>" + HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) + "</code></pre><br />" + 
            Session["body"] = "<pre><code>" + HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) + "</code></pre><br />" + ScreenOutput.ToString();


            #endregion

            #region create smart list item in hubble

            if (!inhibit_hubble)
            {
                //WDCFunctions.Log(Request.RawUrl, "Add to Hubble", "");
                string siteURL = WebConfigurationManager.AppSettings[moduleName + ".HubbleSiteURL"];
                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
                //WDCFunctions.Log(Request.RawUrl, "http://" + siteURL + "," + RAM_ID.Replace('/', '-') + "," + "0" + "," + RAM_year.ToString() + "," + "Market Food Stall - " + Request.Form["tb_businessname"], "greg.tichbon@whanganui.govt.nz"); 
                HF.createSmartListItem("http://" + siteURL, RAM_ID.Replace('/', '-'), 0, RAM_year.ToString(), "Food Stall - " + Request.Form["tb_organisationname"]);
            }
            #endregion

            #region send email
            if(inhibit_entity)
            {
                Session["online_emailaddress"] = "greg.tichbon@whanganui.govt.nz";
            }
            /* XML
            WDCFunctions.sendemail(emailSubject, emaildocument, Session["online_emailaddress"].ToString(), emailBCC);
            XML */
            #endregion //send email

            /* XML
            Session["body"] = screendocument;
            XML */
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");
        }
    }
}
 