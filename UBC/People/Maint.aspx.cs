﻿using System;
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
        public string hf_person_id = "";
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
        public string dd_rowingrole;
        public string dd_familymember;
        public string dd_lastseasonregistered;
        public string dd_school;
        public string tb_schoolyear;
        public string tb_schoolyearat;
        public string tb_facebook;
        public string tb_residentialaddress;
        public string tb_postaladdress;
        public string tb_colour;
        public string dd_swimmer;
        public string tb_rowit_id;
        public string tb_key;
        public string dd_keyactive;
        public string tb_onloanfromclub;
        public string dd_onloanfromclubactive;
        public string tb_uniform;
        public string dd_uniformactive;
        public string dd_relationshiponly;
        public string tb_invoicerecipient;
        public string dd_invoiceaddresstype;
        public string tb_invoiceaddress;
        public string tb_financialnote;
        public string tb_boatstorage;
        public string tb_boatstoragefee;
        public string tb_rowingnzid;
        public string dd_rowingnzseason;

        /*
        public string tb_caregivername;
        public string tb_caregiveremail;
        public string tb_caregivermobile;
        public string tb_caregiverlandline;
        public string dd_coming;
        public string tb_facebook;
        */
        public string tb_notes;

        public Dictionary<string, string> options = new Dictionary<string, string>();
        public Dictionary<string, string> nooptions = new Dictionary<string, string>();
        
        public string[] school = new string[3] { "City College", "Cullinane", "Girls College" };
        public string[] gender = new string[2] { "Female", "Male" };
        //public string[] feecategory = new string[6] { "Full", "Recreational", "Cox", "Novice", "Special", "N/A" };  //Have added a new table - not yet using
        //public Dictionary<string, string> feecategory = new Dictionary<string, string>();
        public string[,] feecategory;
        public string[] rowingrole = new string[4] { "Rower", "Novice Rower", "Cox", "N/A" };  
        public string[] yesno = new string[2] { "Yes", "No" };
        public string[] familymember = new string[5] { "1", "2", "3", "4", "5" };
        public string[] transactions_system = new string[2] { "UBC", "Friends" };
        public string[] transactions_code = new string[9] { "Regatta", "Boat Transport", "Accomodation", "Clothing", "Fees", "Race Fees", "Fundraising", "Grant Allocation", "Subsidy" };
        public string[] invoiceaddresstypes = new string[3] { "Email", "Mail", "Hand Deliver" }; //[4] { "Email", "Text", "Mail", "Hand Deliver" };
        public string[] seasons = new string[4] { "2017/18", "2018/19", "2019/20", "2020/21" };
        public string category_category;
        public string relationships_relationshiptypes;
        public string courses_courses;

        public string person_financial_events;

        public string html_tabs = "";
        public string html_email = "";
        public string html_system = "";
        public string html_transactions = "";
        public string html_registration = "";
        public string html_loginregister = "";
        public string html_tracker = "";
        public string html_attendance = "";
        public string html_phone = "";
        public string html_note = "";
        public string html_course = "";
        public string html_category = "";
        public string html_results = "";
        public string html_arrangements = "";
        public string html_relationships = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            returnto = Request.QueryString["returnto"] + "";

            if (!IsPostBack)
            {
                if (Session["UBC_person_id"] == null)
                {
                    //string url = "../search.aspx";
                    //Response.Redirect("~/people/security/login.aspx?return=" + url);
                    Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                    Response.Redirect("~/people/security/login.aspx");
                }

                hf_guid = Request.QueryString["id"] ?? "";
                if (hf_guid == "")
                {
                    Response.Redirect("search.aspx");
                }


                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                Generic.Functions gFunctions = new Generic.Functions();

                Dictionary<string, string> category_options = new Dictionary<string, string>();
                category_options["usevalues"] = "";
                category_options["selecttype"] = "Value";
                category_category = Functions.buildandpopulateselect(strConnString, "exec get_categories", "", category_options, "None");

                Dictionary<string, string> relationships_options = new Dictionary<string, string>();
                relationships_options["usevalues"] = "";
                relationships_options["selecttype"] = "Value";
                relationships_relationshiptypes = Functions.buildandpopulateselect(strConnString, "exec get_relationshiptypes", "", relationships_options, "None");

                Dictionary<string, string> courses_options = new Dictionary<string, string>();
                courses_options["usevalues"] = "";
                courses_options["selecttype"] = "Value";
                courses_courses = Functions.buildandpopulateselect(strConnString, "exec get_courses", "", courses_options, "None");

                feecategory = Functions.buildselectarray(strConnString, "get_feecategories");

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
                            tb_schoolyearat = dr["schoolyearat"].ToString();
                            tb_notes = dr["notes"].ToString();
                            tb_residentialaddress = dr["residentialaddress"].ToString();
                            tb_postaladdress = dr["postaladdress"].ToString();
                            tb_colour = dr["colour"].ToString();
                            dd_feecategory = dr["feecategory"].ToString();
                            dd_rowingrole = dr["rowingrole"].ToString();
                            dd_familymember = dr["familymember"].ToString();
                            dd_lastseasonregistered = dr["lastseasonregistered"].ToString();
                            dd_swimmer = dr["swimmer"].ToString();
                            tb_rowit_id = dr["rowit_id"].ToString();
                            tb_key = dr["key"].ToString();
                            dd_keyactive = dr["keyactive"].ToString();
                            tb_onloanfromclub = dr["onloanfromclub"].ToString();
                            dd_onloanfromclubactive = dr["onloanfromclubactive"].ToString();
                            tb_uniform = dr["uniform"].ToString();
                            dd_uniformactive = dr["uniformactive"].ToString();
                            dd_relationshiponly = dr["relationshiponly"].ToString();
                            tb_invoicerecipient = dr["InvoiceRecipient"].ToString();
                            dd_invoiceaddresstype = dr["InvoiceAddressType"].ToString();
                            tb_invoiceaddress = dr["InvoiceAddress"].ToString();
                            tb_financialnote = dr["financialnote"].ToString();
                            tb_boatstorage = dr["boatstorage"].ToString();
                            tb_boatstoragefee = dr["boatstoragefee"].ToString();
                            tb_rowingnzid = dr["rowingnzid"].ToString();
                            dd_rowingnzseason = dr["rowingnzseason"].ToString();



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
                            if (tb_boatstoragefee != "")
                            {
                                tb_boatstoragefee = Convert.ToDecimal(tb_boatstoragefee).ToString("0.00");
                            }
                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    html_tabs += "<li><a data-target=\"#div_phone\">Phone</a></li>";
                    html_tabs += "<li><a data-target=\"#div_address\">Address</a></li>";
                    html_tabs += "<li><a data-target=\"#div_email\">Email</a></li>";
                    html_tabs += "<li><a data-target=\"#div_relationships\">Relationships</a></li>";

                    if (dd_relationshiponly == "Yes")
                    {
                        if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                        {
                            html_tabs += "<li><a data-target=\"#div_tracker\">Tracker</a></li>";
                        }
                    }
                    else
                    {
                        html_tabs += "<li><a data-target=\"#div_general\">General</a></li>";
                        html_tabs += "<li><a data-target=\"#div_category\">Category</a></li>";
                        html_tabs += "<li><a data-target=\"#div_attendance\">Attendance</a></li>";
                        html_tabs += "<li><a data-target=\"#div_results\">Results</a></li>";
                        html_tabs += "<li><a data-target=\"#div_registration\">Registration</a></li>";

                        if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11001"))
                        {
                            html_tabs += "<li><a data-target=\"#div_finance\">Finance</a></li>";
                        }

                        if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "10001"))
                        {
                            html_tabs += "<li><a data-target=\"#div_transactions\">Transactions</a></li>";
                            html_tabs += "<li><a data-target=\"#div_arrangements\">Arrangements</a></li>";
                        }

                        if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                        {
                            html_tabs += "<li><a data-target=\"#div_system\">System</a></li>";
                            html_tabs += "<li><a data-target=\"#div_loginregister\">Logins</a></li>";
                            html_tabs += "<li><a data-target=\"#div_tracker\">Tracker</a></li>";
                        }
                    }
                    html_tabs += "<li><a data-target=\"#div_note\">Notes</a></li>";
                    html_tabs += "<li><a data-target=\"#div_onloan\">On Loan</a></li>";
                    html_tabs += "<li><a data-target=\"#div_course\">Courses</a></li>";



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
                            string enddatetime = dr["enddatetime"].ToString();
                            if (enddatetime != "")
                            {
                                enddatetime = Convert.ToDateTime(enddatetime).ToString("dd MMM yy hh:mm");
                            }
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
                    //TRANSACTIONS
                    if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "10001"))
                    {

                        html_transactions = "<thead>";
                        html_transactions += "<tr><th style=\"width:50px;text-align:center\"></th><th>Date</th><th>System</th><th>Code</th><th>Event</th><th style=\"text-align:right\">Amount</th><th>Note</th><th style=\"width:100px\">Action / <a class=\"transactionsedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                        html_transactions += "</thead>";
                        html_transactions += "<tbody>";

                        //hidden row, used for creating new rows client side
                        html_transactions += "<tr style=\"display:none\">";
                        html_transactions += "<td style=\"text-align:center\"></td>";
                        html_transactions += "<td></td>";
                        html_transactions += "<td></td>";
                        html_transactions += "<td></td>";
                        html_transactions += "<td></td>";
                        html_transactions += "<td style=\"text-align:right\"></td>";
                        html_transactions += "<td></td>";
                        //html_transactions += "<td>" + banked + "</td>";
                        html_transactions += "<td><a href=\"javascript:void(0)\" class=\"transactionsedit\" data-mode=\"edit\">Edit</td>";
                        //html_finance += "<td style=\"text-align:center\">').html(action) 
                        //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                        html_transactions += "</tr>";

                        double total = 0;

                        cmd.CommandText = "get_person_transactions";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                        double totalamount = 0;
                        try
                        {
                            SqlDataReader dr = cmd.ExecuteReader();
                            while (dr.Read())
                            {
                                string person_transaction_id = dr["person_transaction_id"].ToString();
                                string date = Convert.ToDateTime(dr["date"]).ToString("dd MMM yy");
                                string system = dr["system"].ToString();
                                string detail = dr["detail"].ToString();
                                double amount = Convert.ToDouble(dr["amount"]);
                                totalamount += amount;
                                string amountdisplay = amount.ToString("0.00");
                                string note = dr["note"].ToString();
                                string code = dr["code"].ToString();
                                string event_id = dr["event_id"].ToString();
                                string event_title = dr["event_title"].ToString();
                                string person_event_id = dr["person_event_id"].ToString();
                                /*
                                string banked = dr["banked"].ToString();
                                if (banked != "")
                                {
                                    banked = Convert.ToDateTime(banked).ToString("dd MMM yy");
                                }
                                */

                                total += Convert.ToDouble(amount);


                                html_transactions += "<tr id=\"transactions_" + person_transaction_id + "\">";
                                html_transactions += "<td style=\"text-align:center\"></td>";
                                html_transactions += "<td>" + date + "</td>";
                                html_transactions += "<td>" + system + "</td>";
                                html_transactions += "<td>" + code + "</td>";
                                html_transactions += "<td event_id=\"" + event_id + "\">" + event_title + "</td>";
                                html_transactions += "<td style=\"text-align:right\">" + amountdisplay + "</td>";
                                html_transactions += "<td>" + note + "</td>";
                                //html_transactions += "<td>" + banked + "</td>";
                                html_transactions += "<td><a href=\"javascript:void(0)\" class=\"transactionsedit\" data-mode=\"edit\">Edit</td>";
                                //html_finance += "<td style=\"text-align:center\">').html(action) 
                                //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                                html_transactions += "</tr>";


                            }
                            dr.Close();
                            string Cr = "";
                            if (totalamount > 0)
                            {
                                Cr = "Cr";
                            }
                            html_transactions += "<tr><td colspan=\"6\" style=\"text-align:right\"><b>" + totalamount.ToString("0.00") + Cr + "</b></td><td colspan\"2\"></td></tr>";
                            html_transactions += "</tbody>";

                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        //-------------------------------------------------------------------------------------
                        html_arrangements = "TO DO";
                    }


                    //-------------------------------------------------------------------------------------
                    //RELATIONSHIPS
                    //if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
                    //{

                    html_relationships = "<thead>";
                    //html_relationships += "<tr><th>Relationship</th><th>Person</th><th>Status</th><th>Note</th><th style=\"width:100px\">Action / <a class=\"relationshipsedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_relationships += "<tr><th style=\"width:50px;text-align:center\"></th><th>Relationship</th><th>Person</th><th>Note</th><th style=\"width:100px\">Action / <a class=\"relationshipsedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_relationships += "</thead>";
                    html_relationships += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_relationships += "<tr style=\"display:none\">";
                    html_relationships += "<td style=\"text-align:center\"></td>";
                    html_relationships += "<td></td>";
                    html_relationships += "<td></td>";
                    html_relationships += "<td></td>";
                    html_relationships += "<td><a href=\"javascript:void(0)\" class=\"relationshipsedit\" data-mode=\"edit\">Edit</td>";
                    html_relationships += "</tr>";

                    cmd.CommandText = "get_person_relationships";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string relationship_id = dr["relationship_id"].ToString();
                            string person_guid = dr["person_guid"].ToString();
                            string person_id = dr["person_id"].ToString();
                            string person = dr["person"].ToString();
                            string relationshiptype_id = dr["Relationshiptype_id"].ToString();
                            string relationshiptype = dr["Relationshiptype"].ToString();
                            //string status = dr["status"].ToString();
                            string note = dr["note"].ToString();
                            //string PrimaryRecordat = dr["PrimaryRecordat"].ToString();

                            html_relationships += "<tr id=\"relationships_" + relationship_id + "\">";
                            html_relationships += "<td style=\"text-align:center\"></td>";
                            html_relationships += "<td relationshiptype_id=\"" + relationshiptype_id + "\"> is the " + relationshiptype + " of</td>";
                            html_relationships += "<td relationshipperson_id=\"" + person_id + "\"><a href=\"maint.aspx?id=" + person_guid + "\">" + person + "</a></td>";
                            //html_relationships += "<td>" + status + "</td>";
                            html_relationships += "<td>" + note + "</td>";
                            html_relationships += "<td><a href=\"javascript:void(0)\" class=\"relationshipsedit\" data-mode=\"edit\">Edit</td>";
                            //html_relationships += "<td style=\"text-align:center\">').html(action) 
                            //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                            html_relationships += "</tr>";

                        }
                        dr.Close();
                        html_relationships += "</tbody>";

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    //}

                    //-------------------------------------------------------------------------------------
                    //REGISTRATION
                    html_registration = "<tr><th>Season</th><th>Submitted</th><th>Status</th><th>Status<br />Date</th><th>Status<br />Person</th><th>View</th></tr>";

                    cmd.CommandText = "get_person_registration";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    string edit = "";
                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {

                            string registration_id = dr["registration_id"].ToString();
                            string CreatedDate = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yy");
                            string season = dr["season"].ToString();
                            string Status = dr["Status"].ToString();
                            string StatusUpdatedDateTime = dr["StatusUpdatedDateTime"].ToString();
                            string StatusUpdatedperson = dr["StatusUpdatedperson"].ToString();
                            if (StatusUpdatedDateTime != "")
                            {
                                StatusUpdatedDateTime = Convert.ToDateTime(StatusUpdatedDateTime).ToString("dd MMM yy");
                            }
                            if (edit == "")
                            {
                                edit = "<a href=\"javascript:void(0)\" class=\"registrationedit\" id=\"registeredit_" + registration_id + "\">";
                            }
                            html_registration += "<tr>";
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
                    //NOTES
                    //if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                    //{
                    html_note = "<thead>";

                    html_note += "<tr><th style=\"width:50px;text-align:center\"></th><th>Date/Time</th><th>Made By</th><th>Note</th><th>Followup</th><th>Followup Done</th><th style=\"width:100px\">Action / <a class=\"noteedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_note += "</thead>";
                    html_note += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_note += "<tr style=\"display:none\">";
                    html_note += "<td style=\"text-align:center\"></td>";
                    html_note += "<td></td>";
                    html_note += "<td></td>";
                    html_note += "<td></td>";
                    html_note += "<td></td>";
                    html_note += "<td></td>";
                    html_note += "<td><a href=\"javascript:void(0)\" class=\"noteedit\" data-mode=\"edit\">Edit</td>";
                    html_note += "</tr>";
                    cmd.CommandText = "get_person_note";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string person_note_id = dr["Person_note_ID"].ToString();
                            string DateTime = Convert.ToDateTime(dr["DateTime"]).ToString("dd MMM yyyy HH:mm");
                            string Made_By_Person_Name = dr["Made_By_Person_Name"].ToString();
                            string Note = dr["Note"].ToString();
                            string followupDate = dr["followupDate"].ToString();
                            if(followupDate != "")
                            {
                                followupDate = Convert.ToDateTime(followupDate).ToString("dd MMM yyyy");
                            }
                            string FollowupActioned = dr["FollowupActioned"].ToString();

                            html_note += "<tr id=\"note_" + person_note_id + "\">";
                            html_note += "<td style=\"text-align:center\"></td>";
                            html_note += "<td>" + DateTime + "</td>";
                            html_note += "<td>" + Made_By_Person_Name + "</td>";
                            html_note += "<td>" + Note + "</td>";
                            html_note += "<td>" + followupDate + "</td>";
                            html_note += "<td>" + FollowupActioned + "</td>";
                            html_note += "<td><a href=\"javascript:void(0)\" class=\"noteedit\" data-mode=\"edit\">Edit</td>";
                            html_note += "</tr>";

                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    //}
                    //-------------------------------------------------------------------------------------
                    //COURSES
                    //if (Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1"))
                    //{
                    html_course = "<thead>";

                    html_course += "<tr><th style=\"width:50px;text-align:center\"></th><th>Course</th><th>Start Date</th><th>End Date</th><th>Note</th><th>Followup</th><th>Followup Actioned</th><th style=\"width:100px\">Action / <a class=\"courseedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_course += "</thead>";
                    html_course += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_course += "<tr style=\"display:none\">";
                    html_course += "<td style=\"text-align:center\"></td>";
                    html_course += "<td></td>";
                    html_course += "<td></td>";
                    html_course += "<td></td>";
                    html_course += "<td></td>";
                    html_course += "<td></td>";
                    html_course += "<td></td>";
                    html_course += "<td><a href=\"javascript:void(0)\" class=\"courseedit\" data-mode=\"edit\">Edit</td>";
                    html_course += "</tr>";
                    cmd.CommandText = "get_person_courses";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

                    
                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string person_course_id = dr["Person_course_ID"].ToString();
                            string CourseID = dr["Course_ID"].ToString();
                            string Course = dr["Course"].ToString();
                            string StartDate = Convert.ToDateTime(dr["StartDate"]).ToString("dd MMM yyyy");
                            string EndDate = Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM yyyy");
                            string note = dr["note"].ToString();
                            string followupDate = gFunctions.formatdate(dr["followupDate"].ToString(),"dd MMM yyyy");
                            string followupActionedDate = gFunctions.formatdate(dr["followupActionedDate"].ToString(), "dd MMM yyyy");
                            
                            html_course += "<tr id=\"course_" + person_course_id + "\">";
                            html_course += "<td style=\"text-align:center\"></td>";
                            html_course += "<td course_id=\"" + CourseID + "\">" + Course + "</td>";
                            html_course += "<td>" + StartDate + "</td>";
                            html_course += "<td>" + EndDate + "</td>";
                            html_course += "<td>" + note + "</td>";
                            html_course += "<td>" + followupDate + "</td>";
                            html_course += "<td>" + followupActionedDate + "</td>";
                            html_course += "<td><a href=\"javascript:void(0)\" class=\"courseedit\" data-mode=\"edit\">Edit</td>";
                            html_course += "</tr>";

                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                  
                    //}




                    //------------------------------------PHONE-------------------------------------------------
                    html_phone = "<thead>";

                    html_phone += "<tr><th style=\"width:50px;text-align:center\"></th><th>Number</th><th>Mobile</th><th>Send Texts</th><th>Note</th><th>Send Now</th><th style=\"width:100px\">Action / <a class=\"phoneedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_phone += "</thead>";
                    html_phone += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_phone += "<tr style=\"display:none\">";
                    html_phone += "<td style=\"text-align:center\"></td>";
                    html_phone += "<td></td>";
                    html_phone += "<td></td>";
                    html_phone += "<td></td>";
                    html_phone += "<td></td>";
                    html_phone += "<td></td>";
                    html_phone += "<td><a href=\"javascript:void(0)\" class=\"phoneedit\" data-mode=\"edit\">Edit</td>";
                    html_phone += "</tr>";

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
                            if (phone != "")
                            {
                                phone = "<a href=\"tel:" + phone + "\">" + phone + "</>";
                            }

                            html_phone += "<tr id=\"phone_" + person_phone_id + "\">";
                            html_phone += "<td style=\"text-align:center\"></td>";
                            html_phone += "<td>" + phone + "</td>";
                            html_phone += "<td>" + mobile + "</td>";
                            html_phone += "<td>" + text + "</td>";
                            html_phone += "<td>" + note + "</td>";
                            html_phone += "<td>" + send + "</td>";
                            html_phone += "<td><a href=\"javascript:void(0)\" class=\"phoneedit\" data-mode=\"edit\">Edit</td>";
                            html_phone += "</tr>";


                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    html_phone += "</tbody>";


                    //-------------------------------------------------------------------------------------
                    html_email = "<thead>";
                    html_email += "<tr><th style=\"width:50px;text-align:center\"></th><th>Email</th><th>Note</th><th>System Send</th><th>Local Send</th><th style=\"width:100px\">Action / <a class=\"emailedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_email += "</thead>";
                    html_email += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_email += "<tr style=\"display:none\">";
                    html_email += "<td style=\"text-align:center\"></td>";
                    html_email += "<td></td>";
                    html_email += "<td></td>";
                    html_email += "<td></td>";
                    html_email += "<td></td>";
                    html_email += "<td><a href=\"javascript:void(0)\" class=\"emailedit\" data-mode=\"edit\">Edit</td>";
                    html_email += "</tr>";

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

                            html_email += "<tr id=\"email_" + person_email_id + "\">";
                            html_email += "<td style=\"text-align:center\"></td>";
                            html_email += "<td>" + email + "</td>";
                            html_email += "<td>" + note + "</td>";
                            html_email += "<td>" + sendsystem + "</td>";
                            html_email += "<td>" + sendlocal + "</td>";
                            html_email += "<td><a href=\"javascript:void(0)\" class=\"emailedit\" data-mode=\"edit\">Edit</td>";
                            html_email += "</tr>";


                        }
                        dr.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    //-------------------------------------------------------------------------------------
                    //CATEGORY

                    html_category = "<thead>";
                    html_category += "<tr><th style=\"width:50px;text-align:center\"></th><th>Category</th><th>Start</th><th>End</th><th>Notes</th><th style=\"width:100px\">Action / <a class=\"categoryedit\" data-mode=\"add\" href=\"javascript: void(0)\">Add</a></th></tr>";
                    html_category += "</thead>";
                    html_category += "<tbody>";

                    //hidden row, used for creating new rows client side
                    html_category += "<tr style=\"display:none\">";
                    html_category += "<td></td>";
                    html_category += "<td></td>";
                    html_category += "<td></td>";
                    html_category += "<td></td>";
                    html_category += "<td></td>";
                    html_category += "<td><a href=\"javascript:void(0)\" class=\"categoryedit\" data-mode=\"edit\">Edit</td>";
                    html_category += "</tr>";


                    cmd.CommandText = "get_person_category";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;
                    cmd.Parameters.Add("@onlycurrent", SqlDbType.VarChar).Value = "No";

                    try
                    {
                        SqlDataReader dr = cmd.ExecuteReader();
                        while (dr.Read())
                        {
                            string person_category_id = dr["person_category_id"].ToString();
                            string category_id = dr["category_id"].ToString();
                            string category = dr["category"].ToString();
                            string current = dr["current"].ToString();
                            string currentcategory = "";
                            if (current == "0")
                            {
                                currentcategory = " class=\"notcurrentcategory\"";
                            }

                            string startdate = dr["startdate"].ToString();
                            if (startdate != "")
                            {
                                startdate = Convert.ToDateTime(startdate).ToString("dd MMM yy");
                            }
                            string enddate = dr["enddate"].ToString();
                            if (enddate != "")
                            {
                                enddate = Convert.ToDateTime(enddate).ToString("dd MMM yy");
                            }

                            string note = dr["note"].ToString();

                            html_category += "<tr" + currentcategory + " id=\"category_" + person_category_id + "\">";
                            html_category += "<td style=\"text-align:center\"></td>";
                            html_category += "<td category_id=\"" + category_id + "\">" + category + "</td>";
                            html_category += "<td>" + startdate + "</td>";
                            html_category += "<td>" + enddate + "</td>";
                            html_category += "<td>" + note + "</td>";
                            html_category += "<td><a href=\"javascript:void(0)\" class=\"categoryedit\" data-mode=\"edit\">Edit</td>";
                            //html_finance += "<td style=\"text-align:center\">').html(action) 
                            //action = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                            html_category += "</tr>";


                        }
                        dr.Close();
                        html_category += "</tbody>";

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    /*
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
                    */
                    //-------------------------------------------------------------------------------------

                    con.Close();
                    con.Dispose();

                    if (hf_person_id != "")
                    {
                        Functions genericfunctions = new Functions();
                        Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                        functionoptions.Clear();
                        functionoptions.Add("storedprocedure", "");
                        functionoptions.Add("storedprocedurename", "");
                        functionoptions.Add("parameters", hf_person_id);
                        functionoptions.Add("usevalues", "");
                        //person_financial_events = genericfunctions.buildandpopulateselect(strConnString, "get_person_financial_events", "", functionoptions, "None");
                        person_financial_events = Functions.buildandpopulateselect(strConnString, "get_person_financial_events", "", functionoptions, "None");
                    }
                }


            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            /*
            foreach(string name in Request.Form)
            {
                string x = name;
            }
            */


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
            tb_schoolyearat = Request.Form["tb_schoolyearat"].Trim();
            tb_notes = Request.Form["tb_notes"];
            tb_dietry = Request.Form["tb_dietry"].Trim();
            tb_medical = Request.Form["tb_medical"].Trim();
            tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_colour = Request.Form["tb_colour"].Trim();
            tb_facebook = Request.Form["tb_facebook"].Trim();
            dd_feecategory = Request.Form["dd_feecategory"].Trim();
            dd_rowingrole = Request.Form["dd_rowingrole"].Trim();
            dd_familymember = Request.Form["dd_familymember"].Trim();
            dd_lastseasonregistered = Request.Form["dd_lastseasonregistered"].Trim();

            tb_rowit_id = Request.Form["tb_rowit_id"].Trim();
            tb_key = Request.Form["tb_key"].Trim();
            dd_keyactive = Request.Form["dd_keyactive"].Trim();
            tb_onloanfromclub = Request.Form["tb_onloanfromclub"].Trim();
            dd_onloanfromclubactive = Request.Form["dd_onloanfromclubactive"].Trim();
            tb_uniform = Request.Form["tb_uniform"].Trim();
            dd_uniformactive = Request.Form["dd_uniformactive"].Trim();
            dd_swimmer = Request.Form["dd_swimmer"].Trim();
            dd_relationshiponly = Request.Form["dd_relationshiponly"].Trim();
            tb_invoicerecipient = Request.Form["tb_invoicerecipient"].Trim();
            dd_invoiceaddresstype = Request.Form["dd_invoiceaddresstype"].Trim();
            tb_invoiceaddress = Request.Form["tb_invoiceaddress"].Trim();
            tb_financialnote = Request.Form["tb_financialnote"].Trim();

            tb_rowingnzid = Request.Form["tb_rowingnzid"].Trim();
            dd_rowingnzseason = Request.Form["dd_rowingnzseason"].Trim();
            tb_boatstorage = Request.Form["tb_boatstorage"].Trim();
            tb_boatstoragefee = Request.Form["tb_boatstoragefee"].Trim();

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
            string result = "";
            cmd.CommandText = "Update_Person";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@knownas", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@birthdate", SqlDbType.VarChar).Value = tb_birthdate;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = dd_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = tb_schoolyear;
            cmd.Parameters.Add("@schoolyearat", SqlDbType.VarChar).Value = tb_schoolyearat;
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
            cmd.Parameters.Add("@lastseasonregistered", SqlDbType.VarChar).Value = dd_lastseasonregistered;
            cmd.Parameters.Add("@rowit_id", SqlDbType.VarChar).Value = tb_rowit_id;
            cmd.Parameters.Add("@key", SqlDbType.VarChar).Value = tb_key;
            cmd.Parameters.Add("@keyactive", SqlDbType.VarChar).Value = dd_keyactive;
            cmd.Parameters.Add("@onloanfromclub", SqlDbType.VarChar).Value = tb_onloanfromclub;
            cmd.Parameters.Add("@onloanfromclubactive", SqlDbType.VarChar).Value = dd_onloanfromclubactive;
            cmd.Parameters.Add("@uniform", SqlDbType.VarChar).Value = tb_uniform;
            cmd.Parameters.Add("@uniformactive", SqlDbType.VarChar).Value = dd_uniformactive;
            cmd.Parameters.Add("@swimmer", SqlDbType.VarChar).Value = dd_swimmer;
            cmd.Parameters.Add("@relationshiponly", SqlDbType.VarChar).Value = dd_relationshiponly;
            cmd.Parameters.Add("@InvoiceRecipient", SqlDbType.VarChar).Value = tb_invoicerecipient;
            cmd.Parameters.Add("@InvoiceAddressType", SqlDbType.VarChar).Value = dd_invoiceaddresstype;
            cmd.Parameters.Add("@InvoiceAddress", SqlDbType.VarChar).Value = tb_invoiceaddress;
            cmd.Parameters.Add("@financialnote", SqlDbType.VarChar).Value = tb_financialnote;
            cmd.Parameters.Add("@rowingnzid", SqlDbType.VarChar).Value = tb_rowingnzid;
            cmd.Parameters.Add("@rowingnzseason", SqlDbType.VarChar).Value = dd_rowingnzseason;
            cmd.Parameters.Add("@boatstorage", SqlDbType.VarChar).Value = tb_boatstorage;
            cmd.Parameters.Add("@boatstoragefee", SqlDbType.VarChar).Value = tb_boatstoragefee;
            cmd.Parameters.Add("@rowingrole", SqlDbType.VarChar).Value = dd_rowingrole;


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
            //try
            //{
            con.Open();
            result = cmd.ExecuteScalar().ToString();
            con.Close();
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

            foreach (string key in Request.Form)
            {
                if (key.StartsWith("transactions_"))
                {
                    string person_transaction_id = key.Substring(13);
                    if (person_transaction_id.StartsWith("new"))
                    {
                        person_transaction_id = "new";
                    }

                    string[] valuesSplit = Request.Form[key].Split('\x00FE');
                    cmd.CommandText = "Update_Person_Transaction";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@person_transaction_id", SqlDbType.VarChar).Value = person_transaction_id;
                    cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                    cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = valuesSplit[0];
                    cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = valuesSplit[4];
                    cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[5];
                    cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = valuesSplit[1];
                    cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = "";
                    cmd.Parameters.Add("@code", SqlDbType.VarChar).Value = valuesSplit[2];
                    //cmd.Parameters.Add("@banked", SqlDbType.VarChar).Value = valuesSplit[6];
                    cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = valuesSplit[3];

                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                }

                if (key.StartsWith("category_"))
                {
                    string person_category_id = key.Substring(9);
                    if (person_category_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_Person_category";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_category_id", SqlDbType.VarChar).Value = person_category_id.Substring(0, person_category_id.Length - 7);
                    }
                    else
                    {
                        if (person_category_id.StartsWith("new"))
                        {
                            person_category_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_Person_category";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_category_id", SqlDbType.VarChar).Value = person_category_id;
                        cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@category_id", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@startdate", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@enddate", SqlDbType.VarChar).Value = valuesSplit[2];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[3];
                    }
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                }

                if (key.StartsWith("note_"))
                {

                    string person_note_id = key.Substring(5);

                    if (person_note_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_Person_note";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_note_id", SqlDbType.VarChar).Value = person_note_id.Substring(0, person_note_id.Length - 7);
                    }
                    else
                    {
                        if (person_note_id.StartsWith("new"))
                        {
                            person_note_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_Person_note";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_note_id", SqlDbType.VarChar).Value = person_note_id;
                        cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@made_by_person_id", SqlDbType.VarChar).Value = Session["UBC_person_id"].ToString();
                        cmd.Parameters.Add("@datetime", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@followupdate", SqlDbType.VarChar).Value = valuesSplit[2];
                        cmd.Parameters.Add("@followupactioned", SqlDbType.VarChar).Value = valuesSplit[3];
                    }
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();

                }

                if (key.StartsWith("phone_"))
                {
                    string person_phone_id = key.Substring(6);
                    if (person_phone_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_Person_phone";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_phone_id", SqlDbType.VarChar).Value = person_phone_id.Substring(0, person_phone_id.Length - 7);
                    }
                    else
                    {
                        if (person_phone_id.StartsWith("new"))
                        {
                            person_phone_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_Person_phone";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_phone_id", SqlDbType.VarChar).Value = person_phone_id;
                        cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@text", SqlDbType.VarChar).Value = valuesSplit[2];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[3];
                    }
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                }

                if (key.StartsWith("email_"))
                {
                    string person_email_id = key.Substring(6);
                    if (person_email_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_Person_email";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_email_id", SqlDbType.VarChar).Value = person_email_id.Substring(0, person_email_id.Length - 7);
                    }
                    else
                    {
                        if (person_email_id.StartsWith("new"))
                        {
                            person_email_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_Person_email";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_email_id", SqlDbType.VarChar).Value = person_email_id;
                        cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[1];
                    }
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                }

                if (key.StartsWith("relationships_"))
                {
                    string relationship_id = key.Substring(14);
                    if (relationship_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_relationship";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@relationship_id", SqlDbType.VarChar).Value = relationship_id.Substring(0, relationship_id.Length - 7);
                    }
                    else
                    {
                        if (relationship_id.StartsWith("new"))
                        {
                            relationship_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_relationship";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@relationship_id", SqlDbType.VarChar).Value = relationship_id;
                        cmd.Parameters.Add("@relationshiptype_id", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@person1_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@person2_id", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[2];
                    }
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                }

                if (key.StartsWith("course_"))
                {
                    string person_course_id = key.Substring(7);
                    if (person_course_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_Person_course";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_course_id", SqlDbType.VarChar).Value = person_course_id.Substring(0, person_course_id.Length - 7);
                    }
                    else
                    {
                        if (person_course_id.StartsWith("new"))
                        {
                            person_course_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_Person_course";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@person_course_id", SqlDbType.VarChar).Value = person_course_id;
                        cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = hf_guid;
                        cmd.Parameters.Add("@course_id", SqlDbType.VarChar).Value = valuesSplit[0];
                        cmd.Parameters.Add("@startdate", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@enddate", SqlDbType.VarChar).Value = valuesSplit[2];
                        cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = valuesSplit[3];
                        cmd.Parameters.Add("@followupdate", SqlDbType.VarChar).Value = valuesSplit[4];
                        cmd.Parameters.Add("@followupactioneddate", SqlDbType.VarChar).Value = valuesSplit[5];

                    }
                    
                    con.Open();
                    result = cmd.ExecuteScalar().ToString();
                    con.Close();
                    
                }

            }
            //finally
            //{

            con.Dispose();
            //}

            if (hf_guid == "new")
            {
                returnto = "maint.aspx?id=" + result;
            }
        
            else
            {
                if (returnto == "")
                {
                    returnto = "search";
                }
            }
         

            Response.Redirect(returnto + ".aspx");
        }
    }
}