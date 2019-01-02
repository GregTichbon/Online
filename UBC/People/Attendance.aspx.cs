using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class Attendance : System.Web.UI.Page
    {
        public string eventguid;
        public string personguid;
        public string eventid;
        public string personid;
        public string attendance;
        public string role;
        public string events;
        public string travel;
        public string traveldetail;
        public string returntraveldetail;
        public string others;
        public string accomodation;
        public string onsite;
        public string otherinformation;
        public string meals;
        public string display_events;
        public string display_traveldetail;
        public string display_questions;
        public string label_traveldetail;
        public string header;


        public string[] attendance_values = new string[7] { "No", "Yes", "Partial", "Maybe", "Expected", "Going", "Not Going" };
        public string[] travel_values = new string[3] { "In my/our vehicle", "I've got a ride", "I need a ride" };
        public string[] role_values = new string[7] { "Rower", "Coach", "Coach/Rower", "Cox", "Gym/Excercise", "Coach Support", "Support" };

        protected void Page_Load(object sender, EventArgs e)
        {
            eventguid = Request.QueryString["e"] + "";
            personguid = Request.QueryString["p"] + "";
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_person_event_attendance", con);
            cmd1.Parameters.Add("@event_guid", SqlDbType.VarChar).Value = eventguid;
            cmd1.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = personguid;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                SqlDataReader dr = cmd1.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();


                    personid = dr["person_id"].ToString();
                    eventid = dr["event_id"].ToString();

                    attendance = dr["attendance"].ToString();
                    if (attendance != "Not Going" && attendance != "No")
                    {
                        display_questions = "";
                    }
                    else
                    {
                        display_questions = "none";
                    }

                    role = dr["role"].ToString();

                    if (role.Contains("Rower"))
                    {
                        display_events = ""; 
                    }
                    else
                    {
                        display_events = "none";
                    }

                    events = dr["events"].ToString();

                    travel = dr["travel"].ToString();
                    if (travel != "I need a ride")
                    {
                        display_traveldetail = "";
                        if (travel == "In my/our vehicle")
                        {
                            label_traveldetail = "Who else is going in your vehicle?<br />Do you have room in your car for others?  If so how many?";
                        }
                        else
                        {
                            label_traveldetail = "Who's vehicle are you travelling in?";
                        }
                    }
                    else
                    {
                        display_traveldetail = "none";
                    }

                    traveldetail = dr["traveldetail"].ToString();
                    returntraveldetail = dr["returntraveldetail"].ToString();
                    others = dr["others"].ToString();
                    accomodation = dr["accomodation"].ToString();
                    onsite = dr["onsite"].ToString();
                    otherinformation = dr["otherinformation"].ToString();
                    meals = dr["meals"].ToString();

                    header = "<b>" + dr["name"].ToString() + "<br />" + dr["title"].ToString() + "</b><br />" + dr["description"].ToString();
                } else
                {
                    attendance = "";
                    role = "";
                    events = "";
                    travel = "";
                    traveldetail = "";
                    returntraveldetail = "";
                    others = "";
                    accomodation = "";
                    onsite = "";
                    otherinformation = "";
                    meals = "";

                    display_events = "none";
                    display_traveldetail = "none";
                    display_questions = "none";
                    label_traveldetail = "";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            attendance = Request.Form["dd_attendance"].Trim();
            role = Request.Form["dd_role"].Trim();
            accomodation = Request.Form["tb_accomodation"].Trim();
            meals = Request.Form["tb_meals"].Trim();
            travel = Request.Form["dd_travel"].Trim();
            traveldetail = Request.Form["tb_traveldetail"].Trim();
            returntraveldetail = Request.Form["tb_returntraveldetail"].Trim();
            others = Request.Form["tb_others"].Trim();
            onsite = Request.Form["tb_onsite"].Trim();
            events = Request.Form["tb_events"].Trim();
            otherinformation = Request.Form["tb_otherinformation"].Trim();


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd = new SqlCommand("update_person_event_attendance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = personid;
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;
            cmd.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
            cmd.Parameters.Add("@role", SqlDbType.VarChar).Value = role;
        
            cmd.Parameters.Add("@accomodation", SqlDbType.VarChar).Value = accomodation;
            cmd.Parameters.Add("@meals", SqlDbType.VarChar).Value = meals;
            cmd.Parameters.Add("@travel", SqlDbType.VarChar).Value = travel;

            cmd.Parameters.Add("@traveldetail", SqlDbType.VarChar).Value = traveldetail;
            cmd.Parameters.Add("@returntraveldetail", SqlDbType.VarChar).Value = returntraveldetail;
            cmd.Parameters.Add("@others", SqlDbType.VarChar).Value = others;
            cmd.Parameters.Add("@onsite", SqlDbType.VarChar).Value = onsite;
            cmd.Parameters.Add("@events", SqlDbType.VarChar).Value = events;

            cmd.Parameters.Add("@otherinformation", SqlDbType.VarChar).Value = otherinformation;

            try
            {
                string result = cmd.ExecuteScalar().ToString();
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
            //Response.Redirect("~/default.aspx");
        }
    }
}
