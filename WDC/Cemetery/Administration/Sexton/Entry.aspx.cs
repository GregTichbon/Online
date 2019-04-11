using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace Online.Cemetery.Administration.Sexton
{
    public partial class Entry : System.Web.UI.Page
    {
        #region fields
        public string hf_id;
        public string warrant_no;
        public string register_no;
        public string surname;
        public string givenname1;
        public string givenname2;
        public string givenname3;
        public string lastpermanentaddress;
        public string city;
        public string placeofdeath;
        public string dateofbirth;
        public string age;
        public string age_period;
        public string gender;
        public string denomination;
        public string minister;
        public string dateofdeath;
        public string dateofmedcert;
        public string rankoroccupation;
        public string maritalstatus;
        public string funeralcoordinator;
        public string remarks;
        public string stillborn;
        public string created_by;
        public string date_created;
        public string modified_by;
        public string date_modified;
        public string transactions;

        public string transactiontypes;
        public string jsobj_transactiontypes;

        public string[] transactiontype_values = new string[7] { "Burial", "Burial Ashes", "Cremation", "Disinterment", "Memorial (only)", "Ashes Scattered", "Ashes Taken" };
        //"Burial", "Burialash", "Cremation", "Disinter", "Memorial", "Scattered", "Taken"
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions wdcFunctions = new WDCFunctions.WDCFunctions();
            hf_id = Request.QueryString["ID"];

            //List<BurialRecord> BurialRecordList = new List<BurialRecord>();

            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";


            Dictionary<string, string> options = new Dictionary<string, string>();




            options.Clear();
            options["mode"] = "sql";
            options["connectionstring"] = strConnString;
            options["sqltype"] = "text";
            options["sqltext"] = "select xxx as [Value], xxx as [Label] from transactiontypes order by xxxx";
            jsobj_transactiontypes = wdcFunctions.buildJSobject(options);

            options.Clear();
            //the key from jsobj_transactiontypes is the value of the select option
            options["mode"] = "jsobject";
            options["jsobject"] = jsobj_transactiontypes;
            options["firstoption"] = "None";
            options["selectedoption"] = "";
            options["labelindex"] = "colour";
            transactiontypes = wdcFunctions.buildselect(options);

            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_cemetery_person", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@accessid", SqlDbType.VarChar).Value = hf_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //BurialRecordList.Add(new BurialRecord
                    //{
                    warrant_no = dr["Warrant_No"].ToString();
                    register_no = dr["Register_No"].ToString();
                    surname = dr["surname"].ToString();
                    givenname1 = dr["givenName1"].ToString();
                    givenname2 = dr["givenName2"].ToString();
                    givenname3 = dr["givenName3"].ToString();
                    lastpermanentaddress = dr["lastPermanentAddress"].ToString();
                    city = dr["city"].ToString();
                    placeofdeath = dr["placeOfDeath"].ToString();
                    //dateofbirth = dr["dateOfDeath"].ToString();
                    dateofbirth = WDCFunctions.WDCFunctions.formatdate(dr["dateOfBirth"].ToString(), "dd MMM yyyy");
                    age = dr["age"].ToString();
                    age_period = dr["age_Period"].ToString();
                    gender = dr["gender"].ToString();
                    denomination = dr["denomination"].ToString();
                    minister = dr["minister"].ToString();
                    //dateofdeath = dr["dateOfDeath"].ToString();
                    //dateofmedcert = dr["dateOfMedCert"].ToString();
                    dateofdeath = WDCFunctions.WDCFunctions.formatdate(dr["dateofdeath"].ToString(), "dd MMM yyyy");
                    dateofmedcert = WDCFunctions.WDCFunctions.formatdate(dr["dateofmedcert"].ToString(), "dd MMM yyyy");
                    rankoroccupation = dr["rankOrOccupation"].ToString();
                    maritalstatus = dr["maritalStatus"].ToString();
                    funeralcoordinator = dr["funeralCoOrdinator"].ToString();
                    remarks = dr["remarks"].ToString();
                    stillborn = dr["stillBorn"].ToString();
                    created_by = dr["created_by"].ToString();
                    date_created = dr["date_created"].ToString();
                    modified_by = dr["modified_by"].ToString();
                    date_modified = dr["date_modified"].ToString();


                    /*
                    if (Location != "")
                    {
                        string GISIDRef = "";
                        lit_table.Text += "<tr><td class=\"view_label\">Location</td><td>" + Location + GISIDRef + "</td></tr>";
                    }
                    if (GISID != "")
                    {
                        lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?mapkey=" + GISID + "&project=WhanganuiMapControls&module=WDCCemeteries&layer=~Cemetery%20Plots&search=false&info=false&slider=false&expand=false\"></iframe>";

                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_map\">Map</a></li>";
                    } else
                    {
                        if(Area == "Rose Garden") { 
                            lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"https://mangomap.com/wdc/maps/74982/Whanganui-Cemeteries?field=location&layer=038ea1c2-7fd2-11e8-bfd8-06765ea3034e&preview=true&value=Rose+Garden\"></iframe>";
                            lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_map\">Map</a></li>";
                        }
                    }

                    String imagepath = ConfigurationManager.AppSettings["Cemetery.ImageFolder"] + hf_id;
                    String imageurl = ConfigurationManager.AppSettings["Cemetery.ImageURL"] + hf_id + "/";

                    //lit_debug.Text += imagepath;
                    if (Directory.Exists(imagepath)) {
                        var files = Directory.EnumerateFiles(imagepath, "*.*", SearchOption.TopDirectoryOnly)
                            .Where(s => s.ToLower().EndsWith(".jpg") || s.ToLower().EndsWith(".jpeg"));

                        if(files.Count() > 0)
                        {
                            lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_images\">Images</a></li>";
                            foreach (string currentFile in files)
                            {
                                lit_images.Text += "<img src=\"" + imageurl + Path.GetFileName(currentFile) + "\" />";
                            }
                        }

                    }
                    if(inscription != "")
                    {
                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_inscription\">Inscription</a></li>";
                        lit_inscription.Text = inscription;
                    }

                    */
        /*
        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_notes\">Notes</a></li>";
        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_feedback\">Feedback</a></li>";
        */

        dr.Close();
                    cmd = new SqlCommand("get_cemetery_person_transactions", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@accessid", SqlDbType.VarChar).Value = hf_id;

                    cmd.Connection = con;
                    try
                    {
                        //con.Open();
                        dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                transactions += "<tr id=\"T_" + dr["transactid"] + "\">";
                                transactions += "<td>" + dr["actiondate"] + "</td>";
                                transactions += "<td>" + dr["transactiondescription"] + "</td>";
                                //Plot, Depth, and Taken By should be mutually exclusive and based on the transaction type
                                string plot = "Plot: To do";
                                string depth = "Depth: " + dr["depth"].ToString();
                                string takenby = "Taken by: " + dr["taken_by"].ToString();
                                transactions += "<td>" + plot + depth + takenby + "</td>";
                                transactions += "<td>" + dr["remarks"] + "</td>";
                                transactions += "<td class=\"transaction_edit\">Edit</td>";
                                transactions += "</tr>";

                            }
                            dr.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
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

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
    /*
        public class BurialRecord
    {
        public string Name;
        public string Age;
        public string Date_of_Death;
        public string Gender;

        public string Warrant;
        public string Date_of_Burial;
        public string Date_of_Birth;
        public string Residence;
        public string Occupation;
        public string Minister;
        public string Director;

        public string Date_of_Medical_Certificate;
        public string Marital_Status;
        public string Place_of_Death;
        public string Register_No;

        public string Stillborn;
        public string Location;
        public string AccessID;
        //public string GISID;
    }
    */
}