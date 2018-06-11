using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class TestImage1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Server.MapPath("/") + "PhotoHunt11Jun18\\UBC.jpg";

            FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read);
            byte[] data = new byte[(int)fileStream.Length];
            fileStream.Read(data, 0, data.Length);

            //return Json(new { base64imgage = Convert.ToBase64String(data) }, JsonRequestBehavior.AllowGet);

            //https://www.codeproject.com/Articles/201767/Load-Base-Images-using-jQuery-and-MVC
            //https://www.codeproject.com/Articles/7246/Display-Images-from-Database-in-ASP

        }
    }
}