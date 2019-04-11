using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class Hubble1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
            Dictionary<string, string> metaAllFields = new Dictionary<string, string>(2);
            metaAllFields.Add("DocumentType", "CORRESPONDENCE, Email, Memo, Survey");
            metaAllFields.Add("Narrative", "Venue");
            //metaAllFields.Add("PropertyNo", Request.Form["hf_property_number"]);
            string hubbleurl = "https://hubble.whanganui.govt.nz/"; // WebConfigurationManager.AppSettings["hubbleurl"];

            HF.UploadFile(hubbleurl + "team/venue/", "Team Administration", "admin/", "Online Venue Feedback - Reference " + "Please Delete" + ".html", Encoding.ASCII.GetBytes("Test"), metaAllFields);

        }
    }
}