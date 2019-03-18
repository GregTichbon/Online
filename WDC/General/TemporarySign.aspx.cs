using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.General
{
    public partial class TemporarySign : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = " selected";
        public string[] yesno_values = new string[2] { "Yes", "No" };

        public string[] dd_purpose_values = new string[3] { "Election", "Event", "Community information" };
        public string[] yes_values = new string[1] { "Yes" };

        #endregion

        #region fields
        public string reference;
        public string tb_applicant;
        public string tb_organisation;
        public string tb_charityregistration;
        public string tb_emailaddress;
        public string tb_postaladdress;
        public string tb_invoiceaddress;
        public string tb_mobilephone;
        public string tb_homephone;
        public string tb_workphone;

        public string dd_purpose;
        public string tb_otherinformation;
        public string dd_requirements;

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

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
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}