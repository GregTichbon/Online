﻿using System;
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


namespace BadHagrid
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
        public string send_text(string PhoneNumber, string Message, string Inject, string Greeting)
        {
            Message = Message.Replace("||greeting||", Greeting);
            string[] fields = Inject.Split(',');
            int c1 = 0;
            foreach (string field in fields)
            {
                c1++;

                Message = Message.Replace("||" + c1.ToString() + "||", field);
            }


            Generic.Functions gFunctions = new Generic.Functions();
            string response = gFunctions.SendRemoteMessage(PhoneNumber, Message, "Bad Hagrid Bulk");
            //string response = Message;
            return response;
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
        public string HelloWorld1(string param1)
        {
            return (param1);
        }
        [WebMethod]
        public string HelloWorld2(string param1, string param2)
        {

            return (param1 + " " + param2);
        }

        [WebMethod]
        public standardResponse Update_BadHagrid(NameValue[] formVars)    //you can't pass any querystring params
        {
            string name = formVars.Form("name");
            string emailaddress = formVars.Form("emailaddress");
            string mobilenumber = formVars.Form("mobilenumber");


            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_BadHagrid";
            cmd.Parameters.Add("@badHagrid_CTR", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = emailaddress;
            cmd.Parameters.Add("@mobilenumber", SqlDbType.VarChar).Value = mobilenumber;


            con.Open();
            string guid = cmd.ExecuteScalar().ToString();
            con.Close();
            con.Dispose();

            Generic.Functions gFunctions = new Generic.Functions();

            if (emailaddress != "")
            {
                string body = "";
                body += "<html>";
                body += "<head>";
                body += "<title>Badhagrid</title>";
                body += "</head>";
                body += "<body>";
                body += "<p>Thanks for the sign up.</p>";
                body += "<p>Please confirm by clicking <a href=\"http://badhagrid.com?id=" + @guid + "\">here</a>.";
                body += "</body>";
                body += "</html>";

                Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                string[] attachments = new string[0];
                string host = "127.0.0.1";
                string password = "";

                gFunctions.sendemailV4(host, "mail@badhagrid.com", "Badhagrid", password, "Badhagrid", body, emailaddress, "", "tpmoonshine@gmail.com", attachments, emailoptions);
            }

            if (mobilenumber != "")
            {
                string textmessage = "Badhagrid.  Thanks for the sign up. Please confirm by clicking http://badhagrid.com?id=" + @guid;
                gFunctions.SendRemoteMessage(mobilenumber, textmessage, "Badhagrid Confirm");
            }



            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.ctr = guid;
            return (resultclass);

        }
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void update_badhagrid_field(NameValue[] formVars)    //you can't pass any querystring params
        {
            string field = formVars.Form("field");
            string id = formVars.Form("id");
            string value = formVars.Form("value");

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string sql1 = "update badhagrid set [" + field + "] = '" + value + "' where badhagrid_ctr = " + id;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            con.Open();
            //SqlDataReader dr = cmd.ExecuteReader();
            cmd.ExecuteNonQuery();

            cmd.Dispose();
            con.Close();
            con.Dispose();

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
    public string ctr;
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
