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
        protected void Page_Load(object sender, EventArgs e)
        {
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

                    Lit_html.Text = "";

                    while (dr.Read())
                    {

                        c1++;

                        if (c1 == 1)
                        {
                            Lit_html.Text += "<tr>";
                        }
                        //string id = dr["ltr_ctr"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string school = dr["school"].ToString();
                        string schoolyear = dr["schoolyear"].ToString();
                        string AgeatDate = dr["AgeatDate"].ToString();
                        string atDate = dr["atDate"].ToString();

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

                      


                        string guid = dr["guid"].ToString();
                        //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                        string link = "<a href=\"maint.aspx?id=" + guid + "\">Edit</a>";
                        string image = "<img src=\"../Images/" + person_id + ".jpg\" style=\"height: 100px\" />";



                        Lit_html.Text += "<td>" + image + "<br /><span id=\"" + guid + "\" class=\"span_name\">" + firstname + " " + lastname + "</span><br /><span class=\"span_school\">" + schoolage + "</span></td>";
                        if(c1 == cols)
                        {
                            Lit_html.Text += "</tr>" + "\r\n";
                            c1 = 0;
                        }

                    }

                    for (int f1 = c1; f1 < cols; f1++)
                    {
                        Lit_html.Text += "<td>&nbsp;</td>";
                    }
                    if(c1 > 0)
                    {
                        Lit_html.Text += "</tr>";
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