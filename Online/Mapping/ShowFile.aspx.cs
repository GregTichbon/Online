using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace Online.Mapping
{
    public partial class ShowFile : System.Web.UI.Page
    {
        public string mapinfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            List<mapinformation> mapinformationList = new List<mapinformation>();
            string mylocation;
            string mycoords;
            int mycolour = 0;
            char[] fieldDelim = { '\x00FD' };
            char[] recordDelim = { '\x00FE' };
            string[] locationSplit;
            string[] locationrecordSplit;

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_MapInformation", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@modulename", SqlDbType.VarChar).Value = "All";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        locationSplit = dr["location"].ToString().Split(recordDelim);
                        mycolour = mycolour + 1;
                        foreach (string locationrecord in locationSplit)
                        {
                            locationrecordSplit = locationrecord.Split(fieldDelim);
                            mylocation = locationrecordSplit[0].ToString();
                            mycoords = locationrecordSplit[1].ToString();
                            mapinformationList.Add(new mapinformation
                            {
                                title = dr["title"].ToString(),
                                location = mylocation,
                                coords = mycoords,
                                colour = mycolour,
                                pr_ctr = dr["pr_ctr"].ToString(),
                                description = dr["description"].ToString()
                            });
                        }
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
            mapinfo = JS.Serialize(mapinformationList);
        }
    }
    public class mapinformation
    {
        public string title;
        public string location;
        public string coords;
        public int colour;
        public string pr_ctr;
        public string description;
    }
}