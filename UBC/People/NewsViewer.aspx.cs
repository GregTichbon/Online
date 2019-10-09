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
    public partial class NewsViewer : System.Web.UI.Page
    {
        public string html = "";
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

            if(guid != null)
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


            if (Session["UBC_person_id"] == null) {
                html_button = "<input type=\"button\" id=\"login\" class=\"toprighticon btn btn-info\" value=\"Log in\" />";
            } else
            {
                html_button = "<input type=\"button\" id=\"menu\" class=\"toprighticon btn btn-info\" value=\"MENU\" />";
            }


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Person_News", con);
            cmd1.Parameters.Add("@person_id", SqlDbType.VarChar).Value = Session["UBC_person_id"];
            cmd1.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = guid;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    //html = "<tr><th>Date</th><th>Title</th></tr>";
                    html = "";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string news_id = dr["news_id"].ToString();
                        string title = dr["title"].ToString();
                        string article = dr["article"].ToString();
                        string date = Convert.ToDateTime(dr["date"].ToString()).ToString("ddd dd MMM yyyy HH:mm");
                        //string categories = dr["categories"].ToString();

                        string edit = "";
                        if (Session["UBC_person_id"] != null)
                        {
                            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1")) //Highest Level
                            {
                                edit = "<a href=\"news.aspx?id=" + news_id + "\">Edit</a>";
                            }
                        }
                        /*
                        html += "<div class=\"panel-group\">";
                        html += "<div class=\"panel panel-default\">";
                        html += "<div class=\"panel-heading\"><h3>" + title + " - " + date + "</h3>" + edit + "</div>";
                        html += "<div class=\"panel-body\">" + article + "</div>";
                        html += "</div>";
                        html += "</div>";
                        */

                        html += "<h3>" + title + " - " + date + "</h3>";
                        html += "<div>" + article + "<br /><div style=\"float:right\">" + edit + "</div></div>";
                        /*

                        html += "<tr>";
                        html += "<td>" + date + "</td><td>" + title + "</td>";
                        html += "</tr>";
                        */
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
