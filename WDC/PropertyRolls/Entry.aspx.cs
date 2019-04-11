using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PropertyRolls
{
    public partial class Entry : System.Web.UI.Page
    {

        public string xxxxxxxx;
        public string hf_propertyroll_id;
        public string tb_valuationnumber;

        public string tb_propertyaddress;
        public string dd_ward;
        public string dd_council;
        public string tb_rates;
        public string tb_year;
        public string dd_year;
        public string dd_reference;
        public string tb_page;
        public string tb_notes;
        public string tb_propertydescription;
        public string dd_tenancy;

        public string tb_occupiersurname;
        public string tb_occupierfirstname;
        public string tb_occupierinitials;
        public string tb_occupiertitle;
        public string dd_occupiergender;
        public string tb_occupieroccupation;
        public string tb_ownersurname;
        public string tb_ownerfirstname;
        public string tb_ownerinitials;
        public string tb_ownertitle;
        public string dd_ownergender;
        public string tb_owneroccupation;
        public string tb_owneraddress;

        public string dd_status;
        public string tb_internalnotes;
        public string tb_created;
        public string tb_modified;


        //public string[] councils = new string[7] { "MY TOP HAT", "CAT", "COUNCIL", "WANGANUI BOROUGH COUNCIL", "WANGANUI CITY COUNCIL", "WANGANUI TOWN COUNCIL", "Wanganui Town Board" };
        //public string[] wards = new string[9] { "ARAMOHO", "CASTLECLIFF", "DURIE TOWN", "Wanganui East", "ST JOHNS", "COOKS", "NOT SUPPLIED", "QUEENS", "SUBURBAN" };
        //public string[] tenancies = new string[9] { "N", "W", "H", "NULL", "F", "L", "Q", "M", "Y" };

        public string[] genders = new string[2] { "F", "M" };
        public string [] statuses = new string[3] { "Requires checking", "Doesn't require checking", "Checked" };

        public string councils;
        public string wards;
        public string years;
        public string tenancies;
        public string references;

        protected void Page_Load(object sender, EventArgs e)
        {
 
            if (!Page.IsPostBack)
            {
                if (Session["proproll_administrator"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                string wdcscripts = "";
                if (Request.QueryString["populate"] != null)
                {
                    wdcscripts += "$.getScript('../../scripts/wdc/populate.js');";
                }
                if (Request.QueryString["showfields"] != null)
                {
                    wdcscripts += "$.getScript('../../scripts/wdc/showfields.js');";
                }
                if (wdcscripts != "")
                {
                    wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
                }

                //String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
                String strConnString = "Data Source=192.168.0.204;Initial Catalog=PropertyRolls;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

                WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

                hf_propertyroll_id = Request.QueryString["id"];
                if (hf_propertyroll_id == null)
                {
                    hf_propertyroll_id = "0";
                    if (Session["reference"] != null)
                    {
                        dd_reference = Session["reference"].ToString();
                    }
                }
                else
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "Get_Property_Roll";
                    cmd.Parameters.Add("@PropertyRoll_ID", SqlDbType.VarChar).Value = hf_propertyroll_id;

                    cmd.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.HasRows)
                        {
                            dr.Read();
                            tb_valuationnumber = dr["valuationnumber"].ToString();
                            tb_propertyaddress = dr["propertyaddress"].ToString();
                            dd_ward = dr["ward_id"].ToString();
                            dd_council = dr["council_id"].ToString();
                            tb_rates = dr["rates"].ToString();
                            tb_year = dr["year"].ToString();
                            dd_year = dr["year"].ToString();
                            dd_reference = dr["reference"].ToString();
                            tb_page = dr["page"].ToString();
                            tb_notes = dr["notes"].ToString();
                            tb_propertydescription = dr["propertydescription"].ToString();
                            dd_tenancy = dr["tenancy"].ToString();

                            tb_occupiersurname = dr["occupiersurname"].ToString();
                            tb_occupierfirstname = dr["occupierfirstname"].ToString();
                            tb_occupierinitials = dr["occupierinitials"].ToString();
                            tb_occupiertitle = dr["occupiertitle"].ToString();
                            dd_occupiergender = dr["occupiergender"].ToString();
                            tb_occupieroccupation = dr["occupieroccupation"].ToString();
                            tb_ownersurname = dr["ownersurname"].ToString();
                            tb_ownerfirstname = dr["ownerfirstname"].ToString();
                            tb_ownerinitials = dr["ownerinitials"].ToString();
                            tb_ownertitle = dr["ownertitle"].ToString();
                            dd_ownergender = dr["ownergender"].ToString();
                            tb_owneroccupation = dr["owneroccupation"].ToString();
                            tb_owneraddress = dr["owneraddress"].ToString();

                            dd_status = dr["status"].ToString();
                            tb_internalnotes = dr["internalnotes"].ToString();
                            tb_created = dr["datetime_created"].ToString();
                            tb_modified = dr["datetime_modified"].ToString();

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
                Dictionary<string, string> councils_options = new Dictionary<string, string>();
                councils_options["usevalues"] = "";
                councils_options["selecttype"] = "Value";
                councils = WDCFunctions.buildandpopulateselect(strConnString, "select council_id as [Value], [Description] as [Label] from council order by [Description]", dd_council, councils_options);

                Dictionary<string, string> wards_options = new Dictionary<string, string>();
                wards_options["usevalues"] = "";
                wards_options["selecttype"] = "Value";
                wards = WDCFunctions.buildandpopulateselect(strConnString, "select ward_id as [Value], [Description] as [Label] from ward order by [Description]", dd_ward, wards_options);

                Dictionary<string, string> years_options = new Dictionary<string, string>();
                //years_options["usevalues"] = "";
                years_options["selecttype"] = "Label"; //Value
                years = WDCFunctions.buildandpopulateselect(strConnString, "select [Description] as [Label] from year order by [Description]", dd_year, years_options);

                Dictionary<string, string> tenancies_options = new Dictionary<string, string>();
                tenancies_options["usevalues"] = "";
                tenancies_options["selecttype"] = "Value";
                tenancies = WDCFunctions.buildandpopulateselect(strConnString, "select tenancy_id as [Value], [Description] as [Label] from tenancy order by [Description]", dd_tenancy, tenancies_options);

                Dictionary<string, string> references_options = new Dictionary<string, string>();
                //references_options["usevalues"] = "";
                references_options["selecttype"] = "Label"; //Value
                references = WDCFunctions.buildandpopulateselect(strConnString, "select [Description] as [Label] from reference order by dbo.sort_reference(description)", dd_reference, references_options);

            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region parameters

            #endregion

            #region fields

            hf_propertyroll_id = Request.Form["hf_propertyroll_id"].Trim();
            tb_valuationnumber = Request.Form["tb_valuationnumber"].Trim();
            tb_propertyaddress = Request.Form["tb_propertyaddress"].Trim();
            dd_ward = Request.Form["dd_ward"].Trim();
            dd_council = Request.Form["dd_council"].Trim();
            tb_rates = Request.Form["tb_rates"].Trim();
            dd_year = Request.Form["dd_year"].Trim();
            dd_reference = Request.Form["dd_reference"].Trim();
            tb_page = Request.Form["tb_page"].Trim();
            tb_notes = Request.Form["tb_notes"].Trim();
            tb_propertydescription = Request.Form["tb_propertydescription"].Trim();
            dd_tenancy = Request.Form["dd_tenancy"].Trim();

            tb_occupiersurname = Request.Form["tb_occupiersurname"].Trim();
            tb_occupierfirstname = Request.Form["tb_occupierfirstname"].Trim();
            tb_occupierinitials = Request.Form["tb_occupierinitials"].Trim();
            tb_occupiertitle = Request.Form["tb_occupiertitle"].Trim();
            dd_occupiergender = Request.Form["dd_occupiergender"].Trim();
            tb_occupieroccupation = Request.Form["tb_occupieroccupation"].Trim();

            tb_ownersurname = Request.Form["tb_ownersurname"].Trim();
            tb_ownerfirstname = Request.Form["tb_ownerfirstname"].Trim();
            tb_ownerinitials = Request.Form["tb_ownerinitials"].Trim();
            tb_ownertitle = Request.Form["tb_ownertitle"].Trim();
            dd_ownergender = Request.Form["dd_ownergender"].Trim();
            tb_owneroccupation = Request.Form["tb_owneroccupation"].Trim();
            tb_owneraddress = Request.Form["tb_owneraddress"].Trim();

            dd_status = Request.Form["dd_status"].Trim();
            tb_internalnotes = Request.Form["tb_internalnotes"].Trim();

            #endregion

            String strConnString = "Data Source=192.168.0.204;Initial Catalog=PropertyRolls;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region setup specific data
            cmd.CommandText = "Update_Property_Roll";
            cmd.Parameters.Add("@propertyroll_id", SqlDbType.Int).Value = hf_propertyroll_id;
            cmd.Parameters.Add("@valuationnumber", SqlDbType.VarChar).Value = tb_valuationnumber;
            cmd.Parameters.Add("@propertyaddress", SqlDbType.VarChar).Value = tb_propertyaddress;
            cmd.Parameters.Add("@ward", SqlDbType.VarChar).Value = dd_ward;
            cmd.Parameters.Add("@council", SqlDbType.VarChar).Value = dd_council;
            cmd.Parameters.Add("@rates", SqlDbType.VarChar).Value = tb_rates;
            cmd.Parameters.Add("@year", SqlDbType.VarChar).Value = dd_year;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = dd_reference;
            cmd.Parameters.Add("@page", SqlDbType.VarChar).Value = tb_page;
            cmd.Parameters.Add("@notes", SqlDbType.VarChar).Value = tb_notes;
            cmd.Parameters.Add("@propertydescription", SqlDbType.VarChar).Value = tb_propertydescription;
            cmd.Parameters.Add("@tenancy", SqlDbType.VarChar).Value = dd_tenancy;
            cmd.Parameters.Add("@occupiersurname", SqlDbType.VarChar).Value = tb_occupiersurname;
            cmd.Parameters.Add("@occupierfirstname", SqlDbType.VarChar).Value = tb_occupierfirstname;
            cmd.Parameters.Add("@occupierinitials", SqlDbType.VarChar).Value = tb_occupierinitials;
            cmd.Parameters.Add("@occupiertitle", SqlDbType.VarChar).Value = tb_occupiertitle;
            cmd.Parameters.Add("@occupiergender", SqlDbType.VarChar).Value = dd_occupiergender;
            cmd.Parameters.Add("@occupieroccupation", SqlDbType.VarChar).Value = tb_occupieroccupation;
            cmd.Parameters.Add("@ownersurname", SqlDbType.VarChar).Value = tb_ownersurname;
            cmd.Parameters.Add("@ownerfirstname", SqlDbType.VarChar).Value = tb_ownerfirstname;
            cmd.Parameters.Add("@ownerinitials", SqlDbType.VarChar).Value = tb_ownerinitials;
            cmd.Parameters.Add("@ownertitle", SqlDbType.VarChar).Value = tb_ownertitle;
            cmd.Parameters.Add("@ownergender", SqlDbType.VarChar).Value = dd_ownergender;
            cmd.Parameters.Add("@owneroccupation", SqlDbType.VarChar).Value = tb_owneroccupation;
            cmd.Parameters.Add("@owneraddress", SqlDbType.VarChar).Value = tb_owneraddress;
            cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = dd_status;
            cmd.Parameters.Add("@internalnotes", SqlDbType.VarChar).Value = tb_internalnotes;

            #endregion

            #region save data (Standard)
            cmd.Connection = con;
            try
            {
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //submitter_ctr = dr["ctr"].ToString();
                }
                dr.Close();

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

            if (hf_propertyroll_id == "0")
            {
                Session["reference"] = dd_reference;
            } else
            {
                Session["reference"] = null;
            }


            Response.Redirect(Request.RawUrl);
        }
    }
}