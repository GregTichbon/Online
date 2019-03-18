using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Administration.ACO
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
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string updatecrm(NameValue[] formVars)    //you can't pass any querystring params
        {
            #region setup for database (Standard)

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            #endregion

            #region setup specific data
            cmd.CommandText = "ACO_Update_CRM";

            cmd.Parameters.Add("@ramprocessctr", SqlDbType.VarChar).Value = formVars.Form("hf_ramprocessctr");
            cmd.Parameters.Add("@notes", SqlDbType.VarChar).Value = formVars.Form("tb_notes");
            cmd.Parameters.Add("@resolve", SqlDbType.VarChar).Value = formVars.Form("cb_resolve");
            cmd.Parameters.Add("@correspondence", SqlDbType.VarChar).Value = formVars.Form("cb_correspondence");
            cmd.Parameters.Add("@animal_ctr", SqlDbType.VarChar).Value = formVars.Form("tb_dog");

            #endregion

            #region save data (Standard)
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

            #endregion

            
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