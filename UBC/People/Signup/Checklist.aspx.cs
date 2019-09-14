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

namespace UBC.People.Signup
{
    public partial class Checklist : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UBC_signup_ctr"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            */
            int cols = 4;
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Signups", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    int c1 = 0;

                    html = "";

                    while (dr.Read())
                    {


                        //string id = dr["ltr_ctr"].ToString();
                        string signup_ctr = dr["signup_ctr"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string school = dr["school"].ToString();
                        string schoolyear = dr["schoolyear"].ToString();
                        //string AgeatDate = dr["AgeatDate"].ToString();
                        //string atDate = dr["atDate"].ToString();
                        string friday = dr["friday"].ToString();
                        string saturday = dr["saturday"].ToString();
                        string sunday = dr["sunday"].ToString();

                        string days = "";
                        if(friday != "")
                        {
                            days += "Fri ";
                        }
                        if (saturday != "")
                        {
                            days += "Sat ";
                        }
                        if (sunday != "")
                        {
                            days += "Sun";
                        }

                        c1++;

                        if (c1 == 1)
                        {
                            html += "<tr>";
                        }

                        string schoolage = "";
                        if (school != "")
                        {
                            schoolage += school + " ";
                        }
                        if (schoolyear != "")
                        {
                            schoolage += "Year " + schoolyear + " ";
                        }
                        /*
                        if (AgeatDate != "")
                        {
                            schoolage += "Age: " + AgeatDate + " at " + atDate;
                        }
                        */
                        string guid = dr["guid"].ToString();
                        //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                        //string link = "<a href=\"maint.aspx?id=" + guid + "\">Edit</a>";
                        string image = "<img src=\"../Images/Signup/" + signup_ctr + ".jpg\" />";
                        html += "<td>" + image + "<br /><span id=\"" + guid + "\" class=\"span_name\">" + firstname + " " + lastname + "</span><br /><span class=\"span_school\">" + schoolage + "</span><br />" + days + "</td>";

                        if (c1 == cols)
                        {
                            html += "</tr>" + "\r\n";
                            c1 = 0;
                        }

                    }

                    for (int f1 = c1; f1 < cols; f1++)
                    {
                        html += "<td>&nbsp;</td>";
                    }
                    if (c1 > 0)
                    {
                        html += "</tr>";
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