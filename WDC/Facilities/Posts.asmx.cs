using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Facilities
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
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string process_event(string formVars)
        {
            JArray array = JArray.Parse("[" + formVars + "]");
            //JArray array = JArray.Parse( formVars );

            string mode = array[0]["mode"].ToString();
            string action = mode;

            if(action == "Flag Delete")
            {
                action = "Delete";
            } else if (action == "Create") {
                action = "Update";
            }

            //var xx = prop1["mode"];
            //JArray array = JsonConvert.DeserializeObject<JArray>("[" + formVars + "]");

            //string mode = array.Children<JProperty>().FirstOrDefault().Name;
            string SP = "facilities_" + action + "_event";

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = SP;


            foreach (JObject item in array)
            {
                foreach (var prop in item.Children<JProperty>())
                {
                    //add param:  Console.WriteLine(prop.Name + ": " + prop.Value);
                    cmd.Parameters.Add("@" + prop.Name, SqlDbType.VarChar).Value = prop.Value;
                }
            }

            string ctr = "";
            string validation = "";
            string validationinternal = "";
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    ctr = dr["ctr"].ToString();
                    validation = dr["validation"].ToString();
                    validationinternal = dr["validationinternal"].ToString();
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

            standardResponse resultclass = new standardResponse();
            resultclass.ctr = ctr;
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
        public string @ctr = null;
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
