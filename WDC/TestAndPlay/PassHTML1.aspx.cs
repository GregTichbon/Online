using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class PassHTML1 : System.Web.UI.Page
    {
        //public string passvar = "";
        protected string passvar = "";



        protected void Page_Load(object sender, EventArgs e)
        {
            //passvar = "<a href=\"#\">Click Me</a>";
            passvar = @"<a href=""#"">Click Me</a>";

            Literal1.Text = passvar;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}