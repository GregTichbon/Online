using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace TOHW.Pickups
{
    /// <summary>
    /// Summary description for GetImage
    /// </summary>
    public class GetImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            /*
            string filename = @"C:\temp\stirlingsports.png";
            var response = context.Response;
            response.AddHeader("content-disposition", "attachment; filename=Test");
            response.ContentType = "png";
            response.BinaryWrite((byte[])File.ReadAllBytes(filename));
            */

            /*
            Image i = Image.FromFile("c:\\foo");
            if (System.Drawing.Imaging.ImageFormat.Jpeg.Equals(i.RawFormat))
                MessageBox.Show("JPEG");
            else if (System.Drawing.Imaging.ImageFormat.Gif.Equals(i.RawFormat))
                MessageBox.Show("GIF");
                */

            var id = "1175"; // context.Request["id"];
            id = "1";

            /*

            context.Response.ContentType = "image/BMP";
            Stream strm = GetImageFromDatabase(id);
            byte[] buffer = new byte[4096];
            int byteSeq = strm.Read(buffer, 0, 4096);

            while (byteSeq > 0)
            {
                context.Response.OutputStream.Write(buffer, 0, byteSeq);
                byteSeq = strm.Read(buffer, 0, 4096);
            }
            */

            
            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(strConnString);

            string sql = "SELECT image FROM entity WHERE id = @ID";
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", id);
            connection.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            context.Response.ContentType = "image/BMP";

            //Bitmap bmp = new Bitmap(new MemoryStream(bytes));
            //Bitmap bmp = new Bitmap(new MemoryStream((byte[])dr[0]));

            MemoryStream ms = new MemoryStream((byte[])dr[0]);

            Image xx = System.Drawing.Image.FromStream(ms,false,true);

            context.Response.Write(xx);

            //context.Response.BinaryWrite((Byte[])bmp);

        }

        public Stream GetImageFromDatabase(string id)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(strConnString);

            string sql = "SELECT image FROM entity WHERE id = @ID";
            SqlCommand cmd = new SqlCommand(sql, connection);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", id);
            connection.Open();
            object img = cmd.ExecuteScalar();
            try
            {
                return new MemoryStream((byte[])img);
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }
        }
        public bool IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}