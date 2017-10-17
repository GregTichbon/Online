using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iti.ninja
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = Request.Url.ToString().Substring(54);
            //http://iti.ninja/default.aspx?404;http://iti.ninja:80/
            //Literal1.Text = Request.Url.AbsolutePath + "<br />" + Request.Url.AbsoluteUri + "<br />" + Request.Url.LocalPath + "<br />" + Request.Url.PathAndQuery;
            int firstdelim = (url + "/").IndexOf("/");
            string main = url.Substring(0, firstdelim).ToUpper();
            string extra = url.Substring(firstdelim);
            string redirect = "";
            switch (main) {
                case "ACO":
                    redirect = "http://wdc.whanganui.govt.nz/online/administration/aco/";
                    break;
                case "WDCO":
                    redirect = "http://wdc.whanganui.govt.nz/online/";
                    break;
                case "WDCOT":
                    redirect = "http://wdc.whanganui.govt.nz/onlinetest/";
                    break;
            }
            redirect += extra;
            Response.Redirect(redirect);
            //Literal1.Text = redirect;
        }
    }
}