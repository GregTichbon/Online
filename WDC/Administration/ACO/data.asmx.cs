using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Administration.ACO
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS
    /// 
    public class data : System.Web.Services.WebService
    {

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void streetsearch(string term)
        {

            List<SimpleResponse> resultlist = new List<SimpleResponse>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=192.168.0.204;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("ACO_Search", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Streets";
            cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        resultlist.Add(new SimpleResponse
                        {
                            id = dr["street_no"].ToString(),
                            label = dr["street_name"].ToString()
                        });
                    }
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(resultlist));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void animalnamesearch(string term)
        {

            List<LabelResponse> resultlist = new List<LabelResponse>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=192.168.0.207;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("ACO_Search", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "AnimalNames";
            cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        resultlist.Add(new LabelResponse
                        {
                            label = dr["name"].ToString()
                        });
                    }
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(resultlist));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void updateOfficer(string RAM_PROCESS_CTR, string RESP_USER_ID, string Override = "0")
        {

            string result = "";

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            //string strConnString = "Data Source=192.168.0.207;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("ACO_Update_Offier", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@RAM_PROCESS_CTR", SqlDbType.VarChar).Value = RAM_PROCESS_CTR;
            cmd.Parameters.Add("@RESP_USER_ID", SqlDbType.VarChar).Value = RESP_USER_ID;
            cmd.Parameters.Add("@Override", SqlDbType.VarChar).Value = Override;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //resultlist.Add(new LabelResponse
                        //{
                        result = dr["name"].ToString();
                        //});
                    }
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

            Context.Response.Write(result);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void ownersearch(string term)
        {

            List<SimpleResponse> resultlist = new List<SimpleResponse>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            //string strConnString = "Data Source=192.168.0.204;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";  //Test
            string strConnString = "Data Source=192.168.0.207;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";  //Live
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("ACO_Search", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Owners";
            cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                        //"<a href=""search.asp?owner=" & rs("owner_ctr") & "&animals=" & rs("CountOfanimal_ctr") & """>" & italicson & trim(rs("title") & " " & rs("given") & " " & rs("surname")) & " (" & rs("CountOfanimal_ctr") & ")" & italicsoff & "</a><br>"

                        RegexOptions options = RegexOptions.None;
                        Regex regex = new Regex("[ ]{2,}", options);
                        string name = regex.Replace(dr["title"] + " " + dr["given"] + " " + dr["surname"], " ").Trim();

                        resultlist.Add(new SimpleResponse
                        {
                            id = dr["owner_ctr"].ToString(),
                            label = name
                    });
                    }
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(resultlist));
        }

        public class LabelResponse
        {
            public string label;
        }
        public class SimpleResponse
        {
            public string id;
            public string label;
        }
    }
}
