using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Xml;
using System.IO;
using Generic;
using System.Net;
using Newtonsoft.Json.Linq;

namespace TOHW.PhotoHunt11Jun18
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS

    public class Posts : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public standardResponse SaveAnswer(string imageData, string groupcode, string photo_ctr)    //you can't pass any querystring params
        {
            string path = Server.MapPath("\\PhotoHunt11Jun18\\images\\answers\\" + groupcode + "\\" + photo_ctr);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("PH_Update_Group_Photos", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@GroupCode", SqlDbType.VarChar).Value = groupcode; //1111; //
                    cmd.Parameters.Add("@Photo_CTR", SqlDbType.VarChar).Value = photo_ctr;

                    cmd.ExecuteNonQuery();

                }
            }

            int c1 = 0;
            string wpfilename = path + "\\Answer";
            string filename = "";
            do
            {
                c1++;
                filename = wpfilename + "_" + c1.ToString("000") + ".jpg";
            } while (File.Exists(filename));

            using (FileStream fs = new FileStream(filename, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData.Split(',')[1]);
                    bw.Write(data);
                    bw.Close();
                }
            }

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = "";
            return (resultclass);

        }
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public standardResponse SavePhoto(string imageData, string photo, string version)    //you can't pass any querystring params
        {
            string path = Server.MapPath("images");

            string guid = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("PH_Get_Photo", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@photo_ctr", SqlDbType.VarChar).Value = photo;
                    cmd.Parameters.Add("@version", SqlDbType.VarChar).Value = version;

                    SqlDataReader dr = cmd.ExecuteReader();
                    dr.Read();
                    guid = dr["guid"].ToString();
                    dr.Close();

                }
            }


            string fileName = "\\" + guid + ".jpg";
            using (FileStream fs = new FileStream(path + fileName, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))
                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
            }
            /*
            using (System.Drawing.Image original = System.Drawing.Image.FromFile(path + "\\original" + fileName))
            {
                double scaler = Convert.ToDouble(original.Width / 640.000000);
                int newHeight = Convert.ToInt16(original.Height / scaler);
                int newWidth = 640;

                using (System.Drawing.Bitmap newPic = new System.Drawing.Bitmap(newWidth, newHeight))
                {
                    using (System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(newPic))
                    {
                        gr.DrawImage(original, 0, 0, (newWidth), (newHeight));
                        newPic.Save(path + fileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                }
            }
            */
           
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = guid;
            return (resultclass);

        }
    }
    public class standardResponse 
    {
        public string status;
        public string message;
        public string id;
    }
}
