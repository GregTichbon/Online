using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Administration
{
    public partial class ReferenceNumbers : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
            html = "";
            for(int x = 1; x<= Convert.ToInt16 (tb_number.Text); x++ ) { 
                html += WDCFunctions.getReference(dd_type.SelectedValue) + "<BR />";
            }
        }
    }
}