using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Cemetery
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
        public string walkupdate(NameValue[] formVars)    //you can't pass any querystring params
        {
            string submissionperiod = WebConfigurationManager.AppSettings["CommunityContracts.submissionperiod"];


            #region fields
            string hf_plotid = formVars.Form("hf_plotid");
            string plot = formVars.Form("plot");
            string hf_snapshot = formVars.Form("hf_snapshot");
            #endregion

            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

            SqlConnection con = new SqlConnection(strConnString);

            //Updates GISOverride in both databasese 
            SqlCommand cmd = new SqlCommand("Update_PlotLocation", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@plotid", SqlDbType.VarChar).Value = hf_plotid;
            cmd.Parameters.Add("@GISID", SqlDbType.VarChar).Value = plot;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //updateresult.status = dr["status"].ToString();
                    //updateresult.message = dr["message"].ToString();
                    //updateresult.id = dr["id"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            if (hf_snapshot != "")
            {
                //string submissionpath = WebConfigurationManager.AppSettings["CommunityContractsApplication" + ".submissionpath"] + "\\" + Request.Form["reference"] + "\\";
                string submissionpath = "F:\\inetpub\\online\\assets\\cemetery\\images\\" + hf_plotid + "\\Draft\\";
                //string submissionpath = "C:\\temp\\" + hf_plotid + "\\Draft\\";



                if (!Directory.Exists(submissionpath))
                {
                    Directory.CreateDirectory(submissionpath);
                }

                int c1;
                string newfilename;

                c1 = 0;

                do
                {
                    c1 = c1 + 1;
                    newfilename = "WalkUpdate" + "_" + c1.ToString("000") + ".jpg";
                } while (File.Exists(submissionpath + newfilename));

                var bytes = Convert.FromBase64String(hf_snapshot);
                using (var imageFile = new FileStream(submissionpath + newfilename, FileMode.Create))
                {
                    imageFile.Write(bytes, 0, bytes.Length);
                    imageFile.Flush();
                }


            }


            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string SaveImage(string imageData, string ids)    //you can't pass any querystring params
        {
            string dt = DateTime.Now.ToString("ddMMyyHHss");
            foreach (string id in ids.Split(','))
            {
                string path = @"F:\InetPub\Online\Assets\Cemetery\Images\" + id;
                Directory.CreateDirectory(path + "\\original");
                string fileName = "\\" + id + "_" + dt + ".jpg";
                using (FileStream fs = new FileStream(path + "\\original" + fileName, FileMode.Create))
                {
                    using (BinaryWriter bw = new BinaryWriter(fs))
                    {
                        byte[] data = Convert.FromBase64String(imageData);
                        bw.Write(data);
                        bw.Close();
                    }
                }

                using (System.Drawing.Image original = System.Drawing.Image.FromFile(path + "\\original" + fileName))
                {
                    double scaler = Convert.ToDouble(  original.Width / 640.000000);
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
            }


            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }
    }

    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class standardResponse
    {
        public string status;
        public string message;
    }

    #endregion

    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}
