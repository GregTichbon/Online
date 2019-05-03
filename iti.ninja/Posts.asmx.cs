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

namespace iti.ninja
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

        public string test1(NameValue[] formVars)    //you can't pass any querystring params
        {
            standardResponse resultclass = new standardResponse();
            resultclass.status = "xxx";
            resultclass.message = "";

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string test2(string param1 = "", string param2 = "")    //you can't pass any querystring params
        {
            standardResponse resultclass = new standardResponse();
            resultclass.status = "xxx";
            resultclass.message = "";

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string test3(string param1 = "", string param2 = "")    //you can't pass any querystring params
        {
            standardResponse resultclass = new standardResponse();
            resultclass.status = "xxx";
            resultclass.message = "";

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }


        [WebMethod]
        public standardResponse Create_Link(string link = "", string datetimefrom = "", string datetimeto = "", string url = "", string description = "", string recordlog = "")    //you can't pass any querystring params
        {

            string strConnString = "Data Source=localhost\\MSSQLSERVER2016;Initial Catalog=Iti_Ninja;Integrated Security=False;user id=iti_ninja;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Create_Link";
            cmd.Parameters.Add("@link", SqlDbType.VarChar).Value = link;
            cmd.Parameters.Add("@datetimefrom", SqlDbType.VarChar).Value = datetimefrom;
            cmd.Parameters.Add("@datetimeto", SqlDbType.VarChar).Value = datetimeto;
            cmd.Parameters.Add("@url", SqlDbType.VarChar).Value = url;
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = description;
            cmd.Parameters.Add("@recordlog", SqlDbType.VarChar).Value = recordlog;

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();

            //return (result);
           
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Done";
            resultclass.message = "";
            resultclass.value = result;
            return (resultclass);

            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
           

        }
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
    public string value;
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

