using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class HubbleUpload1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string document = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
            Dictionary<string, string> metaAllFields = new Dictionary<string, string>(2);
            metaAllFields.Add("DocumentType", "CORRESPONDENCE, Email, Memo, Survey");
            metaAllFields.Add("PropertyNo", "2710");
            WDCFunctions.HubbleFunctions HF = new WDCFunctions.HubbleFunctions();
            HF.UploadFile("http://hubbletest.wanganui.govt.nz/site/corp/rates/", "Activity Management", "actmgt/", "Online direct debit application 9999.html", Encoding.ASCII.GetBytes(document), metaAllFields);

        }
    }
}