using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class UBC2019ALogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if(tb_accesscode.Text == "finestcuts")
            {
                /*
                HttpCookie myCookie = new HttpCookie("chefschoiceaccess");
                myCookie.Value = "";
                myCookie.Expires = DateTime.Now.AddDays(1d);
                Response.Cookies.Add(myCookie);
                */
                Response.Cookies["chefschoiceaccess"].Value = "1";
                Response.Cookies["chefschoiceaccess"].Expires = DateTime.Now.AddYears(1);

                string directto = Session["raffle_goto"] + "";
                if (directto == "")
                {
                    directto = "UBC2019AVoucher.aspx";
                }

                Response.Redirect(directto);
            }
            else
            {
                Response.Cookies["chefschoiceaccess"].Expires = DateTime.Now.AddDays(-1);
            }
        }
    }
}