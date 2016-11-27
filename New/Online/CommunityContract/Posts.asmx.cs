using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Text;

using System.Web.Script.Services;
using System.Web.Configuration;
using Online.Models;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

namespace Online.CommunityContract
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS

    public class Posts : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string application(NameValue[] formVars)    //you can't pass any querystring params
        {
            string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];


            #region fields
            string hf_application_ctr = formVars.Form("hf_application_ctr");
            string hf_users_ctr = formVars.Form("hf_users_ctr");
            string tb_reference = formVars.Form("tb_reference");
            //string tb_groupreference = formVars.Form("tb_groupreference");
            string dd_fundingtype = formVars.Form("dd_fundingtype");
            string tb_projectname = formVars.Form("tb_projectname");
            string tb_projectdescription = formVars.Form("tb_projectdescription");
            string tb_peopledirectbenefit = formVars.Form("tb_peopledirectbenefit");
            string tb_outcomes = formVars.Form("tb_outcomes");
            string tb_deeplyunited = formVars.Form("tb_deeplyunited");
            string tb_globallyconnected = formVars.Form("tb_globallyconnected");
            string tb_creativesmarts = formVars.Form("tb_creativesmarts");
            string tb_flowingwithrichness = formVars.Form("tb_flowingwithrichness");
            string tb_worksforeveryone = formVars.Form("tb_worksforeveryone");
            string tb_saferwhanganui = formVars.Form("tb_saferwhanganui");
            string tb_collaboration = formVars.Form("tb_collaboration");
            string fu_additionalfiles = formVars.Form("fu_additionalfiles");
            string tb_projectcost = formVars.Form("tb_projectcost");
            string tb_owncontributions = formVars.Form("tb_owncontributions");
            string tb_committedfunding = formVars.Form("tb_committedfunding");
            string tb_fundingapplications = formVars.Form("tb_fundingapplications");
            string tb_councilcontribution = formVars.Form("tb_councilcontribution");
            string tb_committedfunders = formVars.Form("tb_committedfunders");
            string tb_fundersappliedto = formVars.Form("tb_fundersappliedto");
            string tb_applicantname = formVars.Form("tb_applicantname");
            string tb_applicantposition = formVars.Form("tb_applicantposition");
            string tb_applicantemail = formVars.Form("tb_applicantemail");
            //string tb_emailconfirm = formVars.Form("tb_emailconfirm");
            string tb_applicantphone = formVars.Form("tb_applicantphone");
            string tb_applicantmobile = formVars.Form("tb_applicantmobile");
            string dd_finalised = formVars.Form("dd_finalised");
            string hf_deleteadditionalfile = formVars.Form("hf_deletefile_additional");
            #endregion

            #region setup for database (Standard)

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_CC_Application";

            cmd.Parameters.Add("@cc_users_ctr", SqlDbType.VarChar).Value = hf_users_ctr;
            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;
            cmd.Parameters.Add("@CC_Application_CTR", SqlDbType.VarChar).Value = hf_application_ctr;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference;
            cmd.Parameters.Add("@fundingtype", SqlDbType.VarChar).Value = dd_fundingtype;
            cmd.Parameters.Add("@projectname", SqlDbType.VarChar).Value = tb_projectname;
            cmd.Parameters.Add("@projectdescription", SqlDbType.VarChar).Value = tb_projectdescription;
            cmd.Parameters.Add("@peopledirectbenefit", SqlDbType.VarChar).Value = tb_peopledirectbenefit;
            cmd.Parameters.Add("@outcomes", SqlDbType.VarChar).Value = tb_outcomes;
            cmd.Parameters.Add("@deeplyunited", SqlDbType.VarChar).Value = tb_deeplyunited;
            cmd.Parameters.Add("@globallyconnected", SqlDbType.VarChar).Value = tb_globallyconnected;
            cmd.Parameters.Add("@creativesmarts", SqlDbType.VarChar).Value = tb_creativesmarts;
            cmd.Parameters.Add("@flowingwithrichness", SqlDbType.VarChar).Value = tb_flowingwithrichness;
            cmd.Parameters.Add("@worksforeveryone", SqlDbType.VarChar).Value = tb_worksforeveryone;
            cmd.Parameters.Add("@saferwhanganui", SqlDbType.VarChar).Value = tb_saferwhanganui;
            cmd.Parameters.Add("@collaboration", SqlDbType.VarChar).Value = tb_collaboration;
            cmd.Parameters.Add("@additionalfiles", SqlDbType.VarChar).Value = "xxxxxxxx";              //Need to look at this
            cmd.Parameters.Add("@projectcost", SqlDbType.VarChar).Value = tb_projectcost;
            cmd.Parameters.Add("@owncontributions", SqlDbType.VarChar).Value = tb_owncontributions;
            cmd.Parameters.Add("@committedfunding", SqlDbType.VarChar).Value = tb_committedfunding;
            cmd.Parameters.Add("@fundingapplications", SqlDbType.VarChar).Value = tb_fundingapplications;
            cmd.Parameters.Add("@councilcontribution", SqlDbType.VarChar).Value = tb_councilcontribution;
            cmd.Parameters.Add("@committedfunders", SqlDbType.VarChar).Value = tb_committedfunders;
            cmd.Parameters.Add("@fundersappliedto", SqlDbType.VarChar).Value = tb_fundersappliedto;
            cmd.Parameters.Add("@applicantname", SqlDbType.VarChar).Value = tb_applicantname;
            cmd.Parameters.Add("@applicantposition", SqlDbType.VarChar).Value = tb_applicantposition;
            cmd.Parameters.Add("@applicantemail", SqlDbType.VarChar).Value = tb_applicantemail;
            cmd.Parameters.Add("@applicantphone", SqlDbType.VarChar).Value = tb_applicantphone;
            cmd.Parameters.Add("@applicantmobile", SqlDbType.VarChar).Value = tb_applicantmobile;
            cmd.Parameters.Add("@finalised", SqlDbType.VarChar).Value = dd_finalised;
            #endregion

            #region save data (Standard)
            string validation = "";
            string validationinternal = "";
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    validation = dr["validation"].ToString();
                    validationinternal = dr["validationinternal"].ToString();
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

            #endregion

            if (hf_deleteadditionalfile != "")
            {
                string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + tb_reference + "\\";
                string[] deleteadditionalfiles = hf_deleteadditionalfile.Split(',');
                foreach (string deleteadditionalfile in deleteadditionalfiles)
                {
                    File.Delete(submissionpath + deleteadditionalfile);
                }
            }
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public XmlDocument applicationupload()    //you can't pass any querystring params
        {
            var Request = HttpContext.Current.Request;
            string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + Request.Form["reference"] + "\\";
            if (!Directory.Exists(submissionpath))
            {
                Directory.CreateDirectory(submissionpath);
            }

            int c1;
            string newfilename;

            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                c1 = 0;
                var file = Request.Files[i];

                string wpextension = System.IO.Path.GetExtension(file.FileName);
                string wpfilename = System.IO.Path.GetFileNameWithoutExtension(file.FileName);

                do
                {
                    c1 = c1 + 1;
                    newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;
                } while (File.Exists(submissionpath + newfilename));

                file.SaveAs(submissionpath + newfilename);

            }

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";

            XmlDocument xml = new XmlDocument();
            XmlSerializer serializer = new XmlSerializer(resultclass.GetType());

            using (StringWriter writer = new StringWriter())
            {
                serializer.Serialize(writer, resultclass);
                string passresult = writer.ToString();
                xml.LoadXml(passresult);
                return (xml);
            }

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string submit(NameValue[] formVars)    //you can't pass any querystring params
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region parameters
            string emailBCC = WebConfigurationManager.AppSettings["CommunityContractsApplication.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings["CommunityContractsApplication.emailSubject"];
            string screenTemplate = "ApplicationScreen.html";
            string emailbodyTemplate = "ApplicationEmail.html";
            #endregion


            #region fields
            string hf_application_ctr = formVars.Form("hf_application_ctr");
            string hf_users_ctr = formVars.Form("hf_users_ctr");
            string tb_reference = formVars.Form("tb_reference");
            //string tb_groupreference = formVars.Form("tb_groupreference");
            string dd_fundingtype = formVars.Form("dd_fundingtype");
            string tb_projectname = formVars.Form("tb_projectname");
            string tb_projectdescription = formVars.Form("tb_projectdescription");
            string tb_peopledirectbenefit = formVars.Form("tb_peopledirectbenefit");
            string tb_outcomes = formVars.Form("tb_outcomes");
            string tb_deeplyunited = formVars.Form("tb_deeplyunited");
            string tb_globallyconnected = formVars.Form("tb_globallyconnected");
            string tb_creativesmarts = formVars.Form("tb_creativesmarts");
            string tb_flowingwithrichness = formVars.Form("tb_flowingwithrichness");
            string tb_worksforeveryone = formVars.Form("tb_worksforeveryone");
            string tb_saferwhanganui = formVars.Form("tb_saferwhanganui");
            string tb_collaboration = formVars.Form("tb_collaboration");
            string fu_additionalfiles = formVars.Form("fu_additionalfiles");
            string tb_projectcost = formVars.Form("tb_projectcost");
            string tb_owncontributions = formVars.Form("tb_owncontributions");
            string tb_committedfunding = formVars.Form("tb_committedfunding");
            string tb_fundingapplications = formVars.Form("tb_fundingapplications");
            string tb_councilcontribution = formVars.Form("tb_councilcontribution");
            string tb_committedfunders = formVars.Form("tb_committedfunders");
            string tb_fundersappliedto = formVars.Form("tb_fundersappliedto");
            string tb_applicantname = formVars.Form("tb_applicantname");
            string tb_applicantposition = formVars.Form("tb_applicantposition");
            string tb_applicantemail = formVars.Form("tb_applicantemail");
            //string tb_emailconfirm = formVars.Form("tb_emailconfirm");
            string tb_applicantphone = formVars.Form("tb_applicantphone");
            string tb_applicantmobile = formVars.Form("tb_applicantmobile");
            string dd_finalised = formVars.Form("dd_finalised");
            string hf_deleteadditionalfile = formVars.Form("hf_deletefile_additional");
            #endregion

            string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\";


            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["reference"] = tb_reference;
            documentvalues["fundingtype"] = dd_fundingtype;
            documentvalues["projectname"] = tb_projectname;
            documentvalues["projectdescription"] = tb_projectdescription;
            documentvalues["peopledirectbenefit"] = tb_peopledirectbenefit;
            documentvalues["outcomes"] = tb_outcomes;
            documentvalues["deeplyunited"] = tb_deeplyunited;
            documentvalues["globallyconnected"] = tb_globallyconnected;
            documentvalues["creativesmarts"] = tb_creativesmarts;
            documentvalues["flowingwithrichness"] = tb_flowingwithrichness;
            documentvalues["worksforeveryone"] = tb_worksforeveryone;
            documentvalues["saferwhanganui"] = tb_saferwhanganui;
            documentvalues["collaboration"] = tb_collaboration;
            //documentvalues["additionalfiles"] = fu_additionalfiles;
            documentvalues["projectcost"] = tb_projectcost;
            documentvalues["owncontributions"] = tb_owncontributions;
            documentvalues["committedfunding"] = tb_committedfunding;
            documentvalues["fundingapplications"] = tb_fundingapplications;
            documentvalues["councilcontribution"] = tb_councilcontribution;
            documentvalues["committedfunders"] = tb_committedfunders;
            documentvalues["fundersappliedto"] = tb_fundersappliedto;
            documentvalues["applicantname"] = tb_applicantname;
            documentvalues["applicantposition"] = tb_applicantposition;
            documentvalues["applicantemail"] = tb_applicantemail;
            documentvalues["applicantphone"] = tb_applicantphone;
            documentvalues["applicantmobile"] = tb_applicantmobile;
            documentvalues["finalised"] = dd_finalised;

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
                WDCFunctions.Log("CommunityContracts/Posts.asmx/submit", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();


            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill Screen", "");
            screendocument = a.documentfill(screendocument, documentvalues);

            //save a copy of formatdocument in submissions

            path = Server.MapPath("~");
            try
            {
                //'C:\inetpub\Online\submissions\MobileShopLicence\910030955162210
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log("CommunityContracts/Posts.asmx/submit", ex.Message, "greg.tichbon@whanganui.govt.nz");
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
                WDCFunctions.Log("CommunityContracts/Posts.asmx/submit", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill email", "");
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
                WDCFunctions.Log("CommunityContracts/Posts.asmx/submit", ex.Message, "");
            }

            WDCFunctions.Log("CommunityContracts/Posts.asmx/submit", "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, tb_applicantemail, emailBCC);
            #endregion


            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }
    }

    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class standardResponse
    {
        public string status;
        public string message;
    }

    #endregion

    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }

}
