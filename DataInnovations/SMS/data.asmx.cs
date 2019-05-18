using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DataInnovations.SMS
{
    /// <summary>
    /// Summary description for data
    /// </summary>
    /// [WebService(Namespace = "http://tempuri.org/")]
    /// [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class data1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void updatenumber(string field, string id, string value)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            value = value.Replace("'", "''");
            string sql1 = "update [number] set [" + field + "] = '" + value + "' where number_ctr = " + id;

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

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void AddtoGroup(string Group_CTR, string Number_CTR)
        {
            string response;
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("AddtoGroup", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Group_CTR", SqlDbType.VarChar).Value = Group_CTR;
            cmd.Parameters.Add("@Number_CTR", SqlDbType.VarChar).Value = Number_CTR;

            cmd.Connection = con;
            try
            {
                con.Open();
                response = cmd.ExecuteScalar().ToString();

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

            
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Completed";
            resultclass.message = "";
            resultclass.id = response;   //0 means it already exists
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            Context.Response.Write(passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void RemovefromGroup(string Group_number_CTR)
        {
        
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("RemovefromGroup", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Group_number_CTR", SqlDbType.VarChar).Value = Group_number_CTR;

            cmd.Connection = con;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();

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

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Removed";
            resultclass.message = "";
    
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            Context.Response.Write(passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void name_autocomplete(string term)
        {
            List<NameClass> NameList = new List<NameClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("name_autocomplete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        NameList.Add(new NameClass
                        {
                            value = dr["number_ctr"].ToString(),
                            label = dr["label"].ToString(),
                            number = dr["number"].ToString(),
                            name = dr["name"].ToString(),
                            status = dr["status"].ToString(),
                            greeting = dr["greeting"].ToString()

                        });
                    }

                    dr.Close();
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

            NameList.Add(new NameClass
            {
                value = "new",
                label = "Create a new person",
                number = "",
                name = "",
                status = "",
                greeting = ""

            });

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(NameList));
        }

    }
    public class NameClass
    {
        public string value;
        public string label;
        public string number;
        public string name;
        public string status;
        public string greeting;

    }
}