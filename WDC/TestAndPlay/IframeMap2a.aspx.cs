using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class IframeMap2a : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string src = Request.Url.Query.Substring(1);
            //string src = Request.QueryString.ToString();
            lit_map.Text = src;
            lit_map.Text += "<iframe style=\"width:100%;height:400px\" " + src + "\"></iframe>";

        }
    }
}