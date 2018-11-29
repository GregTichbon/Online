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

namespace DataInnovations.Row
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS

    public class posts : System.Web.Services.WebService
    {

        [WebMethod]
        public string recordtime(NameValue[] formVars)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand("record_time", con);
            cmd.CommandType = CommandType.StoredProcedure;
            /*
            cmd.Parameters.Clear();
            string RaceTimer_CTR = formVars.Form("RaceTimer_CTR");
            string mode = formVars.Form("mode");
            string time = formVars.Form("time");
            */

            cmd.Parameters.Add("@RaceTimer_CTR", SqlDbType.VarChar).Value = formVars.Form("RaceTimer_CTR");
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = formVars.Form("mode");
            cmd.Parameters.Add("@time", SqlDbType.VarChar).Value = formVars.Form("time");
            cmd.Parameters.Add("@lane", SqlDbType.VarChar).Value = formVars.Form("lane");

            cmd.Connection = con;
            try
            {
                cmd.ExecuteScalar();
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

            standardResponse resultclass = new standardResponse();
            resultclass.status = "OK";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }
    }

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
