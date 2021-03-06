﻿using Generic;
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
    public partial class Attendance24_28Jan2019 : System.Web.UI.Page
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
        public string returntravel;
        public string returntraveldetail;
        public string seats;
        public string returnseats;
        public string others;
        public string accomodation;
        public string onsite;
        public string otherinformation;
        public string meals;
        public string display_events;
        public string display_traveldetail;
        public string display_returntraveldetail;
        public string display_seats;
        public string display_returnseats;
        public string display_questions;
        public string label_traveldetail;
        public string label_returntraveldetail;
        public string header;
        public string display_response;



        public string[] attendance_values = new string[7] { "No", "Yes", "Partial", "Maybe", "Expected", "Going", "Not Going" };
        public string[] travel_values = new string[3] { "In my/our vehicle", "I've got a ride", "I need a ride" };
        public string[] role_values = new string[7] { "Rower", "Coach", "Coach/Rower", "Cox", "Gym/Excercise", "Coach Support", "Support" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                display_response = "";
            }
            else
            {
                display_response = "none";
            }

            string personresponded = "";
            attendance = "";
            role = "";
            events = "";
            travel = "";
            returntravel= "";
            traveldetail = "";
            returntraveldetail = "";
            seats = "";
            returnseats = "";
            others = "";
            accomodation = "";
            onsite = "";
            otherinformation = "";
            meals = "";

            display_events = "none";
            display_traveldetail = "none";
            display_returntraveldetail = "none";
            display_seats = "none";
            display_returnseats = "none";
            display_questions = "none";
            label_traveldetail = "";

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
                    personresponded = dr["personresponded"].ToString() + "";
                    personid = dr["person_id"].ToString();
                    eventid = dr["event_id"].ToString();

                    if (personresponded != "")
                    {
                        /*
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
                        */

                        travel = dr["travel"].ToString();
                        traveldetail = dr["traveldetail"].ToString();
                        seats = dr["seats"].ToString();
                        returntravel = dr["returntravel"].ToString();
                        returntraveldetail = dr["returntraveldetail"].ToString();
                        returnseats = dr["returnseats"].ToString();

                        others = dr["others"].ToString();
                        //accomodation = dr["accomodation"].ToString();
                        //onsite = dr["onsite"].ToString();
                        otherinformation = dr["otherinformation"].ToString();
                        //meals = dr["meals"].ToString();

                        switch (travel)
                        {
                            case "I need a ride":
                                display_traveldetail = "none";
                                display_seats = "none";
                                break;
                            case "In my/our vehicle":
                                label_traveldetail = "When are you travelling and who else is going in your vehicle?";
                                display_traveldetail = "";
                                display_seats = "";
                                break;
                            case "I've got a ride":
                                label_traveldetail = "When and how are you travelling?";
                                display_traveldetail = "";
                                display_seats = "none";
                                break;
                        }

                        switch (returntravel)
                        {
                            case "I need a ride":
                                display_returntraveldetail = "none";
                                display_returnseats = "none";
                                break;
                            case "In my/our vehicle":
                                label_returntraveldetail = "When are you travelling and who else is going in your vehicle?";
                                display_returntraveldetail = "";
                                display_returnseats = "";
                                break;
                            case "I've got a ride":
                                label_returntraveldetail = "When and how are you travelling?";
                                display_returntraveldetail = "";
                                display_returnseats = "none";
                                break;
                        }
                    }
                    header = "<h2>" + dr["name"].ToString() + "</h2><h3>" + dr["title"].ToString() + "</h3>" + dr["description"].ToString();
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

            //attendance = Request.Form["dd_attendance"].Trim();
            //role = Request.Form["dd_role"].Trim();
            //accomodation = Request.Form["tb_accomodation"].Trim();
            //meals = Request.Form["tb_meals"].Trim();
            travel = Request.Form["dd_travel"].Trim();
            traveldetail = Request.Form["tb_traveldetail"].Trim();
            seats = Request.Form["tb_seats"].Trim();
            returntravel = Request.Form["dd_returntravel"].Trim();
            returntraveldetail = Request.Form["tb_returntraveldetail"].Trim();
            returnseats = Request.Form["tb_returnseats"].Trim();

            others = Request.Form["tb_others"].Trim();
            //onsite = Request.Form["tb_onsite"].Trim();
            //events = Request.Form["tb_events"].Trim();
            otherinformation = Request.Form["tb_otherinformation"].Trim();


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd = new SqlCommand("update_person_event_attendance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = personid;
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;
            //cmd.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
            //cmd.Parameters.Add("@role", SqlDbType.VarChar).Value = role;

            //cmd.Parameters.Add("@accomodation", SqlDbType.VarChar).Value = accomodation;
            //cmd.Parameters.Add("@meals", SqlDbType.VarChar).Value = meals;
            cmd.Parameters.Add("@travel", SqlDbType.VarChar).Value = travel;
            cmd.Parameters.Add("@traveldetail", SqlDbType.VarChar).Value = traveldetail;
            cmd.Parameters.Add("@seats", SqlDbType.VarChar).Value = seats;

            cmd.Parameters.Add("@returntravel", SqlDbType.VarChar).Value = returntravel;
            cmd.Parameters.Add("@returntraveldetail", SqlDbType.VarChar).Value = returntraveldetail;
            cmd.Parameters.Add("@returnseats", SqlDbType.VarChar).Value = returnseats;

            cmd.Parameters.Add("@others", SqlDbType.VarChar).Value = others;
            //cmd.Parameters.Add("@onsite", SqlDbType.VarChar).Value = onsite;
            //cmd.Parameters.Add("@events", SqlDbType.VarChar).Value = events;

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
