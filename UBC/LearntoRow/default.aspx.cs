using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.LearntoRow
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string redirect = "../people/signup";
            string id = Request.QueryString["ID"] ?? "";
            if(id != "")
            {
                redirect += "?id=" + id;
            }

            Response.Redirect(redirect);
        }
    }
}