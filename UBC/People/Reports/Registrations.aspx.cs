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
    public partial class Registrations : System.Web.UI.Page
    {
        public string html_registration;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                Response.Redirect("~/default.aspx");
            }

            html_registration = "<tr><th>Name</th><th>Season</th><th>Submitted</th><th>Status</th><th>Status<br />Date</th><th>Status<br />Person</th><th>View</th></tr>";

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("get_all_registrations", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = con;
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {

                string registration_id = dr["registration_id"].ToString();
                string name = dr["name"].ToString();
                if(name == "")
                {
                    name = dr["firstname"].ToString() + " " + dr["lastname"].ToString();
                }
                string CreatedDate = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yy");
                string season = dr["season"].ToString();
                string Status = dr["Status"].ToString();
                string StatusUpdatedDateTime = dr["StatusUpdatedDateTime"].ToString();
                string StatusUpdatedperson = dr["StatusUpdatedperson"].ToString();
                if (StatusUpdatedDateTime != "")
                {
                    StatusUpdatedDateTime = Convert.ToDateTime(StatusUpdatedDateTime).ToString("dd MMM yy");
                }
                string edit = "";

               // if(registration_id )
                //if (edit == "")
                //{
                //    edit = "<a href=\"javascript:void(0)\" class=\"registrationedit\" id=\"registeredit_" + registration_id + "\">";
                //}
                html_registration += "<tr>";
                html_registration += "<td>" + name + "</td>";
                html_registration += "<td>" + season + "</td>";
                html_registration += "<td>" + CreatedDate + "</td>";
                html_registration += "<td>" + Status + "</td>";
                html_registration += "<td>" + StatusUpdatedDateTime + "</td>";
                html_registration += "<td>" + StatusUpdatedperson + "</td>";
                html_registration += "<td><a href=\"javascript:void(0)\" class=\"registrationview\" id=\"registerview_" + registration_id + "_" + season + "\"> View" + edit + "</td>";
                html_registration += "</tr>";


            }
            dr.Close();
        }
    }
}
 
