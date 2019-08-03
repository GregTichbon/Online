using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction
{
    public partial class showmessage : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            switch (id)
            {
                case "closedmessage":
                    Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);
                    html = parameters["ClosedMessage"];
                    break;
            }
        }
    }
}