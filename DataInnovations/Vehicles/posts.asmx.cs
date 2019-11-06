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
using System.Configuration;

namespace DataInnovations.Vehicles
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
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public standardResponse updatevehicle(NameValue[] formVars)    //you can't pass any querystring params
        {

            string field = formVars.Form("field");
            string id = formVars.Form("id");
            string value = formVars.Form("value");

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_Vehicle";
            cmd.Parameters.Add("@vehicle_ctr", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@field", SqlDbType.VarChar).Value = field;
            cmd.Parameters.Add("@value", SqlDbType.VarChar).Value = value;

            con.Open();
            string user_ctr = cmd.ExecuteScalar().ToString();
            con.Close();
            con.Dispose();

            

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            
            return (resultclass);

        }
    }
}
