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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string passed_entity_guid = Request.QueryString["entity"] + "";

            if (passed_entity_guid == "")
            {
                //Response.Redirect("Default.aspx");
                Response.End();
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);

            string meeting_guid;
            string meetingname;
            string duration;
            string times;


            SqlCommand cmd1 = new SqlCommand("Get_Entity_Meetings", con);
            cmd1.Parameters.Add("@entity_guid", SqlDbType.VarChar).Value = passed_entity_guid;

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
                        meeting_guid = dr["guid"].ToString();
                        meetingname = dr["name"].ToString();
                        duration = dr["duration"].ToString();
                        times = dr["StartDateTime"] + " - " + dr["EndDateTime"];
                        //Period = 

                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td><a href=\"scheduler.aspx?entity=" + passed_entity_guid + "&meeting=" + meeting_guid + "\">" + meetingname + "</a></td><td>" + duration + "</td><td>" + times + "</td>";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}