using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction
{
    public partial class Register : System.Web.UI.Page
    {
        public string TermsAndConditions;


        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters;
            parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);
            TermsAndConditions = parameters["TermsAndConditions"];
        }
    }
}