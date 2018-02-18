using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DataInnovations.Raffles
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
        public string getticket(NameValue[] formVars)    //you can't pass any querystring params
        {
            string update = formVars.Form("hf_update");
            string raffle = formVars.Form("hf_raffle");
            string ticket = formVars.Form("hf_ticket");

            string filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";

            SQLiteConnection m_dbConnection;
            m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
            m_dbConnection.Open();

            string sql = "select * from ticket where raffle_id = '" + raffle + "' and number = " + ticket;
            SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
            SQLiteDataReader reader = command.ExecuteReader();
            string person;
            string status = "";
            while (reader.Read())
            {
                person = reader["Person"].ToString();
                if (person != "")
                {
                    status = "Taken";
                }
                else
                {
                    if (update == "yes")
                    {
                        //Do update


                        string name = formVars.Form("tb_name");
                        string emailaddress = formVars.Form("tb_emailaddress");
                        string mobile = formVars.Form("tb_mobile");
                        string payment = formVars.Form("tb_payment");

                        sql = "update ticket set person = '" + name + "', emailaddress = '" + emailaddress + "', mobile = '" + mobile + "', payment = '" + payment + "' where raffle_id = " + raffle + " and number = " + ticket;
                        SQLiteCommand commandu = new SQLiteCommand(sql, m_dbConnection);
                        commandu.ExecuteNonQuery();
                        status = "Updated";
                        //status = sql;
                    }
                    else
                    {
                        status = "Available";
                    }
                }
            }
            m_dbConnection.Close();

            standardResponse resultclass = new standardResponse();
            resultclass.status = status;
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
