using Generic;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
            {
                Response.Redirect("~/default.aspx");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            foreach (HttpPostedFile postedFile in files.PostedFiles)
            {
                if (postedFile.FileName != "")
                {
                    int c1 = 0;

                    string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);
                    string filepath = Request.Form["uploadto"].ToString();
                    string originalpath = Server.MapPath(filepath); 

                    string newfilename = postedFile.FileName;
                    while (File.Exists(originalpath + "\\" + newfilename))
                    {
                        c1++;
                        newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;

                    }

                    postedFile.SaveAs(originalpath + "\\" + newfilename);
                    Response.Write(newfilename + " uploaded<br />");
                }
            }
        }
    }
}