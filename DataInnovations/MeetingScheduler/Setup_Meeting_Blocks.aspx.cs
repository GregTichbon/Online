using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class Setup_Meeting_Blocks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int timeslots = 0;
            int duration = 0;

            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Meeting_Blocks", con);
            cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = tb_meeting.Text;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    timeslots = Convert.ToInt16(dr["timeslots"]); 
                    duration = Convert.ToInt16(dr["duration"]);
                    /*
                    do
                    {
                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td><a href=\"http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + dr["meeting_guid"] + "&entity=" + dr["entity_guid"] + "\">http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + dr["meeting_guid"] + "&entity=" + dr["entity_guid"] + "</a></td><td><a href=\"mailto:" + dr["emailaddress"] + "\"</a>" + dr["emailaddress"] + "</td><td>" + dr["mobile"];
                        Lit_html.Text += "</tr>";

                    }
                    while (dr.Read());
                    */

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

            Lit_html.Text += timeslots.ToString() + " " + duration.ToString() + "<br />";
            DateTime startdate = Convert.ToDateTime(tb_startdate.Text);
            DateTime enddate = Convert.ToDateTime(tb_enddate.Text);
            Double days = (enddate - startdate).TotalDays + 1;
            DateTime startofday = Convert.ToDateTime(tb_startofday.Text);
            DateTime endofday = Convert.ToDateTime(tb_endofday.Text);
            Double slots = (endofday - startofday).TotalMinutes;


            for (int f1 = 0; f1 < days; f1++)
            {
                for (int f2 = 0; f2 < slots; f2+=30)
                {
                    Lit_html.Text += startdate.AddDays(f1).ToString("ddd dd MMM yyyy") + " " + startofday.AddMinutes(f2).ToString("hh:mm") + " - " + startofday.AddMinutes(f2 + 30).ToString("hh:mm") + "<br />";
                }
                    
            }

        }
    }
}