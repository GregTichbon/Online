using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC
{
    public partial class SurveySep2018 : System.Web.UI.Page
    {
        public string hf_guid;
        public string[] school = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gender = new string[2] { "Female", "Male" };

        public string[] yesno = new string[2] { "Yes", "No" };
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}