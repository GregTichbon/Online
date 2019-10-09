using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using Generic;
using Ical.Net;
using Ical.Net.CalendarComponents;
using Ical.Net.DataTypes;
using Ical.Net.Serialization;

namespace UBC
{
    public partial class UpdateICS : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_calendar";
            //cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;


            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    var calendar = new Ical.Net.Calendar( );
                    //calendar.Name = "Union Boat Club";
                   // calendar.Method = publish
                    calendar.AddProperty("X-WR-CALNAME", "Union Boat Club");
                    calendar.AddProperty("X-WR-RELCALID", "27C64120-D15B-44CD-96DE-7C76B001EFBF");
                    calendar.AddProperty("X-PUBLISHED-TTL", "P1D");


                    while (dr.Read())
                    {
                        DateTime startdate = (DateTime)dr["StartDate"];
                        string enddate = dr["EndDate"].ToString();
                        string guid = dr["guid"].ToString();
                        string summary = dr["Event"].ToString();

                        var e1 = new CalendarEvent
                        {
                            Start = new CalDateTime(startdate),
                            End = new CalDateTime(enddate),
                            Uid = guid,
                            IsAllDay = true,
                            Summary = summary 
                            
                            //End = new CalDateTime(later),
                        };

                        calendar.Events.Add(e1);
                    }
                    var serializer = new CalendarSerializer();
                    var serializedCalendar = serializer.SerializeToString(calendar);
                    html = serializedCalendar;
                }
               
                dr.Close();
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

           
            


            


        }
    }
}