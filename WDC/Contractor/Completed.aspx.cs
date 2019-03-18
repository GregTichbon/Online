using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Contractor
{
    public partial class Completed : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            lit_screendocument.Text = Session["contractor_Body"].ToString();
        }
    }
}