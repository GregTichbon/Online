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

namespace DataInnovations.SMS
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
        public string send_sms(NameValue[] formVars)    //you can't pass any querystring params
        {
            string SMSLog_ID = formVars.Form("SMSLog_ID");
            string PhoneNumber = formVars.Form("PhoneNumber");
            string Message = formVars.Form("Message");
            string ID = formVars.Form("ID");
            string Description = formVars.Form("Description");

            Generic.Functions gFunctions = new Generic.Functions();
            string result = "";
            foreach (string mobilex in PhoneNumber.Split(';'))
            {
                result += gFunctions.SendRemoteMessage(mobilex, Message, Description, SMSLog_ID) + "<br />";
            }

            /*
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Send_SMS";
            cmd.Parameters.Add("@SMSLog_ID", SqlDbType.VarChar).Value = SMSLog_ID;
            cmd.Parameters.Add("@PhoneNumber", SqlDbType.VarChar).Value = PhoneNumber;
            cmd.Parameters.Add("@Message", SqlDbType.VarChar).Value = Message;
            cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = ID;
            cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = Description;

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();
            */
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Sent";
            resultclass.message = result;
            resultclass.id = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }
    }
}

/*
 * region
public class NameValue
{
    public string name { get; set; }
    public string value { get; set; }
}

public class standardResponse
{
    public string status;
    public string message;
    public string id;
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
*/