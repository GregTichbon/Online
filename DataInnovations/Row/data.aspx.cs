using Generic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Row
{
    public partial class data1 : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string Discipline = Request.QueryString["Discipline"];
            Functions genericfunctions = new Functions();
            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
            functionoptions.Add("storedprocedure", "");
            functionoptions.Add("usevalues", "");
            functionoptions.Add("parameters", "|" + Discipline + "|");
            //html = genericfunctions.buildandpopulateselect(strConnString, "@boats", "", functionoptions, "None");
        }
    }
}