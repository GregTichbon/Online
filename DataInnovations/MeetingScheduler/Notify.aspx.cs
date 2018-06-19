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
    public partial class Notify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Meeting_Entity", con);
            cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = tb_meeting.Text;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {
                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td><a href=\"http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + dr["meeting_guid"] + "&entity=" + dr["entity_guid"] + "\">http://office.datainn.co.nz/MeetingScheduler/Scheduler.aspx?meeting=" + dr["meeting_guid"] + "&entity=" + dr["entity_guid"] + "</a></td><td><a href=\"mailto:" + dr["emailaddress"] + "\"</a>" + dr["emailaddress"]  + "</td><td>" + dr["mobile"];
                        Lit_html.Text += "</tr>";

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
        }
    }
}