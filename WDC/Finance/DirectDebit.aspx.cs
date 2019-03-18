using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Online.Finance
{
    public partial class DirectDebit : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static Boolean inhibit_entity = false;
        static Boolean inhibit_hubble = false;

        static string moduleName = "RatesDirectDebit";

        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];
        public string[] dd_bank_values;
        #endregion

        #region fields
        public int Entity_CTR;
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

                    tb_reference.Text = dt.Rows[0]["reference"].ToString();
                    //populate fields
                }
                else
                {
                    if (Session["online_entity_ctr"] == null)
                    {
                        string rq = "";
                        if(Request.QueryString["showfields"] != null)
                        {
                            rq += "&showfields=" + Request.QueryString["showfields"];
                        }
                        if (Request.QueryString["populate"] != null)
                        {
                            rq += "&populate=" + Request.QueryString["populate"];
                        }
                        Response.Redirect("../entity/login.aspx?folder=" + folder + "&Form=" + form + rq);
                    }
                    else
                    {
                        tb_reference.Text = WDCFunctions.getReference("datetime");
                    }
                }
                #endregion
            }
            /*
            List<string> TempList = new List<string>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_banks", con);
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
                        TempList.Add(dr["Description"].ToString() + " (" + dr["Bank_ID"].ToString() + ")");
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
            dd_bank_values = TempList.ToArray();
            */
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
            submissionurl = webprotocol + "://" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = moduleName + "Screen.html";
            string emailbodyTemplate = moduleName + "Email.html";

            #endregion

            #region fields
            Entity_CTR = Convert.ToInt32(Session["online_entity_ctr"]);
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
            cmd.Parameters.Add("@links", SqlDbType.VarChar).Value = "";  //Standard
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

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    ctr = Convert.ToInt32(dr["ctr"].ToString());

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

            screendocument = WDCFunctions.documentfillwithRFandFiles(screendocument, documentvalues, Request.Form, null, "", repeatertable, "");

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

            emailbodydocument = WDCFunctions.documentfillwithRFandFiles(emailbodydocument, documentvalues, Request.Form, null, "", repeatertable, "");

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


            //WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region create smart list item in hubble
            if (!inhibit_hubble)
            {
               // string siteURL = WebConfigurationManager.AppSettings[moduleName + ".HubbleSiteURL"];
                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
                Dictionary<string, string> metaAllFields = new Dictionary<string, string>(2);
                metaAllFields.Add("DocumentType", "CORRESPONDENCE, Email, Memo, Survey");
                metaAllFields.Add("PropertyNo", Request.Form["hf_property_number"]);
                string hubbleurl = WebConfigurationManager.AppSettings["hubbleurl"];
                HF.UploadFile(hubbleurl + "site/corp/rates/", "Activity Management", "actmgt/", "Online direct debit application " + tb_reference.Text + ".html", Encoding.ASCII.GetBytes(emaildocument), metaAllFields);
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