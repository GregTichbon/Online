using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Online.Models;

using System.Data;


//using System.Data.SqlClient;
//using System.Configuration;
using System.IO;
using System.Web.Configuration;
//using System.Diagnostics;
using System.Xml.Linq;
//using System.Data.SqlTypes;

namespace Online.TestAndPlay
{
    public partial class RepeaterDocument1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string reference = WDCFunctions.getReference("datetime");

             #region uploadfiles
            List<FileClass> FileList = new List<FileClass>();
            
            //if (!inhibit_upload)
            //{
                //submissionurl = WebConfigurationManager.AppSettings[moduleName + ".submissionurl"] + "/" + tb_reference.Text;
                //submissionurl = webprotocol + "://" + submissionurl;
            
            string submissionpath = "c:\\inetpub\\onlineSubmissions\\RepeaterDocument1\\" + reference + "\\";
            string submissionurl = "http://wdc.whanganui.govt.nz/onlineTEST/onlinesubmissions/RepeaterDocument1" + "/" + reference;

            WDCFunctions.upload(submissionpath, submissionurl, Request.Files, FileList);
            //}
            #endregion



            Dictionary<string, string> documentvalues = new Dictionary<string, string>();
            documentvalues["test"] = "TEST";


            string doc = "Top Line<br />SD test:||sd|test||.<br />FU fu_upload:||fu|fu_upload||.<br />@@Rsite@@ Start of Site<br />RF tb_thedatesofuse:||rf|tb_thedatesofuse||.<br />FU fu_scopeofoperations:||fu|fu_scopeofoperations||.<br />End of Site<br />@@RBottom Line";

            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            WDCFunctions.createXMLStructure(repeatertable, Request.Form, rootXml);
            WDCFunctions.populateXML(repeatertable, rootXml);
            
            /*
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            foreach (string key in Request.Form)
            {
                if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl")
                {
                    if (key.Substring(0, 7) == "repeat_")
                    {
                        string[] keyparts = key.Split('_');
                        string keypartname = keyparts[1];

                        string keypartindex = keyparts[keyparts.Length - 1];
                        string keypartfield = "";
                        string keypartsdelim = "";

                        for (int i = 3; i <= keyparts.Length - 2; i++)
                        {
                            keypartfield += keypartsdelim + keyparts[i];
                            keypartsdelim = "_";
                        }

                        repeatertable.Rows.Add(keypartname, keypartindex, keypartfield, Request.Form[key]);

                    }
                    else
                    {
                        //rootXml.Add(new XElement(key, Request.Form[key]));
                    }
                }
            }
             */

            string ret = "";
            ret = WDCFunctions.documentfillwithRFandFiles(doc, documentvalues, Request.Form, FileList, "", repeatertable, "");
            Response.Write(ret);
        }
    }
}