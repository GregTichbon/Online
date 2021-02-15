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
    public partial class PhotoVersions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string imagepath = "images\\originals";
            string[] files = Directory.GetFiles(MapPath(imagepath), "*", SearchOption.TopDirectoryOnly);
            foreach (string filename in files)
            {
                Lit_Images.Text += "<tr>";

                string fileid = Path.GetFileNameWithoutExtension(filename);
                Lit_Images.Text += "<td><img class=\"original\" id=\"image_" + fileid + "\" src =\"images/originals/" + Path.GetFileName(filename) + "\"></td>";
                int version = 0;


                using (SqlConnection con = new SqlConnection(strConnString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("PH_Get_Photo_Details", con))
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@photo_ctr", SqlDbType.VarChar).Value = fileid;

                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {

                            dr.Read();
                            string description = dr["description"].ToString();
                            //Lit_Images.Text += description;

                            do
                            {
                                version = (int)dr["version"];
                                if (version != 0)
                                {
                                    string photoversion_ctr = dr["photoversion_ctr"].ToString();
                                    string guid = dr["guid"].ToString();
                                    Lit_Images.Text += "<td><img data-photo=\"" + fileid + "\" data-version=\"" + version + "\" class=\"version\" id=\"image_" + fileid + "_" + version.ToString() + "\" src =\"images/" + guid + ".jpg\"></td>";
                                }
                            } while (dr.Read());
                            for (int f1 = version + 1; f1 <= 4; f1++)
                            {
                                Lit_Images.Text += "<td><img data-photo=\"" + fileid + "\" data-version=\"" + f1 + "\" class=\"version notset\" id=\"image_" + fileid + "_" + f1.ToString() + "\" src =\"images/qm.png\"></td>";
                            }
                        }
                        else
                        {
                            Lit_Images.Text += "<td colspan=\"4\">Not found in the database</td>";
                        }
 
                        dr.Close();
                    }
                }
                Lit_Images.Text += "</tr>";
            }
        }
    }
}