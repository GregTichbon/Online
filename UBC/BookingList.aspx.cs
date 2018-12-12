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
    public partial class BookingList : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "100001"))
            {
                Response.Redirect("~/default.aspx");
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_All_Bookings", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<tr><th>Booking</th><th>Who</th><th>Edit</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string booking_id = dr["booking_id"].ToString();
                        string who = dr["who"].ToString();
                        string daterange = dr["daterange"].ToString();
                        string description = dr["description"].ToString().Replace("\r\n", "<br />"); ;

                        string link = "<a href=\"booking.aspx?id=" + booking_id + "\">Edit</a>";
                        string thedate = daterange.Substring(4, 9).Insert(7, "20");

                        html += "<tr class=\"title\" title=\"" + description + "\" data-date=\"" + thedate + "\">";
                        html += "<td>" + daterange + "</td><td>" + who + "</td><td>" + link + "</td>";
                        html += "</tr>";
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