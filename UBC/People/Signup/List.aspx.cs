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

                    html = "<tr><td></td><td>Firstname</td><td>Lastname</td><td>KnownAs</td><td>MobilePhone</td><td>EmailAddress</td><td>Notes</td><td>School</td><td>SchoolYear</td><td>Gender</td><td>parentcaregiver1</td><td>parentcaregiver1_phone</td></tr>";

                    while (dr.Read())
                    {
                        string Signup_Ctr = dr["Signup_Ctr"].ToString();
                        string SignupProgram_Ctr = dr["SignupProgram_Ctr"].ToString();
                        string Firstname = dr["Firstname"].ToString();
                        string Lastname = dr["Lastname"].ToString();
                        string KnownAs = dr["KnownAs"].ToString();
                        string MobilePhone = dr["MobilePhone"].ToString();
                        string EmailAddress = dr["EmailAddress"].ToString();
                        string Notes = dr["Notes"].ToString();
                        string InternalNotes = dr["InternalNotes"].ToString();
                        string GUID = dr["GUID"].ToString();
                        string School = dr["School"].ToString();
                        string SchoolYear = dr["SchoolYear"].ToString();
                        string Gender = dr["Gender"].ToString();
                        string DateCreated = dr["DateCreated"].ToString();
                        string parentcaregiver1 = dr["parentcaregiver1"].ToString();
                        string parentcaregiver1_phone = dr["parentcaregiver1_phone"].ToString();



                        string person = "<a href=\"default.aspx?id=" + GUID + "\" target=\"startupperson\">" + Firstname + "</a>";



                        html += "<tr>";
                        //html += "<td>" + Signup_Ctr+"</td>";
                        //html += "<td>" + SignupProgram_Ctr + "</td>";
                        html += "<td><img src=../images/signup/" + Signup_Ctr + ".jpg></td>";

                        html += "<td>" + person + "</td>";
                        html += "<td>" + Lastname + "</td>";
                        html += "<td>" + KnownAs + "</td>";
                        html += "<td>" + MobilePhone + "</td>";
                        html += "<td>" + EmailAddress + "</td>";
                        html += "<td>" + Notes + "</td>";
                        //html += "<td>" + InternalNotes + "</td>";
                        //html += "<td>" + GUID + "</td>";
                        html += "<td>" + School + "</td>";
                        html += "<td>" + SchoolYear + "</td>";
                        html += "<td>" + Gender + "</td>";
                        //html += "<td>" + DateCreated + "</td>";
                        html += "<td>" + parentcaregiver1 + "</td>";
                        html += "<td>" + parentcaregiver1_phone + "</td>";

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

