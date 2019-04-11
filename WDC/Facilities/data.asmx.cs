
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Online.Facilities
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
        public void get_events(string start, string end)
        {

            List<Event> resultlist = new List<Event>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=192.168.1.149;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("facilities_get_events", con);
            cmd.CommandType = CommandType.StoredProcedure;

            //cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = "xxxx";
            //cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        resultlist.Add(new Event
                        {
                            id = dr["facilities_event_ctr"].ToString(),
                            resourceId = dr["resourceid"].ToString(),
                            eventstart = dr["eventstart"].ToString(),
                            eventend = dr["eventend"].ToString(),
                            title = dr["title"].ToString(),
                            description = dr["description"].ToString(),
                            facilitystart = dr["facilitystart"].ToString(),
                            facilityend = dr["facilityend"].ToString(),
                            eventnotes = dr["Eventnotes"].ToString(),
                            facilitynotes = dr["Facilitynotes"].ToString(),
                            eventstatus = dr["Eventstatus"].ToString(),
                            facilitystatus = dr["Facilitystatus"].ToString()
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
        public class Event
        {
            public string id;
            public string resourceId;
            public string eventstart;
            public string eventend;
            public string title;
            public string description;
            public string facilitystart;
            public string facilityend;
            public string eventnotes;
            public string facilitynotes;
            public string eventstatus;
            public string facilitystatus;
        }
    }
}
