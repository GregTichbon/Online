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

namespace Online.FCP
{
    public partial class FoodBusinessRegistration1 : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";

        static string moduleName = "FoodBusinessRegistration";

        public string[] businesstypes = new string[3] { "Company", "Partnership", "Individual" };
        public string[] verificationagencies = new string[10] { "Whanganui District Council", "Assured Audits New Zealand Limited", "AssureQuality Limited", "Eurofins NZ Laboratory Services Limited", "MPI Verification Services", "Quality Auditing Specialists Limited", "SGS New Zealand Limited", "Telarc SAI Limited", "Sandra de Vries t/a Snap Audits NZ", "The Food Auditor Limited" };
        public string[] registrationtypes = new string[4] { "MPI template food control plan: Food Service, Care Safe and Specialist Retail", "NP3 (National Programme level 3)", "NP3 (National Programme level 2)", "NP3 (National Programme level 1)" };


        

        //static string moduleName = "FoodBusinessRegistration";

        static Boolean inhibit_entity = true;
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
        public string tb_businessnumber;
        public string tb_registrationnumbers;

        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            {
                tb_businessname = "Business Name";

            }

            if (Session[moduleName + "Submitted"] == "Yes")
            {
                Session[moduleName + "Submitted"] = "No";
                Response.Redirect("/");
            }

            #region Check Entity Entered (Standard)
            WDCFunctions.WDCFunctions.Log(Request.RawUrl, "Starting", "");

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

        }
    }
}