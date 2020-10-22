/*
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
*/

using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
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

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void monitor(string phone, string text)
        {
            /*
            string time = DateTime.Now.ToShortTimeString();
            string html = time + "," + phone + "," + text;
            

            string path = @"c:\temp\smsmonitor.txt";
            TextWriter tw = new StreamWriter(path, true);
            tw.WriteLine(html);
            tw.Close();
            */
         

           
            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_SMSLog", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@direction", SqlDbType.VarChar).Value = "Received";
            cmd.Parameters.Add("@phonenumber", SqlDbType.VarChar).Value = phone;
            cmd.Parameters.Add("@message", SqlDbType.VarChar).Value = text;

            cmd.Connection = con;
            try
            {
                con.Open();
                cmd.ExecuteScalar();

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
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SMSPhoneStatus(string options)
        {
            //dynamic result = new JObject();

            Dictionary<string, string> parameters = new Dictionary<string, string>();
            String strConnString = "Data Source=192.168.10.6;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Parameters", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    parameters.Add(dr["Name"].ToString(), dr["Value"].ToString());
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

            string html = "";

            Boolean success = false;
            int failed = 0;
            WebRequest wr = WebRequest.Create("http://" + parameters["IPAddress"] + parameters["Port"] + "/v1/device/status");
            //WebRequest wr = WebRequest.Create("http://" + parameters["IPAddress"] + ":1234" + "/v1/device/status");
            wr.Timeout = 3500;

            while (!success && failed < 2)
            {
                try
                {
                    WebResponse response = wr.GetResponse();
                    Stream data = response.GetResponseStream();
                    using (StreamReader sr = new StreamReader(data))
                    {
                        html += sr.ReadToEnd();
                        //result.data = sr.ReadToEnd();
                    }
                    success = true;
                    data.Dispose();
                }
                catch (Exception e)
                {
                    failed++;
                    if (options.Contains("|SendEmail|"))
                    {
                        Generic.Functions gFunctions = new Generic.Functions();

                        string host = "70.35.207.87";
                        string password = gFunctions.Decrypt("rPqCkZXW2bhc0HuBUHATwg==");
                        string body = "<html><body>" + e.InnerException + "</body></html>";

                        gFunctions.sendemailV3(host, "greg@datainn.co.nz", "SMS Monitor", password, "No response from SMS Mobile", body, "greg@datainn.co.nz;gtichbon@teorahou.org.nz;greg.tichbon@whanganui.govt.nz", "", "");
                        //gFunctions.sendemailV4(host, "greg@datainn.co.nz", "SMS Monitor", password, "No response from SMS Mobile", "", db_otheremailaddress, emailBCC, replyto, attachments, emailoptions);
                    }
                    html += "Error";
                    //result.data = "Error";
                }
            }
            //Context.Response.Write(result);
            Context.Response.Write(html);
            //return (html);


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