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
    public partial class Attending : System.Web.UI.Page
    {
        public string html = "";
        public string events = "";
        public int currentevent = 0;
        public string html_button;

        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["id"];
            //string guid = "09DB9E21-D49E-441F-9076-2626B37E099C";
            if (Session["UBC_person_id"] == null && guid == null)
            {
                if (Request.Cookies["UBC-GUID"] != null)
                {
                    guid = Request.Cookies["UBC-GUID"].Value;
                }
            }

            if (guid != null)
            {
                Session.Remove("UBC_person_id");
                Session.Remove("UBC_name");
                Session.Remove("UBC_AccessString");
                Session.Remove("UBC_Colour");

                //Response.Cookies["UBC-GUID"].Value = guid;
                HttpCookie cookie = new HttpCookie("UBC-GUID");
                cookie.Value = guid;
                cookie.Expires = DateTime.Now.AddMonths(3);
                Response.SetCookie(cookie);
            }

            if (Session["UBC_person_id"] == null && guid == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

            Dependencies.functions.tracker((string)Session["UBC_person_id"], guid ?? "", HttpContext.Current.Request.Url.PathAndQuery);

            if (Session["UBC_person_id"] == null)
            {
                html_button = "<input type=\"button\" id=\"login\" class=\"toprighticon btn btn-info\" value=\"Log in\" />";
            }
            else
            {
                html_button = "<input type=\"button\" id=\"menu\" class=\"toprighticon btn btn-info\" value=\"MENU\" />";

            }

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_all_events", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            string delim = "";
            DateTime today = DateTime.Now;
            int c1 = 0;
            try
            {
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    /*E.Event_ID, E.StartDateTime, E.EndDateTime, E.Title, E.Description,  daterange, 'Participants',[Categories], E.CopiedFrom_Event_ID*/

                    while (dr.Read())
                    {
                        string event_id = dr["event_id"].ToString();
                        DateTime startdatetime = (DateTime)dr["startdatetime"];
                        events += delim + event_id;
                        delim = ",";
                        if (currentevent == 0 && startdatetime >= today)
                        {
                            currentevent = c1; // event_id;
                        }
                        c1++;

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
            if (currentevent == 0)
            {
                currentevent = c1;
            }
        }
    }
}