using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;


namespace TeOranganui
{
    public partial class TeOranganui : System.Web.UI.MasterPage
    {
        public string headerimage;

        public string webconfig;

        protected void Page_Load(object sender, EventArgs e)
        {
            webconfig = ConfigurationManager.AppSettings["ConfigName"];
            string fp = this.Page.Request.FilePath;
            





        }
    }
}