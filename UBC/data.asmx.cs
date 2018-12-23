using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace UBC
{
    /// <summary>
    /// Summary description for data
    /// </summary>
    // [WebService(Namespace = "http://tempuri.org/")]
    // [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class data : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void person_name_autocomplete(string term)
        {
            List<PersonClass> PersonList = new List<PersonClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("person_name_autocomplete", con);
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
                        PersonList.Add(new PersonClass
                        {
                            person_id = dr["person_id"].ToString(),
                            guid = dr["guid"].ToString(),
                            name = dr["name"].ToString(),
                            label = dr["name"].ToString()
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(PersonList));
        }
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_hallbookings(string start, string end)
        {

            List<Hall_Booking> resultlist = new List<Hall_Booking>();

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_hallbookings", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = start;
            cmd.Parameters.Add("@enddatetime", SqlDbType.VarChar).Value = end;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        resultlist.Add(new Hall_Booking
                        {
                            /* Booking_ID
                             * Who	
                             * Contact_Details	
                             * Description	
                             * StartDateTime	
                             * EndDateTime	
                             * allday	

                    */
                            Booking_ID = dr["Booking_ID"].ToString(),
                            title = dr["Who"].ToString(),
                            Contact_Details = dr["Contact_Details"].ToString(),
                            start = dr["StartDateTime"].ToString(),
                            end = dr["enddatetime"].ToString(),
                            allday = dr["allday"].ToString()
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

    }
    public class PersonClass
    {
        public string person_id;
        public string guid;
        public string name;
        public string label;

    }
    public class Hall_Booking
    {
        public string Booking_ID;
        public string title;
        public string Contact_Details;
        public string Description;
        public string start;
        public string end;
        public string allday;
    }
}
