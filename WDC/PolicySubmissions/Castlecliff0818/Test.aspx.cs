using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PolicySubmissions.Castlecliff0818
{
    public partial class Test : System.Web.UI.Page
    {
        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };
        public string[] agegroups = new string[6] { "Under 18 years", "18 - 29 years", "30 - 39 years", "40 - 49 years", "50 - 59 years", "60 years or over" };
        public string[] ratings1 = new string[5] { "Strongly<br />agree", "Agree", "Neither<br />agree<br />nor<br />disagree", "Disagree", "Strongly<br />disagree" };
        public string administration = "";
        public DateTime closes;
        public string closesfull;
        public string form;
        public string formlink;
        public string title;
        public string shorttitle;
        public string submissionshearing;
        public string bylawpolicy;
        public string SP;
        public string shortname;
        public string specificemailsubject;
        public string reference;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}