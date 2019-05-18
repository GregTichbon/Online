using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Xml;
//using OfficeOpenXml;
using System.IO;
//using Generic;

namespace Auction
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
        public string Update_User(NameValue[] formVars)    //you can't pass any querystring params
        {
            string URL = formVars.Form("URL");
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(URL);

            string fullname = formVars.Form("fullname");
            string emailaddress = formVars.Form("emailaddress");
            string passcode = formVars.Form("passcode");
            string mobilenumber = formVars.Form("mobilenumber");
            string textnotifications = formVars.Form("textnotifications");
            string contactpermission = formVars.Form("contactpermission");


            string strConnString = "Data Source=toh-app;Initial Catalog=Auction;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_User";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@fullname", SqlDbType.VarChar).Value = fullname;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = emailaddress;
            cmd.Parameters.Add("@passcode", SqlDbType.VarChar).Value = passcode;
            cmd.Parameters.Add("@mobilenumber", SqlDbType.VarChar).Value = mobilenumber;
            cmd.Parameters.Add("@textnotifications", SqlDbType.VarChar).Value = textnotifications;
            cmd.Parameters.Add("@contactpermission", SqlDbType.VarChar).Value = contactpermission;
            

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = result;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

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

