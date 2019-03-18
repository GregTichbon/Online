using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;

namespace Online.TestAndPlay
{
    /// <summary>
    /// Summary description for ImageStreamHandler1
    /// </summary>
    public class ImageStreamHandler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            /*
            var id = context.Request["id"];

            string strConnString = "Data Source=192.168.1.149;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Image", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();

            #region setup specific data
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;

            #endregion
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                dr.Read();
            }

            con.Close();
            con.Dispose();
            */



            string filename = @"\\WDC-DVMAIN2\GregT\Stuff\20100322.jpg";
            var response = context.Response;
            response.AddHeader("content-disposition", "attachment; filename=Test");
            response.ContentType = "jpg";
            //response.BinaryWrite((byte[])dr["image"]);

            int fitin = 10000;

            Image uploaded = Image.FromFile(filename);
            int originalWidth = uploaded.Width;
            int originalHeight = uploaded.Height;
            float percentWidth = (float)fitin / (float)originalWidth;
            float percentHeight = (float)fitin / (float)originalHeight;
            float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
            int newWidth = (int)(originalWidth * percent);
            int newHeight = (int)(originalHeight * percent);

            Image newImage = new Bitmap(newWidth, newHeight);
            using (Graphics g = Graphics.FromImage(newImage))
            {
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.DrawImage(uploaded, 0, 0, newWidth, newHeight);
            }
 
            ImageConverter _imageConverter = new ImageConverter();
            byte[] xByte = (byte[])_imageConverter.ConvertTo(newImage, typeof(byte[]));

            response.BinaryWrite((byte[])xByte);



            //response.BinaryWrite((byte[])File.ReadAllBytes(filename));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}