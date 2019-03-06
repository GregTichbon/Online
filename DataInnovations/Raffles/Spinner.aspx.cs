using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class Spinner : System.Web.UI.Page
    {
        public string html;
        public string numbers;
        protected void Page_Load(object sender, EventArgs e)
        {
            numbers = "";
            string delim = "";
            for (int i = 1; i <= 50; i++)
            {
                numbers += delim + "c" + i.ToString() + "=" + i.ToString();   //1=1&c2=2&c3=3&c4=4&c5=5&c6=6";
                delim = "&";
            }
            html = "<iframe src=\"https://wheeldecide.com/e.php?" + numbers + "&time=5\" width=\"500\" height=\"500\" scrolling=\"no\" frameborder=\"0\"></iframe>";
        }
    }
}