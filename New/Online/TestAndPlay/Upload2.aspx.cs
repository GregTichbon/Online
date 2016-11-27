using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class Upload2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            var Request = HttpContext.Current.Request;
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                var xx = Request.Files.AllKeys[i];
                var file = Request.Files[i];
                Response.Write(xx + "=" +  file.FileName + "<br />");
            }

        }
    }
}