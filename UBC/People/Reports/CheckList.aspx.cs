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

namespace UBC.People.Reports
{
    public partial class CheckList : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            int cols = 4;
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_All_People", con);

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

                        c1++;

                        if (c1 == 1)
                        {
                            html += "<tr>";
                        }
                        //string id = dr["ltr_ctr"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string school = dr["school"].ToString();
                        string schoolyear = dr["schoolyear"].ToString();
                        string AgeatDate = dr["AgeatDate"].ToString();
                        string atDate = dr["atDate"].ToString();
                        string lastregistered = dr["lastregistered"].ToString();

                        string schoolage = "";
                        if(school != "")
                        {
                            schoolage += school + " ";
                        }
                        if (schoolyear != "")
                        {
                            schoolage += "Year " + schoolyear + " ";
                        }
                        if (AgeatDate != "")
                        {
                            schoolage += "Age: " + AgeatDate + " at " + atDate;
                        }

                        if(lastregistered != "")
                        {
                            lastregistered = "<br />Last Registered: " + Convert.ToDateTime( lastregistered).ToString("d MMM yy");
                        }


                        string guid = dr["guid"].ToString();
                        //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                        string link = "<a href=\"maint.aspx?id=" + guid + "\">Edit</a>";
                        string image = "<img src=\"../Images/" + person_id + ".jpg\" style=\"height: 100px\" />";



                        html += "<td>" + image + "<br /><span id=\"" + guid + "\" class=\"span_name\">" + firstname + " " + lastname + "</span><br /><span class=\"span_school\">" + schoolage + "</span>" + lastregistered  + "</td>";
                        if(c1 == cols)
                        {
                            html += "</tr>" + "\r\n";
                            c1 = 0;
                        }

                    }

                    for (int f1 = c1; f1 < cols; f1++)
                    {
                        html += "<td>&nbsp;</td>";
                    }
                    if(c1 > 0)
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