using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace DataInnovations.YourPassing
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
        public standardResponseID update_deceased(NameValue[] formVars)    //you can't pass any querystring params
        {
            string firstname = formVars.Form("firstname");
            string lastname = formVars.Form("lastname");
            string agent_ctr = formVars.Form("agent_ctr");

            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_Deceased";
            cmd.Parameters.Add("@deceased_ctr", SqlDbType.VarChar).Value = "new";
            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = lastname;
            cmd.Parameters.Add("@agent_ctr", SqlDbType.VarChar).Value = agent_ctr;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string id = dr[0].ToString();
            con.Close();

            con.Dispose();

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = id;

            return (resultclass);

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
    public class standardResponseID
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
}

