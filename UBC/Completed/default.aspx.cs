using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.Completed
{
    public partial class _default : System.Web.UI.Page
    {
        public string html_body;
        protected void Page_Load(object sender, EventArgs e)
        {
            html_body = Session["UBC_body"].ToString();
        }
    }
}