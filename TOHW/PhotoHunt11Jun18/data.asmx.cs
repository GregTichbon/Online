using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace TOHW.PhotoHunt11Jun18
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS
    /// 
    public class data : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
        public void get_next_version(string groupcode, string photo)
        {
            //PH_get_next_version

            imageversion resultclass = new imageversion();

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("PH_Show_Photo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@groupcode", SqlDbType.BigInt).Value = groupcode;
            cmd.Parameters.Add("@photo", SqlDbType.BigInt).Value = photo;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    resultclass.src = "images\\" + dr["guid"].ToString() + ".jpg";
                    resultclass.version = dr["version"].ToString();
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



            //resultclass.src = "ubc.jpg";
            //resultclass.version = "3";

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);

            Context.Response.Write(passresult);


            
        }



        
    }
    public class imageversion
    {
        public string src;
        public string version;
    }
}
