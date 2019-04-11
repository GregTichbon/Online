﻿using System;
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

namespace Online.HealthPremiseRegistration
{
    public partial class HealthPremiseRegistration : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true; 
        
        static string moduleName = "HealthPremiseRegistration";

        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        public string[] activities = new string[4] { "Hairdresser", "Camping ground", "Funeral home", "Offensive trade"}; //, "Other preparation / manufacture" 
        #endregion

        #region fields
        public int Entity_CTR;
        public string tb_existinglicence;
        public string tb_premisename;
        public string tb_propertyaddress;
        public string tb_premiselocation;
        public string tb_premiseaddress;
        public string dd_activity;
        public string tb_description;
        public string tb_commencementdate;
        public string tb_otherinformation;
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

                    tb_reference.Text = dt.Rows[0]["reference"].ToString();
                    //populate fields
                }
                else
                {
                    if (Session["online_entity_ctr"] == null)
                    {
                        Response.Redirect("../entity/login.aspx?folder=" + folder + "&Form=" + form);
                    }
                    else
                    {
                        tb_reference.Text = WDCFunctions.getReference("datetime");
                    }
                }
                #endregion
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + tb_reference.Text + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
            submissionurl = webprotocol + "://" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = moduleName + "Screen.html";
            string emailbodyTemplate = moduleName + "Email.html";
            string links = "";
            string links_delim = "";
            #endregion

            #region fields
            Entity_CTR = Convert.ToInt32(Session["online_entity_ctr"]);
            #endregion

            #region map
            string[] lineParts;
            string linenumber;

            string location_save_delim = "";
            string location_display_delim = "";

            string location = "";
            string coords = "";
            string url = "";
            string location_save = "";
            string location_display = "";

            foreach (string key in Request.Form)
            {
                if (key.StartsWith("tb_location_"))
                {
                    location = Request.Form[key];
                    lineParts = key.Split('_');
                    linenumber = lineParts[2];
                    coords = Request.Form["hf_locationcoords_" + linenumber];
                    url = webprotocol + "://" + webserver + "/mapping/showlocation.aspx?p=" + coords;

                    location_save = location_save + location_save_delim + location + "\x00FD" + coords;
                    location_save_delim = "\x00FE";

                    location_display = location_display + location_display_delim + "<a href=\"" + url + "\" target=\"_blank\">" + location + "</a>";
                    location_display_delim = "<br />";

                    links = links + links_delim + "Location: " + location + "\x00FD" + url;
                    links_delim = "\x00FE";
                }
            }
            #endregion //map

            List<FileClass> FileList = new List<FileClass>();
            #region uploadfiles
            if (!inhibit_upload)
            {
                WDCFunctions.upload(submissionpath, submissionurl, Request.Files, FileList);
                foreach (var file in FileList)
                {
                    links = links + links_delim + file.fieldname + ": " + file.name + "\x00FD" + file.url;
                    links_delim = "\x00FE";
                }
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
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard
            cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = Entity_CTR;  //Standard
            cmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;  //Standard
            #endregion //setup specific data

            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            WDCFunctions.createXMLStructure(repeatertable, Request.Form, rootXml);
            WDCFunctions.populateXML(repeatertable, rootXml);
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
           
            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = tb_reference.Text;
            documentvalues["ram_id"] = RAM_ID;
            documentvalues["location"] = location_display;

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

            path = Server.MapPath("~");
            try
            {
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
            #endregion

            #region create smart list item in hubble
            if (!inhibit_hubble)
            {
                //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Add to Hubble", "");
                string siteURL = WebConfigurationManager.AppSettings[moduleName + ".HubbleSiteURL"];
                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
                //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "http://" + siteURL + "," + RAM_ID.Replace('/', '-') + "," + "0" + "," + RAM_year.ToString() + "," + "Market Food Stall - " + Request.Form["tb_businessname"], "greg.tichbon@whanganui.govt.nz"); 
                HF.createSmartListItem("http://" + siteURL, RAM_ID.Replace('/', '-'), 0, RAM_year.ToString(), "Health Premise Registration - " + Request.Form["dd_activity"] + " - " + Request.Form["tb_premisename"]);
            }
            #endregion

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, Session["online_emailaddress"].ToString(), emailBCC);
            #endregion //send email

            Session["body"] = screendocument;
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");

        }
    }
}           
