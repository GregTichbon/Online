using System;
using System.Collections.Generic;
//using System.Linq;
//using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
//using System.IO;
//using System.Text;

//using System.Web.Script.Services;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

using System.Net.Http;
using System.Xml;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Net;

namespace Online.PropertyRolls
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS
    public class data : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void TestMethodGet(string mode, string param1)
        {

            if (mode == "List")
            {
                List<TestList> resultlist = new List<TestList>();

                resultlist.Add(new TestList
                {
                    id = "1",
                    value = param1
                });
                resultlist.Add(new TestList
                {
                    id = "2",
                    value = "Black"
                });
                resultlist.Add(new TestList
                {
                    id = "3",
                    value = "Blue"
                });
                resultlist.Add(new TestList
                {
                    id = "4",
                    value = "Red"
                });
                resultlist.Add(new TestList
                {
                    id = "5",
                    value = "White"
                });

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultlist);

                Context.Response.Write(passresult);
            }
            else
            {
                TestClass resultclass = new TestClass();
                resultclass.id = param1;

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                Context.Response.Write(passresult);
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Search(string occupiersurname, string occupierfirstnames, string years, string reference, string status)
        {
            List<SearchClass> SearchList = new List<SearchClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=192.168.0.204;Initial Catalog=PropertyRolls;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Search_Property_Roll", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@occupiersurname", SqlDbType.VarChar).Value = occupiersurname;
            cmd.Parameters.Add("@occupierfirstnames", SqlDbType.VarChar).Value = occupierfirstnames;
            cmd.Parameters.Add("@years", SqlDbType.VarChar).Value = years;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference;
            cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string occupiername = dr["occupiersurname"].ToString() + " " + dr["occupierfirstname"].ToString();
                        if(occupiername == " ")
                        {
                            occupiername = "<i>Not entered</i>";
                        }

                        SearchList.Add(new SearchClass
                        {
                            propertyroll_id = dr["propertyroll_id"].ToString(),
                            occupiername = occupiername,
                            propertyaddress = dr["propertyaddress"].ToString(),
                            year = dr["year"].ToString()
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
            Context.Response.Write(JS.Serialize(SearchList));
        }

    }




    #region classes
    public class TestClass
    {
        public string id;
    }

    public class TestList
    {
        public string id;
        public string value;
    }
    public class SearchClass
    {
        public string propertyroll_id;
        public string occupiername;
        public string propertyaddress;
        public string year;
    }

    #endregion
}
