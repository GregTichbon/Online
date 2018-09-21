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

namespace DataInnovations.UBC.LTR
{
    public partial class List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=datainnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_All_LTR", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    Lit_html.Text = "<tr><td>Student</td><td>School</td></tr>";

                    while (dr.Read())
                    {
                        string id = dr["ltr_ctr"].ToString();
                        string firstname = dr["firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
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


                        string guid = dr["guid"].ToString();
                        string link = "<a href=\"http://office.datainn.co.nz/UBC/ltr/maint.aspx?id=" + guid + "\" target=\"link\">Link</a>";


                        

                        Lit_html.Text += "<tr>";
                        Lit_html.Text += "<td>" + firstname + " " + lastname + "</td><td>" + school + "</td>";
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