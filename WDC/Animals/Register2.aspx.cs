using Online.Models;
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
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;

namespace Online.Animals
{
    public partial class Register2 : System.Web.UI.Page
    {

        static string moduleName = "Animals";

        #region fields

        public string breeds;
        public string colours;
        #endregion

        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };
        public string[] doggenders = new string[2] { "Female", "Male" };

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

                tb_reference.Text = WDCFunctions.getReference("datetime");

                String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;

                Dictionary<string, string> breeds_options = new Dictionary<string, string>();
                breeds_options["usevalues"] = "";
                breeds_options["selecttype"] = "Value";
                breeds_options["storedprocedure"] = "";
                breeds = WDCFunctions.buildandpopulateselect(strConnString, "select DESCRIPTION + ' (' + rtrim([DESCRIPTOR_VALUE]) + ')' as [Value], DESCRIPTION as [Label] from @@nucdescriptor where DESCRIPTOR_TYPE = '#ANIBRD' order by [description]", "", breeds_options);

                Dictionary<string, string> colours_options = new Dictionary<string, string>();
                colours_options["usevalues"] = "";
                colours_options["selecttype"] = "Value";
                colours_options["storedprocedure"] = "";
                colours = WDCFunctions.buildandpopulateselect(strConnString, "select DESCRIPTION + ' (' + rtrim([DESCRIPTOR_VALUE]) + ')' as [Value], DESCRIPTION as [Label] from @@nucdescriptor where DESCRIPTOR_TYPE = '#ANICLR' order by [description]", "", colours_options);
            }
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"];

            string submissionfolder = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + tb_reference.Text + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"];
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            string submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
            submissionurl = webprotocol + "://" + webserver + "//" + submissionurl;

            string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];

            string screenTemplate = "RegisterScreen.xslt";
            string emailbodyTemplate = "RegisterEmail.xslt";

            #endregion

            if (!Directory.Exists(submissionpath))
            {
                Directory.CreateDirectory(submissionpath);
            }



            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));
            
            rootXml.Add(new XElement("reference", tb_reference.Text));

            string[] keynames = new string[11] { "name","breed1", "breed2", "years", "months", "colour1", "colour2", "gender", "neutered", "chip", "marks" };

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
            WDCFunctions.populateXML(repeatertable, rootXml);
            #endregion //BuildXML

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Create_GeneralXML";
            cmd.Parameters.Add("@module", SqlDbType.VarChar).Value = moduleName;
            cmd.Parameters.Add("@entity_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@XML", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());
            cmd.Parameters.Add("@browserdetails", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@previous_GeneralXML_ctr", SqlDbType.Int).Value = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //CTR = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                //lblMessage.Text = "Record inserted successfully";
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
            WDCFunctions.sendemail(emailSubject, emaildocument, Request.Form["tb_emailaddress"], emailBCC);
            #endregion
         

            XslCompiledTransform ScreenXslTrans = new XslCompiledTransform();
            ScreenXslTrans.Load(path + "\\" + screenTemplate);

            StringBuilder ScreenOutput = new StringBuilder();
            TextWriter ScreenWriter = new StringWriter(ScreenOutput);

            ScreenXslTrans.Transform(reader, null, ScreenWriter);


            //save a copy of formatdocument in submissions
            try
            {
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
                {
                    outfile.Write(ScreenOutput.ToString());
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            //"<pre><code>" HttpContext.Current.Server.HtmlEncode(rootXml.ToString()) "</code></pre><br />" 
            Session["body"] = ScreenOutput.ToString();
                                     
            Response.Redirect("../Completed/default.aspx");

        }
    }
}


