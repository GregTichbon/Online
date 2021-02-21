using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.Go.Register
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string url = "https://ubc.org.nz/people/register.aspx";
            string url = "~/people/register.aspx";

            string id = Request.QueryString["id"] ?? "";
            if(id != "")
            {
                url += "?id=" + id;
            }
            Response.Redirect(url);
        }
    }
}