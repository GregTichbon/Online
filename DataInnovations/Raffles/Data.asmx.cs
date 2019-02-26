using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data.SQLite;
//using System.Text;

//using System.Web.Script.Services;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

namespace Online.data
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS

    public class Data : System.Web.Services.WebService
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
        public void getticket(string raffle, string ticket, string update)
        {
            List<LabelResponse> LabelResponseList = new List<LabelResponse>();

            string filename = HttpContext.Current.Server.MapPath(".") + "\\raffles.sqlite";


            SQLiteConnection m_dbConnection;
            m_dbConnection = new SQLiteConnection("Data Source=" + filename + ";Version=3;");
            m_dbConnection.Open();

            string sql = "select * from ticket where raffle_id = '" + raffle + "' and number = " + ticket;
            SQLiteCommand command = new SQLiteCommand(sql, m_dbConnection);
            SQLiteDataReader reader = command.ExecuteReader();
            string person;
            while (reader.Read())
            {
                person = reader["Person"].ToString();
                if (person != "")
                {
                    //Already taken
                    LabelResponseList.Add(new LabelResponse
                    {
                        label = "Taken"
                    });
                }
                else
                {
                    if (update == "yes")
                    {
                        //Do update
                        LabelResponseList.Add(new LabelResponse
                        {
                            label = "Updated"
                        });
                    }
                    else
                    {
                        LabelResponseList.Add(new LabelResponse
                        {
                            label = "Available"
                        });
                    }
                }

            }
            m_dbConnection.Close();
            /*
               LabelResponseList.Add(new LabelResponse
               {
                   label = "Taken"
               });
               */
            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(LabelResponseList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void updateticket(string field, string id, string value)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            

            string sql1 = "update raffleticket set [" + field + "] = '" + value + "' where raffleticket_id = " + id;
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



    public class LabelResponse
    {
        public string label;
    }



    #endregion
}
