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
    public partial class List : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "111"))
            {
                Response.Redirect("~/default.aspx");
            }

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

                    html = "<tr><th>Checkbox</th><th>Name</th><th>Category</th><th>Edit</th><th>Image</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string person_id = dr["person_id"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string categories = dr["categories"].ToString();
                        //string status = "Status - based on category and currency";
       

                        /*
                        string email = dr["email"].ToString();
                        string mobile = dr["mobile"].ToString();
                        string landline = dr["landline"].ToString();
                        string school = dr["school"].ToString();
                        string schoolyear = dr["schoolyear"].ToString();
                        string caregivername = dr["caregivername"].ToString();
                        string caregiveremail = dr["caregiveremail"].ToString();
                        string caregivermobile = dr["caregivermobile"].ToString();
                        string caregiverlandline = dr["caregiverlandline"].ToString();
                        string caregiverfacebook = dr["caregiverfacebook"].ToString();
                        string facebook = dr["facebook"].ToString();
                        string coming = dr["coming"].ToString();
                        string modified = dr["modifieddate"].ToString();
                        string notes = dr["notes"].ToString();
 

                        notes = notes.Replace("\n", "<br />");
                       */

                        string guid = dr["guid"].ToString();
                        //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                        string link = "<a href=\"maint.aspx?id=" + guid + "&returnto=list\">Edit</a>";
                        string image = "<img src=\"Images/" + person_id + ".jpg\" style=\"height: 50px\" />";

                        



                        html += "<tr>";
                        html += "<td>Checkbox " + person_id + "</td><td>" + firstname + " " + lastname + "</td><td>" + categories.Replace("|","<br />") + "</td><td>" + link + "</td><td>" + image + "</td>";
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