using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace TOHW.ComingandGoing
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
        public checkinout checkinout(string content)
        {
         
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            string command = "checkinout";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = content;


            cmd.CommandText = command;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            checkinout checkinoutclass = new checkinout();
            checkinoutclass.person_id = dr["person_id"].ToString();
            checkinoutclass.name = dr["name"].ToString();
            checkinoutclass.datetime = dr["datetime"].ToString();
            checkinoutclass.inorout = dr["inorout"].ToString();
            checkinoutclass.action = dr["action"].ToString();

            dr.Close();

            cmd.Dispose();
            con.Close();
            con.Dispose();

            return (checkinoutclass);

        }
    }
}
public class checkinout
{
    public string person_id;
    public string name;
    public string datetime;
    public string inorout;
    public string action;
}