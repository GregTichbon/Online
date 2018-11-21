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
        protected void Page_Load(object sender, EventArgs e)
        {
            guid = Request.QueryString["id"] ?? "";

            if (Session["UBC_person_id"] == null)
            {
                string url = "../reports/ShowAttendees.aspx?id=" + guid;
                Response.Redirect("~/people/security/login.aspx?return=" + url);
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
                    html = "<table class=\"table-striped\">";
                    if (guid == "")
                    {
                        html += "<tr><th>Title</th><th style=\"white-space:nowrap\">When</th><th>Detail</th></tr>";

                        while (dr.Read())
                        {
                            guid = dr["guid"].ToString();
                            string title = dr["title"].ToString();
                            string when = dr["when"].ToString();
                            string description = dr["description"].ToString();

                            html += "<tr>";
                            html += "<td><a href=\"?id=" + guid + "\">" + title + "</a></td><td>" + when + "</td><td>" + description + "</td>";
                            html += "</tr>";
                        }
                    }
                    else
                    {
                        html += "<tr><th>Name</th><th>Status</th><th>Role</th></tr>";

                        while (dr.Read())
                        {
                            string person_id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string attendance = dr["attendance"].ToString();
                            string role = dr["role"].ToString();


                            html += "<tr>";
                            html += "<td>" + name + "</td><td>" + attendance + "</td><td>" + role + "</td>";
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