using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People
{
    public partial class Maint : System.Web.UI.Page
    {
        public string hf_guid;
        public string hf_person_id;
        public string tb_firstname;
        public string tb_lastname;
        public string tb_knownas;
        public string tb_birthdate;
        public string dd_gender;
        public string tb_medical;
        public string tb_dietry;
        public string tb_email;
        public string tb_mobile;
        public string tb_landline;
        public string dd_category;
        public string dd_school;
        public string tb_schoolyear;
        public string tb_facebook;
        /*
        public string tb_caregivername;
        public string tb_caregiveremail;
        public string tb_caregivermobile;
        public string tb_caregiverlandline;
        public string dd_coming;
        public string tb_facebook;
        */
        public string tb_notes;


        public string[] school = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gender = new string[2] { "Female", "Male" };
        public string[] category = new string[3] { "School", "Club", "Cox" };
        public string[] systems = new string[2] { "UBC", "Friends" };
        public string[] yesno = new string[2] { "Yes", "No" };


        protected void Page_Load(object sender, EventArgs e)
        {
            hf_guid = Request.QueryString["id"];

            if (hf_guid != "new")
            {

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "get_person";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;


                cmd.Connection = con;
                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        hf_person_id = dr["person_id"].ToString();
                        tb_firstname = dr["firstname"].ToString();
                        tb_lastname = dr["lastname"].ToString();
                        tb_knownas = dr["knownas"].ToString();
                        tb_birthdate = dr["birthdate"].ToString();
                        dd_gender = dr["gender"].ToString();
                        tb_medical = dr["medical"].ToString();
                        tb_dietry = dr["dietry"].ToString();
                        tb_facebook = dr["facebook"].ToString();
                        dd_school = dr["school"].ToString();
                        tb_schoolyear = dr["schoolyear"].ToString();
                        tb_notes = dr["notes"].ToString();
                        /*
tb_email = dr["email"].ToString();
tb_mobile = dr["mobile"].ToString();
tb_landline = dr["landline"].ToString();
tb_caregivername = dr["caregivername"].ToString();
tb_caregiveremail = dr["caregiveremail"].ToString();
tb_caregivermobile = dr["caregivermobile"].ToString();
tb_caregiverlandline = dr["caregiverlandline"].ToString();
*/
                        //dd_coming = dr["coming"].ToString();

                        if (tb_birthdate != "")
                        {
                            tb_birthdate = Convert.ToDateTime(tb_birthdate).ToString("dd MMM yy");
                        }


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                Lit_attendance.Text = "<tr><th>When</th><th>What</th><th>Attendance</th><th>Note</th></tr>";

                cmd.CommandText = "get_person_event";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_event_id = dr["person_event_id"].ToString();
                        string event_id = dr["event_id"].ToString();
                        string title = dr["title"].ToString();
                        string startdatetime = Convert.ToDateTime(dr["startdatetime"]).ToString("dd MMM yy hh:mm");
                        string enddatetime = Convert.ToDateTime(dr["enddatetime"]).ToString("dd MMM yy hh:mm");
                        string daterange = dr["daterange"].ToString();
                        string attendance = dr["attendance"].ToString();
                        string note = dr["note"].ToString();

                        Lit_attendance.Text += "<tr>";
                        Lit_attendance.Text += "<td>" + daterange + "</td>";
                        Lit_attendance.Text += "<td>" + title + "</td>";
                        Lit_attendance.Text += "<td>" + attendance + "</td>";
                        Lit_attendance.Text += "<td>" + note + "</td>";
                        Lit_attendance.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }


                //-------------------------------------------------------------------------------------
                Lit_finance.Text = "<tr><th>Date</th><th>System</th><th>Detail</th><th>Amount</th><th>Note</th></tr>";
                double total = 0;

                cmd.CommandText = "get_person_finance";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_finance_id = dr["person_finance_id"].ToString();
                        string date = Convert.ToDateTime(dr["date"]).ToString("dd MMM yy");
                        string system = dr["system"].ToString();
                        string detail = dr["detail"].ToString();
                        string amount = dr["amount"].ToString();
                        string note = dr["note"].ToString();

                        total += Convert.ToDouble(  amount);


                        Lit_finance.Text += "<tr>";
                        Lit_finance.Text += "<td>" + date + "</td>";
                        Lit_finance.Text += "<td>" + system + "</td>";
                        Lit_finance.Text += "<td>" + detail + "</td>";
                        Lit_finance.Text += "<td>" + amount + "</td>";
                        Lit_finance.Text += "<td>" + note + "</td>";
                        Lit_finance.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }



                //-------------------------------------------------------------------------------------
                Lit_phone.Text = "<tr><th>Number</th><th>Mobile</th><th>Send Texts</th><th>Note</th><th>Send Now</th></tr>";

                cmd.CommandText = "get_person_phone";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_phone_id = dr["person_phone_id"].ToString();
                        string phone = dr["phone"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string text = dr["text"].ToString();
                        string note = dr["note"].ToString();

                        string send = "";
                        if (text == "Yes")
                        {
                            send = "<a class=\"send_text\">Send</a>";
                        }

                        Lit_phone.Text += "<tr>";
                        Lit_phone.Text += "<td>" + phone + "</td>";
                        Lit_phone.Text += "<td>" + mobile + "</td>";
                        Lit_phone.Text += "<td>" + text + "</td>";
                        Lit_phone.Text += "<td>" + note + "</td>";
                        Lit_phone.Text += "<td>" + send + "</td>";

                        Lit_phone.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                //-------------------------------------------------------------------------------------
                Lit_email.Text = "<tr><th>Email</th><th>Note</th><th>System Send</th><th>Local Send</th></tr>";

                cmd.CommandText = "get_person_email";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_email_id = dr["person_email_id"].ToString();
                        string email = dr["email"].ToString();
                        string note = dr["note"].ToString();

                        string sendsystem = "<a class=\"send_email_system\">Send</a>";
                        string sendlocal = "<a class=\"send_email_local\">Send</a>";

                        Lit_email.Text += "<tr>";
                        Lit_email.Text += "<td>" + email + "</td>";
                        Lit_email.Text += "<td>" + note + "</td>";
                        Lit_email.Text += "<td>" + sendsystem + "</td>";
                        Lit_email.Text += "<td>" + sendlocal + "</td>";

                        Lit_email.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                //-------------------------------------------------------------------------------------
                Lit_category.Text = "<tr><th>Category</th><th>From</th><th>To</th><th>Note</th></tr>";

                cmd.CommandText = "get_person_category";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_category_id = dr["person_category_id"].ToString();
                        string category_id = dr["category_id"].ToString();
                        string category = dr["category"].ToString();

                        string startdate = dr["startdate"].ToString();
                        if(startdate != "")
                        {
                            startdate = Convert.ToDateTime(startdate).ToString("dd MMM yy");
                        }

                        string enddate = "";// Convert.ToDateTime(dr["startdate"]).ToString("dd MMM yy");
                        string note = dr["note"].ToString();

                        Lit_category.Text += "<tr>";
                        Lit_category.Text += "<td>" + category + "</td>";
                        Lit_category.Text += "<td>" + startdate + "</td>";
                        Lit_category.Text += "<td>" + enddate + "</td>";
                        Lit_category.Text += "<td>" + note + "</td>";

                        Lit_category.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                //-------------------------------------------------------------------------------------
                Lit_results.Text = "<tr><th>Regatta</th><th>Event</th><th>Place</th></tr>";

                cmd.CommandText = "get_person_results";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_regatta_id = dr["person_regatta_id"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string eventdesc = dr["event"].ToString();
                        string place = dr["place"].ToString();
                        string regatta = dr["name"].ToString();
                        string daterange = dr["daterange"].ToString();


                        //string note = dr["note"].ToString();

                        Lit_results.Text += "<tr>";
                        Lit_results.Text += "<td>" + regatta + " (" + daterange +  ")</td>";
                        Lit_results.Text += "<td>" + eventdesc + "</td>";
                        Lit_results.Text += "<td>" + place + "</td>";
                        //Lit_results.Text += "<td>" + note + "</td>";

                        Lit_results.Text += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                //-------------------------------------------------------------------------------------

                con.Close();
                con.Dispose();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region fields
            hf_guid = Request.Form["hf_guid"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_knownas = Request.Form["tb_knownas"].Trim();
            tb_birthdate = Request.Form["tb_birthdate"].Trim();
            dd_gender = Request.Form["dd_gender"].Trim();
            dd_school = Request.Form["dd_school"].Trim();
            tb_schoolyear = Request.Form["tb_schoolyear"].Trim();
            tb_notes = Request.Form["tb_notes"];
            tb_dietry = Request.Form["tb_dietry"].Trim();
            tb_medical = Request.Form["tb_medical"].Trim();
            /*
            tb_email = Request.Form["tb_email"].Trim();
            tb_mobile = Request.Form["tb_mobile"].Trim();
            tb_landline = Request.Form["tb_landline"].Trim();
            
            tb_caregivername = Request.Form["tb_caregivername"].Trim();
            tb_caregiveremail = Request.Form["tb_caregiveremail"].Trim();
            tb_caregivermobile = Request.Form["tb_caregivermobile"].Trim();
            tb_caregiverlandline = Request.Form["tb_caregiverlandline"].Trim();
            dd_coming = Request.Form["dd_coming"];
            tb_facebook = Request.Form["tb_facebook"];
            */
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_Person";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@knownas", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@birthdate", SqlDbType.VarChar).Value = tb_birthdate;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = dd_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = tb_schoolyear;
            cmd.Parameters.Add("@dietry", SqlDbType.VarChar).Value = tb_dietry;
            cmd.Parameters.Add("@medical", SqlDbType.VarChar).Value = tb_medical;
            cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@notes", SqlDbType.VarChar).Value = tb_notes;


            /*
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = tb_email;
            cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = tb_mobile;
            cmd.Parameters.Add("@landline", SqlDbType.VarChar).Value = tb_landline;
            cmd.Parameters.Add("@caregivername", SqlDbType.VarChar).Value = tb_caregivername;
            cmd.Parameters.Add("@caregiveremail", SqlDbType.VarChar).Value = tb_caregiveremail;
            cmd.Parameters.Add("@caregivermobile", SqlDbType.VarChar).Value = tb_caregivermobile;
            cmd.Parameters.Add("@caregiverlandline", SqlDbType.VarChar).Value = tb_caregiverlandline;
            cmd.Parameters.Add("@coming", SqlDbType.VarChar).Value = dd_coming;
            cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            */
            #endregion

            cmd.Connection = con;
            try
            {
                con.Open();
                string result = cmd.ExecuteScalar().ToString();
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

            Response.Redirect("list.aspx");
        }
    }
}