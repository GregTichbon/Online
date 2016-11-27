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

namespace Online.MobileShopLicence
{
    public partial class MobileShopLicence : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        static string moduleName = "MobileShopLicence";

        static Boolean inhibit_entity = false;
        static Boolean inhibit_hubble = false;
        static Boolean inhibit_upload = false;
        static Boolean inhibit_payment = true;

        string emailBCC = WebConfigurationManager.AppSettings[moduleName + ".emailBCC"];
        string emailSubject = WebConfigurationManager.AppSettings[moduleName + ".emailSubject"];
        string folder = WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = WebConfigurationManager.AppSettings[moduleName + ".form"];

        string screenTemplate = moduleName + "Screen.html";
        string emailbodyTemplate = moduleName + "Email.html";
        #endregion

        #region fields
        public int Entity_CTR;
        public string tb_businessname;
        public string cb_district;
        public string dd_datetype;
        public string tb_products;
        public string tb_charityname;
        public string tb_charityreference;
        public string tb_otherinformation;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
            if (Request.QueryString["populate"] == "True")
            {
                tb_businessname = "Business Name";
                tb_products = "Source and range of products";
                tb_charityname = "Charity Name";
                tb_charityreference = "Charity reference";
                tb_otherinformation = "Other information";
            }

            if (Session[moduleName + "Submitted"] == "Yes")
            {
                Session[moduleName + "Submitted"] = "No";
                Response.Redirect("/");
            }

            #region Check Entity Entered (Standard)
            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Starting", "");

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
                if (Session["Entity_CTR"] == null)
                {
                    if (inhibit_entity)
                    {
                        Session["Entity_CTR"] = "99999";
                        Session["Entity_Body"] = "||Content||";
                        Session["Entity_Email"] = "greg.tichbon@whanganui.govt.nz";
                    }
                    else
                    {
                        Response.Redirect("../entity/entity.aspx?folder=" + folder + "&Form=" + form + "3");
                    }
                }

                tb_reference.Text = WDCFunctions.WDCFunctions.getReference("datetime");

            }
            // savedata();  Not really needed

            //add a "I have finished" check box at end
            #endregion

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            #region Function Parameters
            string submissionpath = WebConfigurationManager.AppSettings[moduleName + ".submissionpath"] + "\\";
            string webprotocol = WebConfigurationManager.AppSettings["webprotocol"]; 
            string webserver = WebConfigurationManager.AppSettings["webserver"];
            #endregion

            #region debug

            WDCFunctions.WDCFunctions.Log(Request.RawUrl, "submit", "");
            Debug.WriteLine("Start");
            foreach (string key in Request.Form.Keys)
            {
                Debug.WriteLine(key + "=" + Request.Form[key]);
            }
            //return;
            #endregion

            #region fields
            Entity_CTR = Convert.ToInt32(Session["Entity_CTR"]);
            tb_businessname = Request.Form["tb_businessname"].Trim();
            cb_district = Request.Form["cb_district"];
            dd_datetype = Request.Form["dd_datetype"].Trim();
            tb_products = Request.Form["tb_products"].Trim();
            tb_charityname = Request.Form["tb_charityname"].Trim();
            tb_charityreference = Request.Form["tb_charityreference"].Trim(); 
            tb_otherinformation = Request.Form["tb_otherinformation"].Trim();
            #endregion

            #region setup multivalue variables

            string spaces = new String(' ', 50);
            spaces = "_" + spaces;
            string xkey;
            string[] lineParts;
            string linenumber;
            string links = "";
            string links_delim = "";

            string otherpremises = "";
            string otherpremises_delim = "";

            string otherpremises_business = "";
            string otherpremises_owners = "";
            string otherpremises_phone = "";
            string otherpremises_permission = "";

            string datesofuse = ""; 
            string datesofuse_delim = "";

            string location_save_delim = "";
            string location_display_delim = ""; 
            
            string location = "";
            string coords = "";
            string url = "";
            string location_save = "";
            string location_display = "";

            
            string vehicleregistration = "";
            string vehicledescription = "";
            string vehicles = "";
            //string vehicles_save = "";
            //string vehicles_display = "";
            string vehicles_delim = "";

            foreach (string key in Request.Form.Keys)
            {
                //Debug.WriteLine(key + "=" + Request.Form[key]);
                xkey = String.Concat(key, spaces);
                if (xkey.Substring(0, 14) == "tb_datesofuse_")
                {
                    datesofuse = datesofuse + datesofuse_delim + Request.Form[key];
                    datesofuse_delim = "\x00FD";
                }
                else if (xkey.Substring(0,26) == "tb_otherpremises_business_") 
                {

                    otherpremises_business = Request.Form[key];
                    lineParts = xkey.Split('_');
                    linenumber = lineParts[3];
                    otherpremises_owners = Request.Form["tb_otherpremises_owners_" + linenumber];
                    otherpremises_phone = Request.Form["tb_otherpremises_phone_" + linenumber];
                    otherpremises_permission = Request.Form["cb_otherpremises_permission_" + linenumber];


                    otherpremises = otherpremises + otherpremises_delim + otherpremises_business + "\x00FD" + otherpremises_owners + "\x00FD" + otherpremises_phone + "\x00FD" + "Permission obtained";
                    otherpremises_delim = "\x00FE";


                }
                else if (xkey.Substring(0, 12) == "tb_location_") {
                    location = Request.Form[key];
                    lineParts = xkey.Split('_');
                    linenumber = lineParts[2];
                    coords = Request.Form["hf_locationcoords_" + linenumber];
                    url =  webprotocol + "://" + webserver + "/mapping/showlocation.aspx?p=" + coords;

                    location_save = location_save + location_save_delim + location + "\x00FD" + coords;
                    location_save_delim = "\x00FE";

                    location_display = location_display + location_display_delim + "<a href=\"" + url + "\" target=\"_blank\">" + location + "</a>";
                    location_display_delim = "<br />";

                    links = links + links_delim + "Location: " + location + "\x00FD" + url;
                    links_delim = "\x00FE";
                }
                else if (xkey.Substring(0, 23) == "tb_vehicleregistration_")
                {
                    vehicleregistration = Request.Form[key];
                    lineParts = xkey.Split('_');
                    linenumber = lineParts[2];
                    vehicledescription = Request.Form["tb_vehicledescription_" + linenumber];

                    vehicles = vehicles + vehicles_delim + vehicleregistration + "\x00FD" + vehicledescription;
                    //vehicles_save = vehicles_save + vehicles_delim + vehicleregistration + "\x00FD" + vehicledescription;
                    //vehicles_display = vehicles_display + vehicles_delim + vehicleregistration + " - " + vehicledescription;
                    vehicles_delim = "\x00FE";

                }

            }
            #endregion

            #region uploadfiles

            //to do should pass back an object/class ???

            string othercouncil = "";
            string othercouncil_display = "";
            links_delim = "";

            if (!inhibit_upload)
            {
                char[] fieldDelim = { '\x00FD' };
                char[] recordDelim = { '\x00FE' };
                string[] resultSplit;



                othercouncil = WDCFunctions.WDCFunctions.saveattachments(submissionpath + tb_reference.Text, "", fu_othercouncil, Request.RawUrl);
                string[] results = othercouncil.Split(recordDelim, StringSplitOptions.RemoveEmptyEntries);
                if (results[0] != "File(s) not provided") {
                    foreach (string result in results)
                    {

                        resultSplit = result.Split(fieldDelim);
                        links = links + links_delim + "Other Council: " + fu_othercouncil.FileName + "\x00FD" + webprotocol + "://" + webserver + "/onlinesubmissions/" + moduleName + "/" + tb_reference.Text + "/" + resultSplit[2];
                        othercouncil_display = othercouncil_display + links_delim + resultSplit[0] + " - " + resultSplit[1];
                        links_delim = "\x00FE";
                    }
                }
            }
            #endregion

            #region setup for database (Standard)
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_" + moduleName;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;  //Standard
            cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = Entity_CTR;  //Standard

            cmd.Parameters.Add("@BusinessName", SqlDbType.VarChar).Value = tb_businessname;
            cmd.Parameters.Add("@wholedistrict", SqlDbType.VarChar).Value = cb_district; 
            cmd.Parameters.Add("@location", SqlDbType.VarChar).Value = location_save;
            cmd.Parameters.Add("@otherpremises", SqlDbType.VarChar).Value = otherpremises;
            cmd.Parameters.Add("@datetype", SqlDbType.VarChar).Value = dd_datetype;
            cmd.Parameters.Add("@datesofuse", SqlDbType.VarChar).Value = datesofuse;
            cmd.Parameters.Add("@products", SqlDbType.VarChar).Value = tb_products;
            cmd.Parameters.Add("@Vehicles", SqlDbType.VarChar).Value = vehicles; // vehicles_save;
            cmd.Parameters.Add("@charityname", SqlDbType.VarChar).Value = tb_charityname;
            cmd.Parameters.Add("@charityreference", SqlDbType.VarChar).Value = tb_charityreference;
            cmd.Parameters.Add("@othercouncil", SqlDbType.VarChar).Value = othercouncil; 
            cmd.Parameters.Add("@Otherinformation", SqlDbType.VarChar).Value = tb_otherinformation;
            cmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;
            #endregion
         
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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");            
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion

            #region setup Payment //This is no longer required because we are using InvoicePayment for all applications, debtors, water accounts
            //if (!inhibit_payment)
            //{
            //    string paymentreference = WDCFunctions.WDCFunctions.getReference();

            //    SqlConnection con2 = new SqlConnection(strConnString);
            //    SqlCommand cmd2 = new SqlCommand();
            //    cmd2.CommandType = CommandType.StoredProcedure;
            //    cmd2.CommandText = "Add_Payment_Request";
            //    cmd2.Parameters.Add("@reference", SqlDbType.VarChar).Value = paymentreference.ToString();
            //    cmd2.Parameters.Add("@detail", SqlDbType.VarChar).Value = "Mobile Shop Licence Application";
            //    cmd2.Parameters.Add("@amount", SqlDbType.Money).Value = 149.50;
            //    cmd2.Parameters.Add("@Entity_ctr", SqlDbType.Int).Value = Convert.ToInt32(Session["Entity_CTR"]);
            //    cmd2.Parameters.Add("@tablename", SqlDbType.VarChar).Value = moduleName;
            //    cmd2.Parameters.Add("@ctr", SqlDbType.Int).Value = ctr;

            //    ctr = 0;

            //    cmd2.Connection = con2;
            //    try
            //    {
            //        con2.Open();
            //        ctr = Convert.ToInt32(cmd2.ExecuteScalar().ToString());
            //    }
            //    catch (Exception ex)
            //    {
            //        throw ex;
            //    }
            //    finally
            //    {
            //        con2.Close();
            //        con2.Dispose();
            //    }
            //}
            #endregion

            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>();

//This should be a function
            SqlConnection con2 = new SqlConnection(strConnString);
            SqlCommand cmd2 = new SqlCommand(); 
            cmd2.CommandType = CommandType.StoredProcedure;

            cmd2.CommandText = "get_entity";
            cmd2.Parameters.Add("@entity_ctr", SqlDbType.Int).Value = Entity_CTR;

            cmd2.Connection = con2;
            try
            {
                con2.Open();
                SqlDataReader dr = cmd2.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    documentvalues["LastName"] = dr["LastName"].ToString();
                    documentvalues["FirstName"] = dr["FirstName"].ToString();
                    documentvalues["othernames"] = dr["othernames"].ToString();
                    documentvalues["KnownAs"] = dr["KnownAs"].ToString();
                    documentvalues["EmailAddress"] = dr["EmailAddress"].ToString();
                    documentvalues["ResidentialAddress"] = dr["ResidentialAddress"].ToString();
                    documentvalues["PostalAddress"] = dr["PostalAddress"].ToString();
                    documentvalues["MobilePhone"] = dr["MobilePhone"].ToString();
                    documentvalues["HomePhone"] = dr["HomePhone"].ToString();
                    documentvalues["WorkPhone"] = dr["WorkPhone"].ToString();
                    documentvalues["Gender"] = dr["Gender"].ToString();
                    documentvalues["dateofbirth"] = dr["dateofbirth"].ToString();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");            
            }
            finally
            {
                con2.Close();
                con2.Dispose();
            }


            
            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Set up dictionary items", "");

            //foreach (string key in Request.Form.Keys)
            //{
            //    Debug.WriteLine(key + "=" + Request.Form[key]);
            //}


            cmd.CommandType = CommandType.StoredProcedure;

            documentvalues["reference"] = tb_reference.Text;
            documentvalues["ram_id"] = RAM_ID;
            documentvalues["BusinessName"] = tb_businessname;
            documentvalues["wholedistrict"] = cb_district;
            documentvalues["datetype"] = dd_datetype;
            documentvalues["Location"] = location_display;
            documentvalues["otherpremises"] = otherpremises.Replace("\x00FD", " - ").Replace("\x00FE", "<br />"); 
            documentvalues["DatesOfUse"] = datesofuse.Replace("\x00FD", "<br />");
            documentvalues["Products"] = tb_products;
            documentvalues["Vehicles"] = vehicles.Replace("\x00FD", " - ").Replace("\x00FE", "<br />"); //vehicles_display
            documentvalues["CharityName"] = tb_charityname;
            documentvalues["CharityReference"] = tb_charityreference;
            documentvalues["othercouncil"] = othercouncil_display.Replace("\x00FE", "<br />");  // othercouncil.Replace("\x00FD", " - ").Replace("\x00FE", "<br />");
            documentvalues["OtherInformation"] = tb_otherinformation;

            //Uri MyUrl = Request.Url;
            //Response.Write(MyUrl.Scheme + "://" + MyUrl.Authority + "/Payment/default.aspx");
            //documentvalues["PaymentReference"] = MyUrl.Scheme + "://" + MyUrl.Authority + "/Payment?reference=" + paymentreference;
            #endregion

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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();

            
            //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Document fill Screen", "");
            screendocument = a.documentfill(screendocument, documentvalues);

            //save a copy of formatdocument in submissions

            path = Server.MapPath("~");
            try
            {
                //'C:\inetpub\Online\submissions\MobileShopLicence\910030955162210
                using (StreamWriter outfile = new StreamWriter(submissionpath + tb_reference.Text + ".html"))
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
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "");
            }

            
            WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Put email document into template", "");
            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);
            #endregion

            #region create smart list item in hubble


            if (!inhibit_hubble)
            {
                
                //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Add to Hubble", "");

                string siteURL = WebConfigurationManager.AppSettings[moduleName + ".HubbleSiteURL"];

                WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();

                //WDCFunctions.WDCFunctions.Log(Request.RawUrl, "http://" + siteURL + "," + RAM_ID.Replace('/', '-') + "," + "0" + "," + RAM_year.ToString() + "," + "Market Food Stall - " + Request.Form["tb_businessname"], "greg.tichbon@whanganui.govt.nz"); 
                
                HF.createSmartListItem("http://" + siteURL, RAM_ID.Replace('/', '-'), 0, RAM_year.ToString(), "Market Food Stall - " + Request.Form["tb_businessname"]);
            }
            #endregion

            #region send email
            WDCFunctions.WDCFunctions.sendemail(emailSubject, emaildocument, Session["Entity_Email"].ToString(), emailBCC);

            Session["body"] = screendocument;
            Session[moduleName + "Submitted"] = "Yes";

            Response.Redirect("../Completed/default.aspx");
            #endregion
        }

         //THIS IS NOW A FUNCTION!
        //protected void saveattachments()
        //{
        //    if (fu_othercouncil.HasFiles)

        //    {
        //        //string path = "F:\\InetPub\\whanganui\\online\\Submissions\\CommunityContract\\GroupDetails\\" + hf_reference.Value;
        //        //string path = "C:\\inetpub\\inetpub\\onlineSubmissions\\CommunityContract\\Application\\" + hf_reference.Value;

        //        //string attpath = WebConfigurationManager.AppSettings["CommunityContractsApplication.submissionpath"] + hf_reference.Value;
        //        string attpath = WebConfigurationManager.AppSettings["MobileShopLicence.submissionpath"] + tb_reference.Text;

        //        if (!Directory.Exists(attpath))
        //        {
        //            Directory.CreateDirectory(attpath);
        //        }

        //        int c1 = 0;
        //        int failed = 0;
        //        int succeeded = 0;

        //        foreach (HttpPostedFile postedFile in fu_othercouncil.PostedFiles)
        //        {
        //            c1 = c1 + 1;
        //            try
        //            {
        //                string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
        //                postedFile.SaveAs(attpath + "\\additionalfile" + c1.ToString() + wpextension);
        //                succeeded = succeeded + 1;
        //            }
        //            catch (Exception ex)
        //            {
        //                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
        //                failed = failed + 1;
        //            }
        //        }
        //        //hf_othercouncil.Value = "";
        //        string delim = "";
        //        string uploadresult = "";
        //        if (succeeded > 0)
        //        {
        //            uploadresult = succeeded.ToString() + " Uploaded";
        //            delim = ", ";
        //        }
        //        if (failed > 0)
        //        {
        //            uploadresult = uploadresult + delim + failed.ToString() + " Failed ";
        //        }

        //    }
        //    //else
        //    //{
        //    //    hf_othercouncil.Value = "File(s) not provided";
        //    //}
        //}

    }
}