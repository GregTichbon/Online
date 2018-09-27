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
        protected void Page_Load(object sender, EventArgs e)
        {
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

                    Lit_html.Text = "<tr><th>Checkbox</th><th>Name</th><th>Status</th><th>Edit</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string status = "Status - based on category and currency";
       

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
                        string link = "<a href=\"maint.aspx?id=" + guid + "\">Edit</a>";




                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td>Checkbox</td><td>" + firstname + " " + lastname + "</td><td>" + status + "</td><td>" + link + "</td>";
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