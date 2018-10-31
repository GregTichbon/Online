﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC.Training
{
    public partial class ZoneTraining : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "101"))
            {
                Response.Redirect("~/default.aspx");
            }
        }
    }
}