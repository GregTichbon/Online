using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.PropertyRolls
{
    public partial class Search : System.Web.UI.Page
    {
        public string years;
        public string references;
        public string[] statuses = new string[3] { "Requires checking", "Doesn't require checking", "Checked" };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["proproll_administrator"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            String strConnString = "Data Source=192.168.0.204;Initial Catalog=PropertyRolls;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            Dictionary<string, string> years_options = new Dictionary<string, string>();
            //years_options["usevalues"] = "";
            years_options["selecttype"] = "Label"; //Value
            years = WDCFunctions.buildandpopulateselect(strConnString, "select year as [Label] from PropertyRoll group by year order by year", "", years_options);

            Dictionary<string, string> references_options = new Dictionary<string, string>();
            //references_options["usevalues"] = "";
            references_options["selecttype"] = "Label"; //Value
            references = WDCFunctions.buildandpopulateselect(strConnString, "select reference as [Label] from PropertyRoll group by reference order by reference", "", references_options);

        }

    }
}
