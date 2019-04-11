using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Appointments
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
        public void get_appointments(string start, string end, string id, string mode)
        {

            List<Appointment> resultlist = new List<Appointment>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            //string strConnString = "Data Source=192.168.1.149;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("appointments_get_appointments", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = start;
            cmd.Parameters.Add("@enddatetime", SqlDbType.VarChar).Value = end;
            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        resultlist.Add(new Appointment
                        {
                            // id = dr["appointment_ctr"].ToString(),
                            title = dr["title"].ToString(),
                            start = dr["startdatetime"].ToString(),
                            end = dr["enddatetime"].ToString(),
                            status = dr["status"].ToString(),
                            reference = dr["reference"].ToString(), //GUID
                            color = dr["color"].ToString()
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
        public class Appointment
        {
            //public string id;
            public string title;
            public string start;
            public string end;
            public string status;
            public string reference;
            public string color;
            //public string responderguid;
        }
    }
}
