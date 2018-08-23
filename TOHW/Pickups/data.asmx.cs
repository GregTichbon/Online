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
using System.IO;
using System.Drawing;

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
        public void pickups_update(Int32 id, Int32 version, string address, string status, string assignedto, string note, string date)
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
            cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = note;
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
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = null;
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

        [WebMethod(EnableSession = true)]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void getinformation(string id)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("pickups_get_information", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;

            //byte[] picData = { };
            string html = "";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        if (html == "")
                        {
                            html += "<table>";

                            //byte[] picData = dr["image"] as byte[] ?? null;


                            if (dr["image"] != null)
                            {
                                html += "<img src=\"GetImage.ashx?id=" + dr["id"] + "\"/>";
                            }

                            string medical = dr["medical"].ToString();
                            string dateofbirth = dr["dateofbirth"].ToString();
                            string firstevent = dr["firstevent"].ToString();
                            string lastevent = dr["lastevent"].ToString();
                            string facebook = dr["facebook"].ToString();

                            if (medical != "")
                            {
                                html += "<tr><td>Medical</td><td>" + medical + "</td></tr>";
                            }
                            if (dateofbirth != "")
                            {
                                html += "<tr><td>DOB</td><td>" + Convert.ToDateTime(dateofbirth).ToString("d MMM yy") + "</td></tr>";
                            }
                            if (firstevent != "")
                            {
                                html += "<tr><td>First Event</td><td>" + Convert.ToDateTime(firstevent).ToString("d MMM yy") + "</td></tr>";
                            }
                            if (lastevent != "")
                            {
                                html += "<tr><td>Last Event</td><td>" + Convert.ToDateTime(lastevent).ToString("d MMM yy") + "</td></tr>";
                            }
                            if (facebook != "")
                            {
                                html += "<tr><td>Facebook</td><td><a href=\"" + facebook + "\" target=\"facebook\">Link</a></td></tr>";
                            }
                            html += "</table>";
                            html += "<br /><br />";
                            html += "<table>";


                        }
                        string ctype = dr["type"].ToString();
                        string cdetail = dr["detail"].ToString();
                        string cdescription = dr["description"].ToString();

                        if (cdetail != "")
                        {
                            html += "<tr><td>" + ctype + "</td><td>" + cdetail + "</td><td>" + cdescription + "</td></tr>";
                        }
                    }
                    html += "</table>";

            




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
            Context.Response.Write(html);

            //Context.Response.Write("<img src=\"data: image / png; base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg == \" alt=\"Red dot\">");

            //Context.Response.Write("<img src=\"data: image / jpg; base64," + picData + "\" == \" alt=\"Red dot\">");


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
