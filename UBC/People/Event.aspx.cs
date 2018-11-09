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

    /*
    To do: 
    Filter by role
    Record default categories in event table
    When looping through filter do counts
    Show that their are hidden records which are noted

    */

    public partial class Event : System.Web.UI.Page
    {
        public string event_id;
        public string title;
        public string description;
        public string allday;
        public string allday_checked;
        public string startdatetime;
        public string enddatetime;
        public string datetime;
        public string type;
        public string role;
        public string categories;
        public string html_persons;


        public string[] attendance_values = new string[7] { "No", "Yes", "Partial", "Maybe", "Expected", "Going","Not Going" };
        public string[] type_values = new string[7] { "Training", "Regatta", "Social Row", "Social Event", "Promotion", "Committee Meeting", "Other"};
        public string[] role_values = new string[6] { "Rower", "Coach", "Cox", "Gym/Excercise" ,"Coach Support", "Support" };
        public string categories_values;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

            if (!IsPostBack)
            {
                Functions genericfunctions = new Functions();
                Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                categories = "";

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                event_id = Request.QueryString["id"];

                if (event_id != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_event", con);
                    cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            title = dr["title"].ToString();
                            description = dr["description"].ToString();
                            allday = dr["allday"].ToString();
                            startdatetime = dr["startdatetime"].ToString();
                            enddatetime = dr["enddatetime"].ToString();
                            type = dr["type"].ToString();
                            categories = dr["categories"].ToString();

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


                    SqlCommand cmd2 = new SqlCommand("get_event_person", con);
                    cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
                    cmd2.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Possible";

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Connection = con;
                    try
                    {

                        SqlDataReader dr = cmd2.ExecuteReader();
                        if (dr.HasRows)
                        {
                            html_persons = "";
                            //html_persons = "<div id=\"accordion\">";
                            //html_persons += "<h3>People</h3>";

                            html_persons += "<hr />";
                            html_persons += "<div id=\"div_count\"></div>";
                            //html_persons += "<a id=\"btn_notes\" class=\"btn btn-info\" role=\"button\">Show only noted</a>";

                            functionoptions.Clear();
                            functionoptions.Add("storedprocedure", "");
                            functionoptions.Add("usevalues", "");
                            categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
                            html_persons += "<select class=\"form-control\" id=\"dd_categories_filter\" name=\"dd_categories_filter\" multiple=\"multiple\">" + categories_values + "</select>";

                            html_persons += "<div class=\"form-inline\">";
                            html_persons += "<select class=\"form-control\" id=\"dd_show\" name=\"dd_show\"><option selected>All</option><option>Only noted</option><option>Only attended or noted</option><option>Not noted</option></select>";
                            html_persons += "&nbsp;&nbsp;<button type=\"button\" class=\"submit btn btn-info\" id=\"btn_refresh\">Refresh</button>";
                            html_persons += "</div>";

                            html_persons += "<table id=\"tbl_attendance\" class=\"table table-hover\"><tr><th>Name</th><th>Atendance</th><th>Role</th><th>Note</th></tr>";

                            while (dr.Read())
                            {
                                string person_event_id = dr["person_event_id"].ToString();
                                string name = dr["name"].ToString();
                                string attendance = dr["attendance"].ToString();
                                string note = dr["note"].ToString();
                                string personnote = dr["personnote"].ToString();
                                string person_id = dr["person_id"].ToString();
                                string role = dr["role"].ToString();
                                string category = dr["category"].ToString();

                                string dd_attendance = "<select class=\"form-control tr_field\" id=\"dd_attendance_" + person_id + "\" name=\"dd_attendance_" + person_id + "\">";
                                dd_attendance += Functions.populateselect(attendance_values, attendance,"");
                                dd_attendance += "</select>";

                                string dd_role = "<select class=\"form-control tr_field\" id=\"dd_role_" + person_id + "\" name=\"dd_role_" + person_id + "\">";
                                dd_role += "<option></option>";
                                dd_role += Functions.populateselect(role_values, role);
                                dd_role += "</select>";

                                html_persons += "<tr id=\"tr_" + person_id + "\" data-id=\"" + person_event_id + "\" data-category=\"" + category + "\">";
                                html_persons += "<td>" + name + "</td>";
                                html_persons += "<td>" + dd_attendance + "</td>";
                                html_persons += "<td>" + dd_role + "</td>";
                                html_persons += "<td><textarea class=\"form-control tr_field\" id=\"tb_note_" + person_id + "\" name=\"tb_note_" + person_id + "\">" + note + "</textarea><span class=\"personnote\" id=\"personnote_" + person_id + "\">" + personnote + "</span></td>";
                                html_persons += "</tr>";
                            }

                            html_persons += "</table>";
                            //html_persons += "</div>";

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

                functionoptions.Clear();
                functionoptions.Add("storedprocedure", "");
                functionoptions.Add("usevalues", "");
                categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string event_id = Request.Form["hf_event_id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("update_event", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd1.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["tb_title"].Trim();
            cmd1.Parameters.Add("@description", SqlDbType.VarChar).Value = Request.Form["tb_description"].Trim();
            cmd1.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = Request.Form["tb_startdatetime"].Trim();
            cmd1.Parameters.Add("@enddatetime", SqlDbType.VarChar).Value = Request.Form["tb_enddatetime"].Trim();
            cmd1.Parameters.Add("@allday", SqlDbType.VarChar).Value = Request.Form["cb_allday"];
            cmd1.Parameters.Add("@type", SqlDbType.VarChar).Value = Request.Form["dd_type"];
            cmd1.Parameters.Add("@categories", SqlDbType.VarChar).Value = Request.Form["dd_categories"];

            cmd1.Connection = con;
            try
            {
                event_id = cmd1.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }



            if (event_id != "new")
            {

                SqlCommand cmd2 = new SqlCommand("update_event_person", con);
                cmd2.CommandType = CommandType.StoredProcedure;

                /*
                foreach (string fld in Request.Form)
                {
                    string a = fld;
                    if (fld.StartsWith("dd_attendance_"))
                    {
                        string person_id = fld.Substring(14);
                        string attendance = Request.Form[fld];
                        string note = Request.Form["tb_note_" + person_id];
                        string role = Request.Form["dd_role_" + person_id];

                        cmd2.Parameters.Clear();
                        cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
                        cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                        cmd2.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
                        cmd2.Parameters.Add("@note", SqlDbType.VarChar).Value = note;
                        cmd2.Parameters.Add("@role", SqlDbType.VarChar).Value = role;

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
                */
                            string hf_tr_changed = Request.Form["hf_tr_changed"].ToString();
                if (hf_tr_changed != "")
                {
                    string[] tr_changed = hf_tr_changed.Split(',');
                    foreach (string person_id in tr_changed)
                    {
                        string attendance = Request.Form["dd_attendance_" + person_id];
                        string note = Request.Form["tb_note_" + person_id];
                        string role = Request.Form["dd_role_" + person_id];

                        cmd2.Parameters.Clear();
                        cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
                        cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                        cmd2.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
                        cmd2.Parameters.Add("@note", SqlDbType.VarChar).Value = note;
                        cmd2.Parameters.Add("@role", SqlDbType.VarChar).Value = role;

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

                con.Close();
                con.Dispose();
            }

            string URL = Request.RawUrl;
            URL = URL.Substring(0, URL.IndexOf("?")) + "?id=" + event_id;
            Response.Redirect(URL);
        }
    }
}
