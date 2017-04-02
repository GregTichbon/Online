using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Net.NetworkInformation;

namespace TOHW.Pickups
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
        [WebMethod(EnableSession = true)]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void pickups_update(Int32 id, Int32 version, string address, string status, string assignedto, string date)
        {
            /*
            //get all nics
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            //display the physical address of the first nic in the array,
            //which should correspond to our mac address
            string MACAddress = nics[0].GetPhysicalAddress().ToString();

            System.Web.HttpBrowserCapabilities browser = HttpContext.Current.Request.Browser;

            string debug = "Browser Capabilities\n"
                + "Type = " + browser.Type + "\n"
                + "Name = " + browser.Browser + "\n"
                + "Version = " + browser.Version + "\n"
                + "Major Version = " + browser.MajorVersion + "\n"
                + "Minor Version = " + browser.MinorVersion + "\n"
                + "Platform = " + browser.Platform + "\n"
                + "MAC Address = " + MACAddress + "\n";
   */
            List<pickups_update> pickups_updateList = new List<pickups_update>();

            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Pickups_Update", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@enrolementid", SqlDbType.BigInt).Value = id;
            cmd.Parameters.Add("@version_ctr", SqlDbType.BigInt).Value = version;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
            cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
            cmd.Parameters.Add("@assignedto", SqlDbType.VarChar).Value = assignedto;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = null;
            cmd.Parameters.Add("@debug", SqlDbType.VarChar).Value = Session["pickups_name"].ToString();

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        pickups_updateList.Add(new pickups_update
                        {
                            message = dr["message"].ToString(),
                            version_ctr = dr["version_ctr"].ToString()
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
            Context.Response.Write(JS.Serialize(pickups_updateList));

        }

        [WebMethod(EnableSession = true)]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void pickup_checkforupdates(string data)
        {
            /*
            //get all nics
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            //display the physical address of the first nic in the array,
            //which should correspond to our mac address
            string MACAddress = nics[0].GetPhysicalAddress().ToString();

            System.Web.HttpBrowserCapabilities browser = HttpContext.Current.Request.Browser;

            string debug = "Browser Capabilities\n"
                + "Type = " + browser.Type + "\n"
                + "Name = " + browser.Browser + "\n"
                + "Version = " + browser.Version + "\n"
                + "Major Version = " + browser.MajorVersion + "\n"
                + "Minor Version = " + browser.MinorVersion + "\n"
                + "Platform = " + browser.Platform + "\n"
                + "MAC Address = " + MACAddress + "\n";
            */

            List<PickupUpdates> PickupUpdatesList = new List<PickupUpdates>();


            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("pickup_checkforupdates", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = null ;
            cmd.Parameters.Add("@data", SqlDbType.VarChar).Value = data;
            cmd.Parameters.Add("@debug", SqlDbType.VarChar).Value = Session["pickups_name"].ToString();

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        PickupUpdatesList.Add(new PickupUpdates
                        {
                            enrolementid = dr["enrolementid"].ToString(),
                            address = dr["address"].ToString(),
                            status = dr["status"].ToString(),
                            assignedto = dr["assignedto"].ToString(),
                            version_ctr = dr["version_ctr"].ToString()
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
            Context.Response.Write(JS.Serialize(PickupUpdatesList));

        }
    }
    public class Result
    {
        public string result;
    }
    public class PickupUpdates
    {
        public string enrolementid;
        public string address;
        public string status;
        public string assignedto;
        public string version_ctr;

    }
    public class pickups_update
    {
        public string message;
        public string version_ctr;
    }
}
