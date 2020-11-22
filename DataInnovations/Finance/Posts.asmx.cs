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

namespace DataInnovations.Finance
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
        public string update_Finance_Transaction_Items(NameValue[] formVars)    //you can't pass any querystring params
        {
           
            string Transactions_Items_ID = formVars.Form("Transactions_Items_ID");
            string Transactions_ID = formVars.Form("Transactions_ID");
            string description = formVars.Form("description");
            string otherparty = formVars.Form("otherparty");
            string type = formVars.Form("type");
            string invoice = formVars.Form("invoice"); 
            string amount = formVars.Form("amount");
            string gst = formVars.Form("gst");


            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "update_Finance_Transaction_Items";
            cmd.Parameters.Add("@Transactions_Items_ID", SqlDbType.VarChar).Value = Transactions_Items_ID.Substring(3);
            cmd.Parameters.Add("@Transactions_ID", SqlDbType.VarChar).Value = Transactions_ID;
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = description;
            cmd.Parameters.Add("@otherparty", SqlDbType.VarChar).Value = otherparty;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.Add("@invoice", SqlDbType.VarChar).Value = invoice;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = amount;
            cmd.Parameters.Add("@gst", SqlDbType.VarChar).Value = gst;

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = result;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            
           
            return (passresult);
        }

        [WebMethod]
        public string delete_Finance_Transaction_Items(NameValue[] formVars)    //you can't pass any querystring params
        {
            string Transactions_Items_ID = formVars.Form("Transactions_Items_ID");



            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "delete_Finance_Transaction_Items";
            cmd.Parameters.Add("@Transactions_Items_ID", SqlDbType.VarChar).Value = Transactions_Items_ID.Substring(3);


            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Deleted";
            resultclass.message = "";
            resultclass.id = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }
    }
}
