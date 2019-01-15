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

namespace UBC.People.Reports
{
    public partial class ShowAttendees : System.Web.UI.Page
    {
        public string html;
        public string guid;
        public string event_id;
        public string export;
        public string gotoevent;
        protected void Page_Load(object sender, EventArgs e)
        {
            guid = Request.QueryString["id"] ?? "";
            event_id = Request.QueryString["event"] ?? "";

            if (Session["UBC_person_id"] == null)
            {
                string url = "../reports/ShowAttendees.aspx?id=" + guid;
                Response.Redirect("~/people/security/login.aspx?return=" + url);
            }

            Boolean access = false;
            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1011"))
            {
                access = true;
            }


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Event_Attendees", con);
            cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;


            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    if (guid == "")
                    {
                        export = "";
                        gotoevent = "";
                        html = "<table class=\"table table-striped\">";
                        html += "<tr>";
                        html += "<th>Title</th><th>When</th><th>Detail</th>";
                        html += "</tr>";

                        while (dr.Read())
                        {
                            guid = dr["guid"].ToString();
                            event_id = dr["event_id"].ToString();
                            string title = dr["title"].ToString();
                            string when = dr["when"].ToString();
                            string description = dr["description"].ToString();

                            html += "<tr>";
                            html += "<td><a href=\"?id=" + guid + "&event=" + event_id + "\">" + title + "</a></td><td>" + when + "</td><td>" + description + "</td>";

                            html += "</tr>";
                        }
                    }
                    else 
                    {
                        export = "<input type=\"button\" id=\"export\" class=\"btn btn-info\" value=\"Export\" />";
                        gotoevent = "<input data-event_id=\"" + event_id + "\" type=\"button\" id=\"gotoevent\" class=\"btn btn-info\" value=\"Go to Event\" />";
                        html = "<table id=\"attendance\" class=\"table table-striped\">";
                        html += "<tr>";
                        html += "<th>Name</th><th>Status</th><th>Role</th><th style=\"white-space:nowrap\">Public Note</th>";
                        if (access)
                        {
                            html += "<th style=\"white-space:nowrap\">Person Note</th><th style=\"white-space:nowrap\">Private Note</th>";
                        }
                        html += "</tr>";
                        while (dr.Read())
                        {
                            string person_id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string attendance = dr["attendance"].ToString();
                            string role = dr["role"].ToString();
                            string note = dr["note"].ToString();

                            html += "<tr>";
                            html += "<td style=\"white-space:nowrap\">" + name + "</td><td style=\"white-space:nowrap\">" + attendance + "</td><td style=\"white-space:nowrap\">" + role + "</td><td>" + note + "</td>";
                            if (access)
                            {
                                string personnote = dr["personnote"].ToString();
                                string privatenote = dr["privatenote"].ToString();
                                html += "<td>" + personnote + "</td><td>" + privatenote + "</td>";
                            }
                            html += "</tr>";
                        }
                    }
                    html += "</table>";
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