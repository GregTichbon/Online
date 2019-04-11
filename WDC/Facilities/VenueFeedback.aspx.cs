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
using System.Xml.Linq;

namespace Online.Facilities
{
    public partial class VenueFeedback : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        //static Boolean inhibit_entity = true;
        static Boolean inhibit_hubble = false;
        // Not required static Boolean inhibit_upload = true;
        // Not required static Boolean inhibit_payment = true;

        static string moduleName = "VenueFeedback";

        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];
        #endregion

        #region fields
        public int Entity_CTR;
        static DataTable responseTable; // = new DataTable();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            if (!Page.IsPostBack)
            {

                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_Response_Items", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@response_form_ctr", SqlDbType.Int).Value = 1;
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                responseTable = new DataTable();
                da.Fill(responseTable);  //Read it into a datatable so that this data is guaranteed the same when we save.
                da.Dispose();
                con.Close();

                /*
                In the future the whole form should be generated but for now will do in sections

                foreach (DataRow row in dataTable.Rows)
                {
                    int number_of_responses = Convert.ToInt16(row["number_of_responses"]);
                    string response_group_ctr = row["response_group_ctr"].ToString();
                }
                */

                DataView response_group;

                response_group = new DataView(responseTable, "response_group_ctr = 1", "", DataViewRowState.CurrentRows);
                lit_recommend.Text = WDCFunctions.build_response_html(response_group);

                response_group = new DataView(responseTable, "response_group_ctr = 2", "", DataViewRowState.CurrentRows);
                lit_satisfaction.Text = WDCFunctions.build_response_html(response_group);

                response_group = new DataView(responseTable, "response_group_ctr = 3", "", DataViewRowState.CurrentRows);
                lit_importance.Text = WDCFunctions.build_response_html(response_group);


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

                /* Not Required
                if (Session["online_entity_ctr"] != null)
                {
                    lit_user.Text = "<a href=\"../entity/entity.aspx\" target=\"_blank\"><img id=\"usericon\" src=\"http://wdc.whanganui.govt.nz/online/images/user.png\" /></a>";
                }
                */

                #region Check Entity Entered (Standard)
                //WDCFunctions.Log(Request.RawUrl, "Starting", "");

                /* Not Required
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
                        if (Request.QueryString["showfields"] != null)
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
                */
                tb_reference.Text = WDCFunctions.getReference("datetime");
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
            // Not required string links = "";
            // Not required string links_delim = "";
            #endregion

            #region fields
            //Entity_CTR = Convert.ToInt32(Session["online_entity_ctr"]);
            #endregion


            List<FileClass> FileList = new List<FileClass>();
            /*  Not required
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
            */

            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_" + moduleName + "XML", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            cmd.Parameters.Add("@module_ctr", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard
            // Not required cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = Entity_CTR;  //Standard
            // Not requiredcmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;  //Standard
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

            documentvalues["showentity"] = "False"; //this is used in the email just in case
            /* Not required
            if (inhibit_entity)
            {
                documentvalues["showentity"] = "False";
            }
            else
            {
                documentvalues["showentity"] = "True";
                WDCFunctions.entityfields(Entity_CTR, documentvalues);
            }
            */

            DataView response_group;

            response_group = new DataView(responseTable, "response_group_ctr = 1", "", DataViewRowState.CurrentRows);
            documentvalues["recommend"] = build_response_html(response_group);

            response_group = new DataView(responseTable, "response_group_ctr = 2", "", DataViewRowState.CurrentRows);
            documentvalues["satisfaction"] = build_response_html(response_group);

            response_group = new DataView(responseTable, "response_group_ctr = 3", "", DataViewRowState.CurrentRows);
            documentvalues["importance"] = build_response_html(response_group);

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

            //path = Server.MapPath("~");

            if (!Directory.Exists(submissionpath))
            {
                try
                {
                    Directory.CreateDirectory(submissionpath);
                }
                catch (Exception ex)
                {
                    WDCFunctions.Log(Request.RawUrl, ex.Message + " Create directory " + submissionpath, "greg.tichbon@whanganui.govt.nz");
                }
            }


            try
            {
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message + " Save file " + submissionpath + tb_reference.Text + ".html", "greg.tichbon@whanganui.govt.nz");
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
                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
                Dictionary<string, string> metaAllFields = new Dictionary<string, string>(2);
                metaAllFields.Add("DocumentType", "CORRESPONDENCE, Email, Memo, Survey");
                metaAllFields.Add("Narrative", Request.Form["dd_venue"]);
                //metaAllFields.Add("PropertyNo", Request.Form["hf_property_number"]);
                string hubbleurl = WebConfigurationManager.AppSettings["hubbleurl"];

                HF.UploadFile(hubbleurl + "team/venue/", "Team Administration", "admin/", "Online Venue Feedback - Reference " + tb_reference.Text + ".html", Encoding.ASCII.GetBytes(emaildocument), metaAllFields);
            }
            #endregion

            #region send email
            WDCFunctions.sendemail(emailSubject, emaildocument, Request.Form["tb_emailaddress"].ToString(), emailBCC);
            #endregion //send email

            Session["body"] = screendocument;
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");

        }
        public string build_response_html(DataView response_group)
        {
            string html = "";
            int response_group_Count = response_group.Count;
            if (response_group_Count == 1)
            {
                DataRowView row = response_group[0];
                string response_group_CTR = row["response_group_CTR"].ToString();
                string response_item_CTR = row["response_item_CTR"].ToString();
                string header = row["header"].ToString();
                string help = row["help"].ToString();
                //string id = "_response_" + response_group_CTR + "_" + response_item_CTR;

                string selected = Request.Form["hf_response_" + response_group_CTR + "_" + response_item_CTR];

                html += "<table class=\"table\"><tr><td style=\"width:80%\">" + header + "</td><td style=\"text-align:right\">" + help + "</br>";
                html += "<table style=\"width:100%\"><tr>";
                string hilighted;
                for (int f1 = 0; f1 < 11; f1++)
                {
                    if (f1.ToString() == selected)
                    {
                        hilighted = ";background-color:red";
                    }
                    else
                    {
                        hilighted = "";
                    }
                    html += "<td style=\"text-align:center" + hilighted + "\">" + f1 + "</td>";
                }
                html += "</tr>";
                html += "</table>";
                html += "</td></tr></table>";
            }
            else
            {
                Boolean heading_done = false;
                foreach (DataRowView row in response_group)
                {
                    if (!heading_done)
                    {
                        string heading = row["heading"].ToString();
                        string help = row["help"].ToString();

                        html += "<table class=\"table\"><tr><td style=\"width:80%\">" + heading + "</td></td><td style=\"text-align:right\">" + help + " </td></tr>";
                        //html += "</table>";
                        //html += heading;
                        //html += "<table class=\"table\">";
                        //html += "<tr><td style=\"width:99%\">&nbsp</td><td colspan=\"11\">" + help + "</td>";
                        heading_done = true;
                    }
                    string response_group_CTR = row["response_group_CTR"].ToString();
                    string response_item_CTR = row["response_item_CTR"].ToString();
                    string header = row["header"].ToString();
                    //string id = "_response_" + response_group_CTR + "_" + response_item_CTR;

                    string selected = Request.Form["hf_response_" + response_group_CTR + "_" + response_item_CTR];

                    html += "<tr><td>" + header + "</td>";
                    html += "<td><table style=\"width:100%\"><tr>";

                    string hilighted;
                    for (int f1 = 0; f1 < 11; f1++)
                    {
                        if(f1.ToString() == selected)
                        {
                            hilighted = ";background-color:red";
                        }
                        else
                        {
                            hilighted = "";
                        }
                        html += "<td style=\"text-align:center" + hilighted + "\">" + f1 + "</td>";
                    }
                    html += "</tr>";
                    html += "</table>";
                    html += "</td>";
                    html += "</tr>";
                }
                html += "</table>";
            }
            return html;
        }
    }
}