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
    public partial class Event : System.Web.UI.Page
    {
        public string eventid;
        public string title;
        public string description;
        public string allday;
        public string allday_checked;
        public string startdatetime;
        public string enddatetime;
        public string datetime;


        public string[] attendance_values = new string[4] { "No", "Yes", "Partial", "Maybe" };
        protected void Page_Load(object sender, EventArgs e)
        {
            eventid = Request.QueryString["id"];
            if (eventid != "new")
            {

                if (!IsPostBack)
                {
                    string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_event", con);
                    cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;

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
                    cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;
                    cmd2.Parameters.Add("@mode", SqlDbType.VarChar).Value = "Possible";

                    cmd2.CommandType = CommandType.StoredProcedure;
                    cmd2.Connection = con;
                    try
                    {

                        SqlDataReader dr = cmd2.ExecuteReader();
                        if (dr.HasRows)
                        {

                            Lit_html.Text = "<tr><th>Name</th><th>Atendance</th><th>Note</th></tr>";

                            while (dr.Read())
                            {
                                string person_event_id = dr["person_event_id"].ToString();
                                string name = dr["name"].ToString();
                                string attendance = dr["attendance"].ToString();
                                string note = dr["note"].ToString();
                                string person_id = dr["person_id"].ToString();

                                string dd_attendance = "<select  class=\"form-control\" name=\"attendance_" + person_id + "\">";
                                dd_attendance += Functions.populateselect(attendance_values, attendance);
                                dd_attendance += "</select>";


                                Lit_html.Text += "<tr>";
                                Lit_html.Text += "<td>" + name + "</td>";
                                Lit_html.Text += "<td>" + dd_attendance + "</td>";
                                Lit_html.Text += "<td><textarea class=\"form-control\" name=\"note_" + person_id + "\">" + note + "</textarea></td>";
                                Lit_html.Text += "</tr>";
                            }
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
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd2 = new SqlCommand("update_event_person", con);
            cmd2.CommandType = CommandType.StoredProcedure;

            foreach (string fld in Request.Form)
            {
                string a = fld;
                if (fld.StartsWith("attendance_"))
                {
                    string person_id = fld.Substring(11);
                    string attendance = Request.Form[fld];
                    string note = Request.Form["note_" + person_id];

                    cmd2.Parameters.Clear();
                    cmd2.Parameters.Add("@event_id", SqlDbType.VarChar).Value = eventid;
                    cmd2.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                    cmd2.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
                    cmd2.Parameters.Add("@note", SqlDbType.VarChar).Value = note;

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

            Response.Redirect(Request.RawUrl);
        }
    }
}