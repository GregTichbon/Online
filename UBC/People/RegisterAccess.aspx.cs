﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class RegisterAccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string usercode = Request.Form["tb_usercode"] ?? "";
            if(usercode == "")
            {
                usercode = "new";
            }
            Session["UBC_guid"] = usercode;
            Response.Redirect("register.aspx");
        }
    }
}