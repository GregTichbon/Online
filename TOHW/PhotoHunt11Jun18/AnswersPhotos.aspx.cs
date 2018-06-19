using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class AnswersPhotos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string groupcode = Request.QueryString["groupcode"];
            string photo = Request.QueryString["photo"];

            string path = Server.MapPath("\\PhotoHunt11Jun18\\images\\answers\\" + groupcode + "\\" + photo);
            string[] files = Directory.GetFiles(path);
            foreach (string fileName in files)
            {
                Lit_html.Text += "Photo: " + photo + " <a href=\"javascript:void(0)\" class=\"rotate\" data-filename=\"" + fileName + "\" data-direction=\"-90\" data-groupcode=\"" + groupcode + "\" data-photo=\"" + photo + "\">Rotate counter-clockwise</a> | <a href=\"javascript:void(0)\" class=\"rotate\" data-filename=\"" + fileName + "\" data-direction=\"90\" data-groupcode=\"" + groupcode + "\" data-photo=\"" + photo + "\">Rotate clockwise</a><br />";
                Lit_html.Text += "<img src=\"images/answers/" + groupcode + "/" + photo + "/" + Path.GetFileName(fileName) + "\" />";
            }

        }
    }
}