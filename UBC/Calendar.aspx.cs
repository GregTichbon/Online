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

namespace UBC
{
    public partial class Calendar : System.Web.UI.Page
    {
        public string html = "";
        public string html_button;
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            */
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
            SqlCommand cmd1 = new SqlCommand("Get_Calendar", con);

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
                        string calendar_id = dr["calendar_id"].ToString();
                        string eventDesc = dr["event"].ToString();
                        string daterange = dr["daterange"].ToString();
                        string colour = dr["colour"].ToString();

                        if(colour == "")
                        {
                            colour = "None";
                        }

                        html += "<tr class=\"" + colour + "\">";
                        html += "<td>" + daterange + "</td><td>" + eventDesc + "</td>";
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