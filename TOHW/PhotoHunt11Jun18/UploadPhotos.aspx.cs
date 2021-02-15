using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class UploadPhotos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (fu_photos.HasFiles)
            {
                string imagepath = MapPath("images\\originals");

                string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                string photo_ctr = "";
                foreach (var file in fu_photos.PostedFiles)
                {
                    using (SqlConnection con = new SqlConnection(strConnString))
                    {
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("PH_CreatePhoto", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = "Unnamed";
                            photo_ctr = cmd.ExecuteScalar().ToString();
                        }

                        file.SaveAs(Path.Combine(imagepath, photo_ctr + Path.GetExtension(file.FileName)));

                    }
                }
            }
        }
    }
}