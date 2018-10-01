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
    public partial class EventList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_All_Events", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    Lit_html.Text = "<tr><th>Event</th><th>Date</th><th>Participants</th><th>Edit</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string event_id = dr["event_id"].ToString();
                        string title = dr["title"].ToString();
                        string daterange = dr["daterange"].ToString();
                        string description = dr["description"].ToString();
                        string participants = dr["Participants"].ToString();

                        string link = "<a href=\"event.aspx?id=" + event_id + "\">Edit</a>";



                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td>" + daterange + "</td><td>" + title + "</td><td>" + participants + "</td><td>" + link + "</td>";
                        Lit_html.Text += "</tr>";
                    }
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