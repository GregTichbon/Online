using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class SendText : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Generic.Functions gFunctions = new Generic.Functions();
            string xx = gFunctions.SendMessage("0272495088", "Test").ToString();

            Response.Write(xx);
        }
    }
}