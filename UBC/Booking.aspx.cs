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
    public partial class Booking : System.Web.UI.Page
    {
        public string booking_id;
        //public string guid;
        public string who;
        public string description;
        public string allday;
        public string allday_checked;
        public string startdatetime;
        public string enddatetime;
        public string datetime;
        public string contact_details;

        public string[] noyes_values = new string[2] { "No", "Yes" };
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

            if (!IsPostBack)
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                booking_id = Request.QueryString["id"];

                if (booking_id != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_booking", con);
                    cmd1.Parameters.Add("@booking_id", SqlDbType.VarChar).Value = booking_id;
                    //cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            who = dr["who"].ToString();
                            description = dr["description"].ToString();
                            contact_details = dr["contact_details"].ToString();
                            allday = dr["allday"].ToString();
                            startdatetime = dr["startdatetime"].ToString();
                            enddatetime = dr["enddatetime"].ToString();
                            if (allday != "Yes")
                            {
                                datetime = "/time";
                                startdatetime = Convert.ToDateTime(startdatetime).ToString("dd MMM yy HH:mm");
                                enddatetime = Convert.ToDateTime(enddatetime).ToString("dd MMM yy HH:mm");
                                allday_checked = " checked";
                            }
                            else
                            {
                                datetime = "";
                                startdatetime = Convert.ToDateTime(startdatetime).ToString("dd MMM yy");
                                enddatetime = Convert.ToDateTime(enddatetime).ToString("dd MMM yy");
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string booking_id = Request.Form["hf_booking_id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("update_booking", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@booking_id", SqlDbType.VarChar).Value = booking_id;
            cmd1.Parameters.Add("@who", SqlDbType.VarChar).Value = Request.Form["tb_who"].Trim();
            cmd1.Parameters.Add("@description", SqlDbType.VarChar).Value = Request.Form["tb_description"].Trim();
            cmd1.Parameters.Add("@contact_details", SqlDbType.VarChar).Value = Request.Form["tb_contact_details"].Trim();
            cmd1.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = Request.Form["tb_startdatetime"].Trim();
            cmd1.Parameters.Add("@enddatetime", SqlDbType.VarChar).Value = Request.Form["tb_enddatetime"].Trim();
            cmd1.Parameters.Add("@allday", SqlDbType.VarChar).Value = Request.Form["cb_allday"];

            cmd1.Connection = con;
            try
            {
                booking_id = cmd1.ExecuteScalar().ToString();

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

            Response.Redirect("bookinglist.aspx");

        }
    }
}
