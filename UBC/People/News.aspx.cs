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
    public partial class News : System.Web.UI.Page
    {
        public string news_id;
        //public string guid;
        public string title;
        public string article;
        public string categories;
        public string date;
        public string day = "";
        public string html_persons;

        public string[] noyes_values = new string[2] { "No", "Yes" };
        public string categories_values;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1000001"))
            {
                Response.Redirect("~/default.aspx");
            }

            if (!IsPostBack)
            {
                Functions genericfunctions = new Functions();
                Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                categories = "";

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                //guid = Request.QueryString["guid"];
                news_id = Request.QueryString["id"];

                if (news_id != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_news", con);
                    cmd1.Parameters.Add("@news_id", SqlDbType.VarChar).Value = news_id;
                    //cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            title = dr["title"].ToString();
                            article = dr["article"].ToString();
                            categories = dr["categories"].ToString();
                            date = Convert.ToDateTime(dr["date"].ToString()).ToString("ddd dd MMM yyyy HH:mm");
                        }

                        dr.Close();
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }

                    SqlCommand cmd2 = new SqlCommand("get_news_person", con);
                    cmd2.Parameters.Add("@news_id", SqlDbType.VarChar).Value = news_id;

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Connection = con;
                    try
                    {

                        SqlDataReader dr = cmd2.ExecuteReader();
                        if (dr.HasRows)
                        {
                            html_persons = "";

                            html_persons += "<hr />";
                            html_persons += "<div id=\"div_count\"></div>";

                            functionoptions.Clear();
                            functionoptions.Add("storedprocedure", "");
                            functionoptions.Add("usevalues", "");
                            categories_values = Functions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");

                            //html_persons += "<div class=\"form-inline\">";
                            html_persons += "<select class=\"form-control\" id=\"dd_categories_filter\" name=\"dd_categories_filter\" multiple=\"multiple\">" + categories_values + "</select>";
                            html_persons += "<button type=\"button\" class=\"submit btn btn-info\" id=\"btn_refresh\">Refresh</button>";
                            //html_persons += "</div>";

                            html_persons += "<table id=\"tbl_people\" class=\"table table-hover\"><tr><th>Name</th></tr>";

                            while (dr.Read())
                            {
                                string person_news_id = dr["person_news_id"].ToString();
                                string guid = dr["guid"].ToString();
                                string name = dr["name"].ToString();
                                string person_id = dr["person_id"].ToString();
                                string category = dr["category"].ToString();

                                /*
                                string dd_attendance = "<select class=\"form-control tr_field\" id=\"dd_attendance_" + person_id + "\" data-id=\"" + person_id + "\" name=\"dd_attendance_" + person_id + "\">";
                                dd_attendance += Functions.populateselect(attendance_values, attendance, "");
                                dd_attendance += "</select>";
                                */

                            
                                html_persons += "<tr id=\"tr_" + person_id + "\" data-id=\"" + person_news_id + "\" data-category=\"" + category + "\">";
                                html_persons += "<td><a href=\"maint.aspx?id=" + guid + "\" target=\"maint\">" + name + "</a></td>";
                                html_persons += "</tr>";
                            }

                            html_persons += "</table>";
                        }

                        dr.Close();
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }

                    con.Close();
                    con.Dispose();
                }
                else
                {
                    functionoptions.Clear();
                    functionoptions.Add("storedprocedure", "");
                    functionoptions.Add("usevalues", "");
                    //categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
                    categories_values = Functions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
                }
                
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string news_id = Request.Form["hf_news_id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("update_news", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@news_id", SqlDbType.VarChar).Value = news_id;
            cmd1.Parameters.Add("@date", SqlDbType.VarChar).Value = Request.Form["tb_date"].Trim();
            cmd1.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["tb_title"].Trim();
            cmd1.Parameters.Add("@article", SqlDbType.VarChar).Value = Request.Form["tb_article"].Trim();
            cmd1.Parameters.Add("@categories", SqlDbType.VarChar).Value = Request.Form["dd_categories"];

            cmd1.Connection = con;
            try
            {
                news_id = cmd1.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }


            /*
            if (news_id != "new")
            {

                SqlCommand cmd2 = new SqlCommand("update_event_person", con);
                cmd2.CommandType = CommandType.StoredProcedure;

                string hf_tr_changed = Request.Form["hf_tr_changed"].ToString();
                if (hf_tr_changed != "")
                {
                    string[] tr_changed = hf_tr_changed.Split(',');
                    foreach (string person_id in tr_changed)
                    {
                        string attendance = Request.Form["dd_attendance_" + person_id];
                        
                        cmd2.Parameters.Clear();
                        cmd2.Parameters.Add("@news_id", SqlDbType.VarChar).Value = news_id;
                        cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                        cmd2.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
                       

                        cmd2.Connection = con;
                        try
                        {
                            cmd2.ExecuteScalar();
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }
                }

               
            }
            */
            con.Close();
            con.Dispose();

            string URL = Request.RawUrl;
            URL = URL.Substring(0, URL.IndexOf("?")) + "?id=" + news_id;
            Response.Redirect(URL);
        }
    }
}
