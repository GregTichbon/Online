using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;

namespace Online.TestAndPlay
{
    public partial class CL1 : System.Web.UI.Page
    {
        public string html;
        public string todo;


        public string[] ChkNAYesNo_Values = new string[3] { "Not Applicable", "No", "Yes" };
       // public string[] ChkNAYesNo_Colours = new string[3] { "Red", "Blue", "Yellow" };

        public string[] FDAVerRslt_Values = new string[8] { "Performing", "Conforming", "Non-Conforming", "Non-Compliant", "Critical", "Non-Compliance", "Not Applicable", "Not Verified" };
       // public string[] FDAVerRslt_Colours = new string[8] { "Red", "Blue", "Non-Yellow", "Orange", "Green", "Purple", "Black", "Aqua" };
 

        protected void Page_Load(object sender, EventArgs e)
        {


            html = "";
            string closeaccordian = "";

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_CL1", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CONTROL_CODE", SqlDbType.VarChar).Value = "FDAVerify3";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {

                    string item_no = dr["item_no"].ToString();
                    string ITEM_DESCRIPTION = dr["ITEM_DESCRIPTION"].ToString();
                    string notes = dr["notes"].ToString();
                    string group_item = dr["group_item"].ToString();
                    string COMPLIANCE_TYPE_DESC = dr["COMPLIANCE_TYPE_DESC"].ToString();
                    string help_text = dr["help_text"].ToString();
                    string QUICK_NOTES = dr["QUICK_NOTES"].ToString();
                    string DEFAULT_RT_NOTES = dr["DEFAULT_RT_NOTES"].ToString();
                    string ALLOW_ATTACHMENTS = dr["ALLOW_ATTACHMENTS"].ToString();
                    string text = dr["text"].ToString();
                    string PlainText = dr["PlainText"].ToString();

                    if (group_item == "True")
                    {
                        //html += "<p class=\"group\">" + ITEM_DESCRIPTION + "</p>";

                        html += closeaccordian;

                        html += "<div class=\"panel-group\">";
                        html += "<div class=\"panel panel-default\">";
                        html += "<div class=\"panel-heading\">";

                        html += "<a data-toggle=\"collapse\" href=\"#collapse_" + item_no + "\">";
                        html += "<h4 class=\"panel-title\">" + ITEM_DESCRIPTION + "</h4>";
                        html += "</a>";

                        html += "</div>";
                        html += "<div id=\"collapse_" + item_no + "\" class=\"panel-collapse collapse\">";
                        html += "<div class=\"panel-body\">";


                        closeaccordian = "</div>";
                        closeaccordian += "</div>";
                        closeaccordian += "</div>";
                        closeaccordian += "</div>";
                    }
                    else
                    {
                        string id = "item_" + item_no;
                        html += "<div class=\"row\">";
                        html += "<div class=\"form-group\">";
                        html += "<label class=\"control-label col-sm-4\" for=\"" + id + "\">" + ITEM_DESCRIPTION + "</label><div class=\"col-sm-8\">";

                        string uselist = COMPLIANCE_TYPE_DESC;
                        if (uselist == "")
                        {
                            uselist = "FDAVerRslt";
                        }
                        html += "<select id=\"" + id + "\" name=\"" + id + "\" class=\"form-control usecolour\" data-list=\"" + uselist + "\">";
                        html += "<option></option>";


                        switch (uselist)
                        {
                            case "ChkNAYesNo":
                                foreach (string item in ChkNAYesNo_Values)
                                {
                                    html += "<option>" + item + "</option>";
                                }

                                break;
                            case
                                "FDAVerRslt":
                                foreach (string item in FDAVerRslt_Values)
                                {
                                    html += "<option>" + item + "</option>";
                                }
                                break;
                            default:
                                break;
                        }

                        html += "</select>";

                        if (ALLOW_ATTACHMENTS == "True")
                        {
                            html += "<input type=\"file\" id=\"fu_" + id + "\" name=\"fu_" + id + "\">";
                        }

                        if (help_text != "")
                        {
                            html += "<img src=\"../Images/questionsmall.png\" title=\"" + text + "\" />";
                        }

                        //html += "<input type=\"text\" id=\"" + id + "\" name=\"" + id + "\" class=\"form-control\" maxlength=\"100\" value=\"\" required />";
                        html += "</div>";
                        html += "</div>";
                        html += "</div>";
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

            html += closeaccordian;

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region BuildXML
            XElement rootXml = new XElement("root");
            DataTable repeatertable = new DataTable("Repeater");

            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            //rootXml.Add(new XElement("reference", tb_reference.Text));

            string[] keynames = new string[11] { "name", "breed1", "breed2", "years", "months", "colour1", "colour2", "gender", "neutered", "chip", "marks" };

            foreach (string key in Request.Form)
            {
                //if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                if (!key.StartsWith("__") && !key.StartsWith("ctl") && !key.StartsWith("clientsideonly_") && !key.StartsWith("btn_"))
                {
                    /*
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
                    */
                    rootXml.Add(new XElement(key, Request.Form[key]));

                }
            }
            WDCFunctions.populateXML(repeatertable, rootXml);
            lit_result.Text = "<pre>";
            lit_result.Text += rootXml.ToString();
            lit_result.Text += "</pre>";
            #endregion //BuildXML
        }
    }
}
