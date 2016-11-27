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

namespace Online.CommunityContract
{
    public partial class Application : System.Web.UI.Page
    {
        public string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];
        public string[] yesno_values = new string[2] { "Yes", "No" };
        public string selected;
        public string[] dd_fundingtype_values = new string[3] {"1 off", "Seeding", "Matching"};

        #region fields
        public string tb_reference;
        public string tb_groupreference;
        public string dd_fundingtype;
        public string tb_projectname;
        public string tb_projectdescription;
        public string tb_peopledirectbenefit;
        public string tb_outcomes;
        public string tb_deeplyunited;
        public string tb_globallyconnected;
        public string tb_creativesmarts;
        public string tb_flowingwithrichness;
        public string tb_worksforeveryone;
        public string tb_saferwhanganui;
        public string tb_collaboration;
        public string fu_additionalfiles;
        public string tb_projectcost;
        public string tb_owncontributions;
        public string tb_committedfunding;
        public string tb_fundingapplications;
        public string tb_councilcontribution;
        public string tb_committedfunders;
        public string tb_fundersappliedto;
        public string tb_applicantname;
        public string tb_applicantposition;
        public string tb_applicantemail;
        public string tb_emailconfirm;
        public string tb_applicantphone;
        public string tb_applicantmobile;
        public string dd_finalised;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}