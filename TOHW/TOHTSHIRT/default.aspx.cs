using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.TOHTSHIRT
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Server.MapPath(@"images");
            foreach (string fileName in Directory.GetFiles(path))
            {
                //Lit_HTML.Text += "<img src=\"images\\" + Path.GetFileName(fileName) + "\" />";
            }
        }
    }
}