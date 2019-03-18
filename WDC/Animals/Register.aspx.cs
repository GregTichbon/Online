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
using System.Text.RegularExpressions;
using System.Web.Configuration;

namespace Online.Animals
{
    public partial class Register : System.Web.UI.Page
    {

        static string moduleName = "Animals";
        string folder = "Animals"; // WebConfigurationManager.AppSettings[moduleName + ".folder"];
        string form = "Register"; // WebConfigurationManager.AppSettings[moduleName + ".form"];

        #region fields

        public string tb_lastname;
        public string tb_firstname;
        public string tb_othernames;
        public string tb_knownas;
        public string tb_residentialaddress;
        public string tb_postaladdress;
        public string tb_emailaddress;
        public string tb_mobilephone;
        public string tb_homephone;
        public string tb_workphone;
        public string dd_gender;
        public string dd_gender_value;
        public string tb_dateofbirth;

        public string breeds;
        public string colours;
        #endregion

        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };

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


                tb_reference.Text = WDCFunctions.getReference("datetime");

                String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;

                Dictionary<string, string> breeds_options = new Dictionary<string, string>();
                breeds_options["usevalues"] = "";
                breeds_options["selecttype"] = "Value";
                breeds_options["storedprocedure"] = "";
                breeds = WDCFunctions.buildandpopulateselect(strConnString, "select DESCRIPTOR_VALUE as [Value], DESCRIPTION as [Label] from @@nucdescriptor where DESCRIPTOR_TYPE = '#ANIBRD' order by [description]", "", breeds_options);

            }
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {


        }
    }
}

