using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace UBC.People
{
    public partial class Maint : System.Web.UI.Page
    {
        public string returnto;

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
        public string dd_feecategory;
        public string dd_familymember;
        public string dd_school;
        public string tb_schoolyear;
        public string tb_facebook;
        public string tb_residentialaddress;
        public string tb_postaladdress;
        public string tb_colour;
        public string dd_swimmer;
        public string tb_rowit_id;
        public string tb_keynumber;
        public string tb_onloanfromclub;
        public string dd_relationshiponly;

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
        public string[] feecategory = new string[6] { "Full", "Recreational", "Cox", "Novice", "Special", "N/A" };
        public string[] yesno = new string[2] { "Yes", "No" };
        public string[] familymember = new string[5] { "1", "2","3","4","5" };
        public string[] finance_system = new string[2] { "UBC", "Friends" };
        public string[] finance_code = new string[6] { "Full Regatta", "Boat Transport", "Accomodation","Clothing","Fees","Race Fees" };
        public string person_financial_events;

        public string html_tabs = "";
        public string html_email = "";
        public string html_system = "";
        public string html_finance = "";
        public string html_registration = "";
        public string html_loginregister = "";
        public string html_tracker = "";
        public string html_attendance = "";
        public string html_phone = "";
        public string html_category = "";
        public string html_results = "";
        public string html_arrangements = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

                       hf_guid = Request.QueryString["id"];

            /*
                        html_tabs += "<li><a data-target=\"#div_category\">Category</a></li>";
                        html_tabs += "<li><a data-target=\"#div_phone\">Phone</a></li>";
                        html_tabs += "<li><a data-target=\"#div_address\">Address</a></li>";
                        html_tabs += "<li><a data-target=\"#div_email\">Email</a></li>";
                        html_tags += "<li><a data-target=\"#div_attendance\">Attendance</a></li>";
                        html_tabs += "<li><a data-target=\"#div_results\">Results</a></li>";
                        html_tabs += "<li><a data-target=\"#div_registration\">Registration</a></li>";
            */

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "10001"))
            {

                html_tabs += "<li><a data-target=\"#div_finance\">Finance</a></li>";
                html_tabs += "<li><a data-target=\"#div_arrangements\">Arrangements</a></li>";
            }

            if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
            {

                html_tabs += "<li><a data-target=\"#div_system\">System</a></li>";
                html_tabs += "<li><a data-target=\"#div_loginregister\">Logins</a></li>";
                html_tabs += "<li><a data-target=\"#div_tracker\">Tracker</a></li>";
            }
            returnto = Request.QueryString["returnto"] + "";

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

  


            if (hf_guid != "new")
            {

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
                        tb_residentialaddress = dr["residentialaddress"].ToString();
                        tb_postaladdress = dr["postaladdress"].ToString();
                        tb_colour = dr["colour"].ToString();
                        dd_feecategory = dr["feecategory"].ToString();
                        dd_familymember = dr["familymember"].ToString();

                        dd_swimmer = dr["swimmer"].ToString();
                        tb_rowit_id = dr["rowit_id"].ToString();
                        tb_keynumber = dr["keynumber"].ToString();
                        tb_onloanfromclub = dr["onloanfromclub"].ToString();
                        dd_relationshiponly = dr["relationshiponly"].ToString();



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
                            tb_birthdate = Convert.ToDateTime(tb_birthdate).ToString("dd MMM yyyy");
                        }


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                html_attendance = "<tr><th>When</th><th>What</th><th>Attendance</th><th>Note</th></tr>";

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

                        html_attendance += "<tr>";
                        html_attendance += "<td>" + daterange + "</td>";
                        html_attendance += "<td>" + title + "</td>";
                        html_attendance += "<td>" + attendance + "</td>";
                        html_attendance += "<td>" + note + "</td>";
                        html_attendance += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }


                //-------------------------------------------------------------------------------------
                //FINANCE
                if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "10001"))
                {
                    html_finance = "<thead>";
                    html_finance += "<tr><th>Date</th><th>System</th><th>Code</th><th>Event</th><th>Amount</th><th>Note</th><th>Banked</th><th>Edit</th></tr>";
                    html_finance += "</thead>";
                    html_finance += "<tbody>";
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
                            string amount = Convert.ToDouble(dr["amount"]).ToString("0.00");
                            string note = dr["note"].ToString();
                            string code = dr["code"].ToString();
                            string event_id = dr["event_id"].ToString();
                            string person_event_id = dr["person_event_id"].ToString();
                            string banked = dr["banked"].ToString();
                            if(banked != "")
                            {
                                banked = Convert.ToDateTime(banked).ToString("dd MMM yy");
                            }

                            total += Convert.ToDouble(amount);


                            html_finance += "<tr>";
                            html_finance += "<td>" + date + "</td>";
                            html_finance += "<td>" + system + "</td>";
                            html_finance += "<td>" + code + "</td>";
                            html_finance += "<td>" + event_id + "</td>";
                            html_finance += "<td>" + amount + "</td>";
                            html_finance += "<td>" + note + "</td>";
                            html_finance += "<td>" + banked + "</td>";
                            html_finance += "<td><a href=\"javascript:void(0)\" class=\"financeedit\" id=\"" + person_finance_id + "\">Edit</td>";
                            html_finance += "</tr>";


                        }
                        dr.Close();
                        html_finance += "</tbody>";

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
            

                //-------------------------------------------------------------------------------------
                    html_arrangements = "TO DO";
                }

                //-------------------------------------------------------------------------------------

                html_registration = "<tr><th>Season</th><th>Submitted</th><th>View</th></tr>";

                cmd.CommandText = "get_person_registration";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        //string registration_id = dr["registration_id"].ToString();
                        string CreatedDate = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yy");
                        string season = dr["season"].ToString();


                        html_registration += "<tr>";
                        html_registration += "<td>" + season + "</td>";
                        html_registration += "<td>" + CreatedDate + "</td>";
                        html_registration += "<td><a href=\"javascript:void(0)\" class=\"registrationview\" id=\"" + hf_guid + "\"> View</td>";
                        html_registration += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                //-------------------------------------------------------------------------------------
                //LOGIN REGISTER
                if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                {
                    html_loginregister = "<tr><th>Date</th><th>Success</th></tr>";

                    cmd.CommandText = "get_person_login_register";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string datetime = dr["datetime"].ToString();
                            //string success = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yy");
                            string success = dr["success"].ToString();


                            html_loginregister += "<tr>";
                            html_loginregister += "<td>" + datetime + "</td>";
                            html_loginregister += "<td>" + success + "</td>";
                            html_loginregister += "</tr>";


                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
                //-------------------------------------------------------------------------------------
                //TRACKER
                if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                {
                    html_tracker = "<tr><th>Date</th><th>Success</th></tr>";

                    cmd.CommandText = "get_person_tracker";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string DateCreated = dr["DateCreated"].ToString();
                            //string success = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yy");
                            string URL = dr["URL"].ToString();
                            URL = "<a href=\"" + URL + "\" target=\"link\">" + URL + "</a>";


                            html_tracker += "<tr>";
                            html_tracker += "<td>" + DateCreated + "</td>";
                            html_tracker += "<td>" + URL + "</td>";
                            html_tracker += "</tr>";


                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
                //-------------------------------------------------------------------------------------
                html_phone = "<tr><th>Number</th><th>Mobile</th><th>Send Texts</th><th>Note</th><th>Send Now</th></tr>";

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
                        if(phone != "")
                        {
                            phone = "<a href=\"tel:" + phone + "\">" + phone + "</>";
                        }

                        html_phone += "<tr>";
                        html_phone += "<td>" + phone + "</td>";
                        html_phone += "<td>" + mobile + "</td>";
                        html_phone += "<td>" + text + "</td>";
                        html_phone += "<td>" + note + "</td>";
                        html_phone += "<td>" + send + "</td>";

                        html_phone += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                //-------------------------------------------------------------------------------------
                html_email = "<tr><th>Email</th><th>Note</th><th>System Send</th><th>Local Send</th></tr>";

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

                        html_email += "<tr>";
                        html_email += "<td>" + email + "</td>";
                        html_email += "<td>" + note + "</td>";
                        html_email += "<td>" + sendsystem + "</td>";
                        html_email += "<td>" + sendlocal + "</td>";

                        html_email += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                //-------------------------------------------------------------------------------------
                html_category = "<tr><th>Category</th><th>From</th><th>To</th><th>Note</th></tr>";

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

                        html_category += "<tr>";
                        html_category += "<td>" + category + "</td>";
                        html_category += "<td>" + startdate + "</td>";
                        html_category += "<td>" + enddate + "</td>";
                        html_category += "<td>" + note + "</td>";

                        html_category += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

//-------------------------------------------------------------------------------------
                html_results = "<thead><tr>";
                html_results += "<th data-hidden='true'>person_event_id</th>";
                //html_results += "<th data-hidden='true'>ID2</th>";
                html_results += "<th>Regatta</th>";
                html_results += "<th>Event</th>";
                html_results += "<th>Place</th>";
                //html_results += "<th data-hidden='false'>TEST</th>";
                //html_results += "<th data-tmpl=\"<span class='material-icons gj-cursor-pointer'>results_edit</span>\" align=\"center\" data-events=\"click: results_edit\"></th>";
                //html_results += "<th data-tmpl=\"<span class='material-icons gj-cursor-pointer'>results_delete</span>\" align=\"center\" data-events=\"click: results_delete\"></th>";
                html_results += "<th data-width='60' data-tmpl='Edit' data-events='click: results_edit'></th>";
                html_results += "<th data-width='80' data-tmpl='Delete' data-events='click: results_delete'></th>";
                html_results += "</tr></thead>";
                html_results += "<tbody>";

                cmd.CommandText = "get_person_results";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                try
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string person_event_id = dr["person_event_id"].ToString();
                        //string person_id = dr["person_id"].ToString();
                        string event_id = dr["event_id"].ToString();
                        string eventdesc = dr["event"].ToString();
                        string place = dr["place"].ToString();
                        string eventtitle = dr["title"].ToString();
                        string daterange = dr["daterange"].ToString();


                        //string note = dr["note"].ToString();

                        html_results += "<tr>";
                        html_results += "<td>" + person_event_id + "</td>";
                        //html_results += "<td>" + event_id + "</td>";
                        html_results += "<td>" + eventtitle + " (" + daterange + ")</td>";
                        html_results += "<td>" + eventdesc + "</td>";
                        html_results += "<td>" + place + "</td>";
                        //html_results += "<td>TEST</td>";
                        html_results += "<td></td>";
                        html_results += "<td></td>";
                        //html_results += "<td>" + note + "</td>";

                        html_results += "</tr>";


                    }
                    dr.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                html_results += "</tbody>";

                //-------------------------------------------------------------------------------------

                con.Close();
                con.Dispose();

                Functions genericfunctions = new Functions();
                Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                functionoptions.Clear();
                functionoptions.Add("storedprocedure", "");
                functionoptions.Add("storedprocedurename", "");
                functionoptions.Add("parameters", hf_person_id);
                functionoptions.Add("usevalues", "");
                person_financial_events = genericfunctions.buildandpopulateselect(strConnString, "get_person_financial_events", "", functionoptions, "None");
            }



        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            foreach(string name in Request.Form)
            {
                string x = name;
            }


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
            tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_colour = Request.Form["tb_colour"].Trim();
            tb_facebook = Request.Form["tb_facebook"].Trim();
            dd_feecategory = Request.Form["dd_feecategory"].Trim();
            dd_familymember = Request.Form["dd_familymember"].Trim();


            tb_rowit_id = Request.Form["tb_rowit_id"].Trim();
            tb_keynumber = Request.Form["tb_keynumber"].Trim();
            tb_onloanfromclub = Request.Form["tb_onloanfromclub"].Trim();
            dd_swimmer = Request.Form["dd_swimmer"].Trim();
            dd_relationshiponly = ""; // Request.Form["dd_relationshiponly"].Trim();

            /*
            tb_email = Request.Form["tb_email"].Trim();
            tb_mobile = Request.Form["tb_mobile"].Trim();
            tb_landline = Request.Form["tb_landline"].Trim();
            
            tb_caregivername = Request.Form["tb_caregivername"].Trim();
            tb_caregiveremail = Request.Form["tb_caregiveremail"].Trim();
            tb_caregivermobile = Request.Form["tb_caregivermobile"].Trim();
            tb_caregiverlandline = Request.Form["tb_caregiverlandline"].Trim();
            dd_coming = Request.Form["dd_coming"];
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
            cmd.Parameters.Add("@residentialaddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            cmd.Parameters.Add("@postaladdress", SqlDbType.VarChar).Value = tb_postaladdress;
            
            cmd.Parameters.Add("@facebook", SqlDbType.VarChar).Value = tb_facebook;
            cmd.Parameters.Add("@colour", SqlDbType.VarChar).Value = '#' + tb_colour;
            cmd.Parameters.Add("@feecategory", SqlDbType.VarChar).Value = dd_feecategory;
            cmd.Parameters.Add("@familymember", SqlDbType.VarChar).Value = dd_familymember;
            cmd.Parameters.Add("@rowit_id", SqlDbType.VarChar).Value = tb_rowit_id;
            cmd.Parameters.Add("@keynumber", SqlDbType.VarChar).Value = tb_keynumber;
            cmd.Parameters.Add("@onloanfromclub", SqlDbType.VarChar).Value = tb_onloanfromclub;
            cmd.Parameters.Add("@swimmer", SqlDbType.VarChar).Value = dd_swimmer;
            cmd.Parameters.Add("@relationshiponly", SqlDbType.VarChar).Value = dd_relationshiponly;


            /*
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = tb_email;
            cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = tb_mobile;
            cmd.Parameters.Add("@landline", SqlDbType.VarChar).Value = tb_landline;
            cmd.Parameters.Add("@caregivername", SqlDbType.VarChar).Value = tb_caregivername;
            cmd.Parameters.Add("@caregiveremail", SqlDbType.VarChar).Value = tb_caregiveremail;
            cmd.Parameters.Add("@caregivermobile", SqlDbType.VarChar).Value = tb_caregivermobile;
            cmd.Parameters.Add("@caregiverlandline", SqlDbType.VarChar).Value = tb_caregiverlandline;
            cmd.Parameters.Add("@coming", SqlDbType.VarChar).Value = dd_coming;
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
            if (returnto == "")
            {
                returnto = "list";
            }
            Response.Redirect(returnto + ".aspx");
        }
    }
}