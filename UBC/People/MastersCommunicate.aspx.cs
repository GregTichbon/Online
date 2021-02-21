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
    public partial class MastersCommunicate : System.Web.UI.Page
    {
        public string html;
        public string response = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                 
                if (Session["UBC_person_id"] == null)
                {
                    Response.Redirect("~/people/security/login.aspx");
                }
                if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1000001"))
                {
                    Response.Redirect("~/default.aspx");
                }
                

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                Functions genericfunctions = new Functions();

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("Get_MastersCommunications", con);

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
                            string id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string firstname = dr["firstname"].ToString();
                            string mobile = dr["mobile"].ToString();
                            string email = dr["email"].ToString();
                            string person_guid = dr["person_guid"].ToString();


                            string person = "<a id=\"name_" + id + "\" href=\"https://ubc.org.nz/people/maint.aspx?id=" + person_guid + "\" target=\"link\">" + name + "</a>";
                            string image = "<img src=\"Images/" + id + ".jpg\" style=\"height: 50px\" />";

                            string sendemail = "";
                            //string sendemaillink = "";
                            if (email != "")
                            {
                                string delim = "";
                                //string[] emailsplit = email.Split('|');
                                foreach (string emailsplit in email.Split('|'))
                                {
                                    string address = emailsplit.Split('~')[0];
                                    string note = emailsplit.Split('~')[1];
                                    if (note != "")
                                    {
                                        note = " - " + note;
                                    }
                                    sendemail += delim + "<input id=\"cb_email_" + id + "\"name=\"cb_email_" + id + "\" type=\"checkbox\"  value=\"" + address + "\" /> <a href=\"mailto:" + address + "\">" + address + "</a>" + note;
                                    //sendemaillink += "<a href=\"mailto:" + address + "\">" + address + note + "</a>" + delim;
                                    delim = "<br />";
                                }
                            }
                            string sendtext = "";
                            if (mobile != "")
                            {
                                string delim = "";
                                //string[] mobilesplit = mobile.Split('|');
                                foreach (string mobilesplit in mobile.Split('|'))
                                {
                                    string number = mobilesplit.Split('~')[0];
                                    string note = mobilesplit.Split('~')[1];
                                    if (note != "")
                                    {
                                        note = " - " + note;
                                    }
                                    sendtext += delim + "<input id=\"cb_text_" + id + "\" name=\"cb_text_" + id + "\" type=\"checkbox\" value=\"" + number + "\" /> <a href=\"tel:" + number + "\">" + number + "</a>" + note;
                                    //mobile = "<a href=\"tel:" + mobile + "\">" + mobile + "</>";
                                    delim = "<br />";
                                }
                            }
                            html += "<tr class=\"tr_person\" id=\"tr_person_id_" + id + "\">";
                            html += "<td>" + image + "</td>";
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
