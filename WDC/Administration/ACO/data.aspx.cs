using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MarkupConverter;

namespace Online.Administration.ACO
{
    public partial class dataform : System.Web.UI.Page
    {
        public string result = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string html = "";

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            //string strConnString = "Data Source=192.168.0.204;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            string strConnString = "Data Source=192.168.0.207;Initial Catalog=ACO;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            WDCFunctions.WDCFunctions wdcfunction = new WDCFunctions.WDCFunctions();
            string mode = Request.QueryString["mode"];

            if (mode == "full")
            {
                SqlCommand cmd = new SqlCommand("ACO_FullSearch", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@tagnumber", SqlDbType.VarChar).Value = Request.QueryString["tagnumber"];
                cmd.Parameters.Add("@tagyear", SqlDbType.VarChar).Value = Request.QueryString["tagyear"];
                cmd.Parameters.Add("@street", SqlDbType.VarChar).Value = Request.QueryString["street"];
                cmd.Parameters.Add("@animalname", SqlDbType.VarChar).Value = Request.QueryString["animalname"];
                cmd.Parameters.Add("@ownername", SqlDbType.VarChar).Value = Request.QueryString["ownername"];
                cmd.Parameters.Add("@chipnumber", SqlDbType.VarChar).Value = Request.QueryString["chipnumber"];
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = Request.QueryString["id"];
                cmd.Parameters.Add("@colour", SqlDbType.VarChar).Value = Request.QueryString["colour"];
                cmd.Parameters.Add("@breed", SqlDbType.VarChar).Value = Request.QueryString["breed"];

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        html = "<hr />";
                        html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Animal</th><th>Address</th><th>Owner</th></tr></thead>";

                        while (dr.Read())
                        {
                            string animal_ctr = dr["animal_ctr"].ToString();
                            string colour_desc = dr["colour_desc"].ToString();
                            string gender = dr["gender"].ToString();
                            string breed_desc = dr["breed_desc"].ToString();
                            string name = dr["name"].ToString();
                            string Address = dr["Address"].ToString();
                            string Owner = dr["Owner"].ToString();
                            string Phone = dr["Phone"].ToString();

                            html += "<tr class=\"tr_pick\" id=\"dog_" + animal_ctr + "\">";
                            html += "<td>" + name + " - " + colour_desc + " " + gender + " " + breed_desc +  "</td>";
                            html += "<td>" + Address + "</td>";
                            html += "<td>" + Owner + "<br />Ph:" + Phone + "</td>";
                            html += "</tr>";
                        }
                        html += "</table>";

                    }
                    else
                    {
                        html = "There are no records for this.";
                    }
                    result = html;
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
            else
            {


                SqlCommand cmd = new SqlCommand("ACO_Search", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;

                switch (mode)
                {
                    case "tag":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        cmd.Parameters.Add("@param2", SqlDbType.VarChar).Value = Request.QueryString["param2"];
                        break;
                    case "street":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "animal":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "horse":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "chip":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "history":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "poundhistory":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "owner":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "property":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                    case "animalname":
                        cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = Request.QueryString["param1"];
                        break;
                }



                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();
                        string displaymode = dr["displaymode"].ToString();

                        switch (displaymode)
                        {
                            case "Streets":
                                html = "<hr />";
                                html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Address</th><th>Tag</th><th>Breed</th><th>Colour</th></tr></thead>";
                                do
                                {
                                    html += "<tr>";
                                    html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + dr["Address"] + "</a></td>";
                                    html += "<td>" + dr["licence"] + "</td>";
                                    html += "<td>" + dr["breed_desc"] + "</td>";
                                    html += "<td>" + dr["colour_desc"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html = html + "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "AnimalName":
                                html = "<hr />";
                                html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Breed</th><th>Colour</th><th>Address</th><th>Tag</th></tr></thead>";
                                do
                                {
                                    html += "<tr>";
                                    html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + dr["breed_desc"] + "</a></td>";
                                    html += "<td>" + dr["colour_desc"] + "</td>";
                                    html += "<td>" + dr["Address"] + "</td>";
                                    html += "<td>" + dr["licence"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html = html + "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Licences":
                                html = "<hr />";
                                html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Tag</th><th>Address</th><th>Breed</th><th>Colour</th></tr></thead>";
                                do
                                {
                                    html += "<tr>";
                                    html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + dr["licence_no"] + "</a></td>";
                                    html += "<td>" + dr["Address"] + "</td>";
                                    html += "<td>" + dr["breed_desc"] + "</td>";
                                    html += "<td>" + dr["colour_desc"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html = html + "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Animal":
                                string desexed = "";
                                string gender = "";
                                string previous = "";
                                string phonenumber = "";

                                html = "<hr />";
                                html += dr["animal_ctr"] + "<br>";
                                html += dr["name"] + "<br>";
                                html += dr["breed_desc"] + "<br>";
                                if (dr["desexed"].ToString() == "Y")
                                {
                                    desexed = "desexed ";
                                }
                                else
                                {
                                    desexed = "";
                                }

                                switch (dr["gender"].ToString())
                                {
                                    case "F":
                                        gender = "female";
                                        break;
                                    case "M":
                                        gender = "male";
                                        break;
                                    default:
                                        gender = "of unknown gender";
                                        break;
                                }
                                html += dr["colour_desc"] + " " + desexed + gender + "<br>";

                                html += dr["age"] + " " + dr["class"] + "<br>";

                                if (dr["chip"] + "" != "")
                                {
                                    //html += "<img src=\"chip.jpg\"> " + dr["chip"] + "<br>";
                                    html += dr["chip"] + "<br>";
                                }

                                string previous_licence = dr["previous_licence"].ToString();
                                if (previous_licence != ", ")
                                {
                                    //if (right(dr["previous_licence"], 2) = ", ")
                                    if (previous_licence.Substring(previous_licence.Length - 2) == ", ")
                                    {
                                        //previous = " (" + left(dr["previous_licence"], len(dr["previous_licence"]) - 2) + ")";
                                        previous = " (" + previous_licence.Substring(previous_licence.Length - 2) + ")";
                                    }
                                    else
                                    {
                                        previous = " (" + dr["previous_licence"] + ")";
                                    }
                                }
                                {
                                    previous = "";
                                }
                                html += dr["licence"] + previous + "<br>";

                                if (dr["property_ctr"].ToString() != "")
                                {
                                    html += dr["address"];

                                    if (Convert.ToInt16(dr["OtherAnimalsonProperty"].ToString()) > 1)
                                    {
                                        //html += " <a href=\"search.asp?property=" + dr["property_ctr"] + "\">Others</a>";
                                        html += " <a href=\"javascript:void(0)\" data-type=\"property\" data-id=\"" + dr["property_ctr"] + "\" class=\"a_others\">Others</a>";

                                    }

                                }
                                if (dr["owner_ctr"].ToString() != "")
                                {
                                    html += "<br /><hr>";

                                    RegexOptions options = RegexOptions.None;
                                    Regex regex = new Regex("[ ]{2,}", options);
                                    html += regex.Replace(dr["title"] + " " + dr["given"] + " " + dr["surname"], " ").Trim();

                                    if (Convert.ToInt16(dr["OtherAnimalsforOwner"].ToString()) > 1)
                                    {
                                        //html += " <a href=\"search.asp?owner=" + dr["owner_ctr"] + "\">Others</a>";
                                        html += " <a href=\"javascript:void(0)\" data-type=\"owner\" data-id=\"" + dr["owner_ctr"] + "\" class=\"a_others\">Others</a>";

                                    }
                                    html += "<br>";
                                    phonenumber = wdcfunction.PRPhoneFormat(dr["homephone"].ToString());
                                    if (phonenumber != "")
                                    {
                                        html += "Home: " + phonenumber + "<br>";
                                    }
                                    phonenumber = wdcfunction.PRPhoneFormat(dr["workphone"].ToString());

                                    if (phonenumber != "")
                                    {
                                        html += "Work: " + phonenumber + "<br>";
                                    }
                                    phonenumber = wdcfunction.PRPhoneFormat(dr["mobilephone"].ToString());

                                    if (phonenumber != "")
                                    {
                                        html += "Mobile: " + phonenumber + "<br>";
                                    }
                                }
                                string delim = "";
                                string divs = "";
                                if (Convert.ToInt16(dr["history"].ToString()) > 0)
                                {
                                    html += "<a href=\"javascript:void(0)\" class=\"a_history\" data-id=\"" + dr["animal_ctr"] + "\">History</a>";
                                    divs += "<div id=\"div_history\" style=\"text-align:center;display:none\"></div>";
                                    delim = " | ";
                                }
                                if (Convert.ToInt16(dr["poundhistory"].ToString()) > 0)
                                {
                                    html += delim + "<a href=\"javascript:void(0)\" class=\"a_poundhistory\" data-id=\"" + dr["animal_ctr"] + "\">Pound</a>";
                                    divs += "<div id=\"div_poundhistory\" style=\"text-align:center;display:none\"></div>";
                                }
                                html += divs;
                                html += "<br /><hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Pound":

                                html = "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Name</th><th>Entry Date</th><th>Main Breed</th><th>Colour</th><th>Age</th><th>Gender</th><th>Chip</th><th>Found</th><th>Kennel</th></tr></thead>";
                                do
                                {

                                    html += "<tr>";
                                    string animalName = wdcfunction.isNull(dr["animal_ctr"].ToString(), "No Name");
                                    if (wdcfunction.isNull(dr["animal_ctr"].ToString(), "") != "")
                                    {
                                        html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + animalName + "</a></td>";

                                    }
                                    else
                                    {
                                        html += "<td>" + animalName + "</td>";

                                    }
                                    DateTime EntryDate;
                                    if (DateTime.TryParse(dr["FormattedDate"].ToString(), out EntryDate))
                                    {
                                        EntryDate = Convert.ToDateTime(dr["FormattedDate"].ToString());
                                        html += "<td>" + EntryDate.ToString("ddd dd/MM/yy") + "</td>";
                                    }
                                    else
                                    {
                                        html += "<td></td>";
                                    }
                                    html += "<td>" + dr["MainBreed"] + "</td>";
                                    html += "<td>" + dr["Colour"] + "</td>";
                                    html += "<td>" + dr["Age"] + "</td>";
                                    html += "<td>" + dr["Gender"] + "</td>";
                                    html += "<td>" + dr["ChipNumber"] + "</td>";
                                    html += "<td>" + dr["Found"] + "</td>";
                                    html += "<td>" + dr["KennelNumber"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html += "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Horse Register":
                                //< a href = ""horse.asp? id = " & rs("register_number") & """ > " & rs("HORSE_NAME") & " - " & rs("COLOUR") & " " & rs("AGE") & " year old, " & rs("height") & " hand high " & rs("Breed") & " " & rs("Horse_type") & " </ a >< br > "

                                //html = "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Name</th><th>Coloure</th><th>Age</th><th>Height</th><th>Breed</th><th>Type</th></tr></thead>";
                                html = "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Name</th><th>Colour</th><th>Breed</th><th>Type</th><th>Kept at</th></tr></thead>";
                                do
                                {

                                    html += "<tr>";
                                    string horseName = wdcfunction.isNull(dr["HORSE_NAME"].ToString(), "No Name");
                                    if (horseName != "No Name")
                                    {
                                        html += "<td><a href=\"javascript:void(0)\" class=\"a_horse\" data-id=\"" + dr["register_number"] + "\">" + horseName + "</a></td>";

                                    }
                                    else
                                    {
                                        html += "<td>" + horseName + "</td>";

                                    }

                                    html += "<td>" + dr["COLOUR"] + "</td>";
                                    //html += "<td>" + dr["AGE"] + "</td>";
                                    //html += "<td>" + dr["height"] + "</td>";
                                    html += "<td>" + dr["Breed"] + "</td>";
                                    html += "<td>" + dr["Horse_type"] + "</td>";
                                    html += "<td>" + dr["Kept_at_details"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html += "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Horse":

                                html = "<table>";

                                html += "<tr><td>ID</td><td>" + dr["register_number"] + "</td></tr>";
                                html += "<tr><td>Owner</td><td>" + dr["OWNER_NAME"] + "</td></tr>";
                                html += "<tr><td>Address</td><td>" + dr["OWNER_ADDRESS"] + "</td></tr>";
                                html += "<tr><td>Phone</td><td>" + dr["OWNER_PHONES"] + "</td></tr>";
                                html += "<tr><td>Kept at</td><td>" + dr["KEPT_AT_DETAILS"] + "</td></tr>";
                                html += "<tr><td>Name</td><td>" + dr["HORSE_NAME"] + "</td></tr>";
                                html += "<tr><td>Height</td><td>" + dr["HEIGHT"] + "</td></tr>";
                                html += "<tr><td>Age</td><td>" + dr["AGE"] + "</td></tr>";
                                html += "<tr><td>Breed</td><td>" + dr["BREED"] + "</td></tr>";
                                html += "<tr><td>Type</td><td>" + dr["HORSE_TYPE"] + "</td></tr>";
                                html += "<tr><td>Chip</td><td>" + dr["CHIP_NUMBER"] + "</td></tr>";
                                html += "<tr><td>Colour</td><td>" + dr["COLOUR"] + "</td></tr>";
                                html += "<tr><td>Marks</td><td>" + dr["DISTINGUISHING_MARKS"] + "</td></tr>";
                                html += "<tr><td>Notes</td><td>" + dr["NOTES"] + "</td></tr>";

                                html += "</table>";

                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_table\">Horse Register</a> | <a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "History":
                                html = "";
                                do
                                {
                                    // response.write "<b>Date:</b> " & rs("hdate") & "<br><b>Type:</b> " & rs("htype") & "<br><b>Details:</b> " & rs("hdetails") & "<br><b>Outcome:</b> " & rs("houtcome") & "<br><b>Notes:</b> " & rs("hnotes") & "<br><hr>"
                                    html += "<hr /><table>";

                                    DateTime EventDate;
                                    string UseDate = "";
                                    if (DateTime.TryParse(dr["hdate"].ToString(), out EventDate))
                                    {
                                        EventDate = Convert.ToDateTime(dr["hdate"].ToString());
                                        UseDate = EventDate.ToString("ddd dd/MM/yy");
                                    }

                                    html += "<thead><tr><th>Date</th><th>" + UseDate + "</th></tr></thead>";
                                    html += "<tr><td>Type</td><td>" + dr["htype"] + "</td></tr>";
                                    html += "<tr><td>Details</td><td>" + dr["hdetails"] + "</td></tr>";
                                    html += "<tr><td>Outcome</td><td>" + dr["houtcome"] + "</td></tr>";

                                    string notes = MarkupConverter.RtfToHtmlConverter.ConvertRtfToHtml(dr["hnotes"].ToString());
                                    html += "<tr><td>Notes</td><td>" + notes + "</td></tr>";

                                    html += "</table>";

                                }
                                while (dr.Read());

                                //html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";

                                break;
                            case "PoundHistory":
                                html = "";
                                do
                                {
                                    html += "<hr /><table style=\"width:100%\">";

                                    DateTime EntryDate;
                                    string UseEntryDate = "";
                                    if (DateTime.TryParse(dr["entry_date"].ToString(), out EntryDate))
                                    {
                                        EntryDate = Convert.ToDateTime(dr["entry_date"].ToString());
                                        UseEntryDate = EntryDate.ToString("ddd dd/MM/yy");
                                    }

                                    DateTime ExitDate;
                                    string UseExitDate = "";
                                    if (DateTime.TryParse(dr["Exit_date"].ToString(), out ExitDate))
                                    {
                                        ExitDate = Convert.ToDateTime(dr["exit_date"].ToString());
                                        UseExitDate = ExitDate.ToString("ddd dd/MM/yy");
                                    }

                                    html += "<thead><tr><th>Entry Date</th><th>" + UseEntryDate + "</th></tr></thead>";
                                    html += "<tr><td>Status</td><td>" + dr["status"] + "</td></tr>";
                                    html += "<tr><td>Impounding Officer</td><td>" + dr["impounding officer"] + "</td></tr>";
                                    html += "<tr><td>Reason</td><td>" + dr["reason"] + "</td></tr>";
                                    html += "<tr><td>Exit Date</td><td>" + UseExitDate + "</td></tr>";
                                    html += "<tr><td>Exit Status</td><td>" + dr["exit status"] + "</td></tr>";

                                    string notes = MarkupConverter.RtfToHtmlConverter.ConvertRtfToHtml(dr["notes"].ToString());
                                    html += "<tr><td>Notes</td><td>" + notes + "</td></tr>";

                                    html += "</table>";

                                }
                                while (dr.Read());

                                //html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";

                                break;
                            case "Owner":
                                html = "<hr />";
                                html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Address</th><th>Tag</th><th>Breed</th><th>Colour</th></tr></thead>";
                                do
                                {
                                    html += "<tr>";
                                    html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + dr["Address"] + "</a></td>";
                                    html += "<td>" + dr["licence"] + "</td>";
                                    html += "<td>" + dr["breed_desc"] + "</td>";
                                    html += "<td>" + dr["colour_desc"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html = html + "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";
                                break;
                            case "Property":
                                html = "<hr />";
                                html += "<table class=\"table\" style=\"width:100%\"><thead><tr><th>Address</th><th>Tag</th><th>Breed</th><th>Colour</th></tr></thead>";
                                do
                                {
                                    html += "<tr>";
                                    html += "<td><a href=\"javascript:void(0)\" class=\"a_animal\" data-id=\"" + dr["animal_ctr"] + "\">" + dr["Address"] + "</a></td>";
                                    html += "<td>" + dr["licence"] + "</td>";
                                    html += "<td>" + dr["breed_desc"] + "</td>";
                                    html += "<td>" + dr["colour_desc"] + "</td>";
                                    html += "</tr>";
                                }
                                while (dr.Read());
                                html = html + "</table>";
                                html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>"; break;

                        }
                    }
                    else
                    {
                        html = "There are no records for this.";
                        html += "<hr /><a href=\"javascript:void(0)\" class=\"a_menu\">Menu</a>";

                    }
                    result = html;
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
}