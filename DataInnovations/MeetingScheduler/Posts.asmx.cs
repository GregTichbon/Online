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
using Newtonsoft.Json.Linq;

namespace DataInnovations.MeetingScheduler
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
        public string update_meetingoption_entity(NameValue[] formVars)
        {
            //dynamic response = new JObject();
            //vehicle_booking_ctr, vehicle_ctr, start, end, worker_ctr, details
            string connectionString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";


            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("update_meetingoption_entity", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@meetingoption_ctr", SqlDbType.VarChar).Value = formVars.Form("meetingoption_ctr");
                cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = formVars.Form("entity_ctr");
                cmd.Parameters.Add("@rank", SqlDbType.VarChar).Value = formVars.Form("rank");

                con.Open();
                string id = cmd.ExecuteScalar().ToString();
                con.Close();
                return id;
                //Context.Response.Write(response);
                //JavaScriptSerializer JS = new JavaScriptSerializer();
                //string passresult = JS.Serialize(response);

                //Context.Response.Write(passresult);
            }
        }
    }
}
