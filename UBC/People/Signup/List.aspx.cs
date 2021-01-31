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

namespace UBC.People.Signup
{
    public partial class List : System.Web.UI.Page
    {
        public string html;

        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Signups", con);
            //cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = tb_event_id.Text;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            //try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<tr><td></td><td>Firstname</td><td>Lastname</td><td>Known as</td><td>Birth date</td><td>Mobile</td><td>Home</td><td>Email</td><td>Notes</td><td>Guid</td><td>School</td><td>SchoolYear</td><td>Gender</td><td>Parent/Caregiver 1</td><td>Parent/Caregiver 2</td></tr>";

                    while (dr.Read())
                    {
                        string Signup_Ctr = dr["Signup_Ctr"].ToString();
                        string SignupProgram_Ctr = dr["SignupProgram_Ctr"].ToString();
                        string Firstname = dr["Firstname"].ToString();
                        string Lastname = dr["Lastname"].ToString();
                        string KnownAs = dr["KnownAs"].ToString();
                        string MobilePhone = dr["MobilePhone"].ToString();
                        string HomePhone = dr["HomePhone"].ToString();
                        string EmailAddress = dr["EmailAddress"].ToString();
                        string Notes = dr["Notes"].ToString();
                        string InternalNotes = dr["InternalNotes"].ToString();
                        string GUID = dr["GUID"].ToString();
                        string School = dr["School"].ToString();
                        string SchoolYear = dr["SchoolYear"].ToString();
                        string Gender = dr["Gender"].ToString();
                        string DateCreated = dr["DateCreated"].ToString();

                        string birthdate = dr["birthdate"].ToString();
                        //string medical = dr["medical"].ToString();
                        //string dietry = dr["dietry"].ToString();
                        //string facebook = dr["facebook"].ToString();
                        string school = dr["school"].ToString();
                        string schoolyear = dr["schoolyear"].ToString();
                        //string residentialaddress = dr["residentialaddress"].ToString();
                        //string postaladdress = dr["postaladdress"].ToString();
                        string emailaddress = dr["emailaddress"].ToString();
                        string homephone = dr["homephone"].ToString();
                        string mobilephone = dr["mobilephone"].ToString();
                        string swimmer = dr["swimmer"].ToString();
                        string notes = dr["notes"].ToString();

                        string parentcaregiver1 = dr["parentcaregiver1"].ToString();
                        string parentcaregiver1relationship = dr["parentcaregiver1_relationship"].ToString();
                        string parentcaregiver1mobilephone = dr["parentcaregiver1_mobile"].ToString();
                        string parentcaregiver1homephone = dr["parentcaregiver1_home"].ToString();
                        string parentcaregiver1emailaddress = dr["parentcaregiver1_email"].ToString();
                        string parentcaregiver2 = dr["parentcaregiver2"].ToString();
                        string parentcaregiver2relationship = dr["parentcaregiver2_relationship"].ToString();
                        string parentcaregiver2mobilephone = dr["parentcaregiver2_mobile"].ToString();
                        string parentcaregiver2homephone = dr["parentcaregiver2_home"].ToString();
                        string parentcaregiver2emailaddress = dr["parentcaregiver2_email"].ToString();

                        string parentcaregivercomments = dr["parentcaregiver_comments"].ToString();
                        if (birthdate != "")
                        {
                            birthdate = Convert.ToDateTime(birthdate).ToString("dd MMM yyyy");
                        }

                        string person = "<a href=\"default.aspx?id=" + GUID + "\" target=\"startupperson\">" + Firstname + "</a>";



                        html += "<tr>";
                        //html += "<td>" + Signup_Ctr+"</td>";
                        //html += "<td>" + SignupProgram_Ctr + "</td>";
                        html += "<td><img src=../images/signup/" + Signup_Ctr + ".jpg></td>";

                        html += "<td>" + person + "</td>";
                        html += "<td>" + Lastname + "</td>";
                        html += "<td>" + KnownAs + "</td>";
                        html += "<td>" + birthdate + "</td>";

                        html += "<td>" + MobilePhone + "</td>";
                        html += "<td>" + homephone + "</td>";
                        html += "<td>" + EmailAddress + "</td>";
                        html += "<td>" + Notes + "</td>";
                        //html += "<td>" + InternalNotes + "</td>";
                        html += "<td>" + GUID + "</td>";
                        html += "<td>" + School + "</td>";
                        html += "<td>" + SchoolYear + "</td>";
                        html += "<td>" + Gender + "</td>";
                        //html += "<td>" + DateCreated + "</td>";
                        html += "<td>" + parentcaregiver1 + "<br />" + parentcaregiver1relationship + "<br />Mobile: " + parentcaregiver1mobilephone + "<br />Home:" + parentcaregiver1homephone + "<br />Email:" + parentcaregiver1emailaddress + "</td>";
                        html += "<td>" + parentcaregiver2 + "<br />" + parentcaregiver2relationship + "<br />Mobile: " + parentcaregiver2mobilephone + "<br />Home:" + parentcaregiver2homephone + "<br />Email:" + parentcaregiver2emailaddress + "</td>";
                        //html += "<td>" + parentcaregiver1_phone + "</td>";
                        html += "<td>" + parentcaregivercomments + "</td>";
                        html += "</tr>";
                    }
                }

                dr.Close();
            }

            //catch (Exception ex)
            {
                //throw ex;
            }
            //finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}

