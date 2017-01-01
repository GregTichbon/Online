using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace TeOranganui
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("user_id");
            Session.Remove("user_name");
            Session.Remove("user_initials");
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

           
        }
        
    }
}