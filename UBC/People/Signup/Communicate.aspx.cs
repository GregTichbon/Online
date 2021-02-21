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
    public partial class Communicate : System.Web.UI.Page
    {
        public string html;
        public string response = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                if (Session["UBC_person_id"] == null)
                {
                    Response.Redirect("../security/login.aspx");
                }
                if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11"))
                {
                    Response.Redirect("~/default.aspx");
                }


                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                Functions genericfunctions = new Functions();

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Get_SignUpCommunications", con);
                cmd1.Parameters.Add("@signupProgram_ctr", SqlDbType.Int).Value = 2;

                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = con;
                //try
                {
                    con.Open();
                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {

                        html = "";

                        while (dr.Read())
                        {
                            string id = dr["signup_ctr"].ToString();
                            string name = dr["name"].ToString();
                            string firstname = dr["firstname"].ToString();
                            string mobile = dr["mobilephone"].ToString();
                            string email = dr["emailaddress"].ToString();
                            string guid = dr["guid"].ToString();


                            string person = "<a id=\"name_" + id + "\" href=\"https://ubc.org.nz/people/signup?id=" + guid + "\" target=\"link\">" + name + "</a>";

                            string sendemail = "";
                            if (email != "")
                            {
                                sendemail = "<input id=\"cb_email_" + id + "\"name=\"cb_email_" + id + "\" type=\"checkbox\"  value=\"" + email + "\" /> <a href=\"mailto:" + email + "\">" + email + "</a>";
                            }
                            string sendtext = "";
                            if (mobile != "")
                            {
                                sendtext = "<input id=\"cb_text_" + id + "\" name=\"cb_text_" + id + "\" type=\"checkbox\" value=\"" + mobile + "\" /> <a href=\"tel:" + mobile + "\">" + mobile + "</a>";

                            }
                            html += "<tr class=\"tr_person\" id=\"tr_person_id_" + id + "\">";
                            html += "<td>" + person + "</td><td>" + sendtext + "</td><td>" + sendemail + "</td>";

                            html += "</tr>" + "\r\n";


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
}
