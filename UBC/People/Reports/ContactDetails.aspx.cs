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
    public partial class ContactDetails : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
        
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                Response.Redirect("~/default.aspx");
            }

            
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_communications", con);
            cmd1.Parameters.Add("@options", SqlDbType.VarChar).Value = "|allphones|";

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string id = dr["person_id"].ToString();
                    string name = dr["name"].ToString();
                    string firstname = dr["firstname"].ToString();
                    string facebook = dr["facebook"].ToString();
                    string mobile = dr["mobile"].ToString();
                    string email = dr["email"].ToString();
                    string category = dr["category"].ToString();
                    string categories = dr["categories"].ToString();
                    string person_guid = dr["person_guid"].ToString();
                    string relationships = dr["relationships"].ToString();



                    string person = "<a href=\"maint.aspx?id=" + person_guid + "\" target=\"link\">" + name + "</a>";
                    string image = "<img src=\"../Images/" + id + ".jpg\" style=\"height: 50px\" />";

                    category = category.Replace("|", "<br />");
                    string sendemail = "";
                    if (email != "")
                    {
                        string delim = "";
                        foreach (string emailsplit in email.Split('|'))
                        {
                            string address = emailsplit.Split('~')[0];
                            string note = emailsplit.Split('~')[1];
                            if (note != "")
                            {
                                note = " - " + note;
                            }
                            sendemail += delim + "<a href=\"mailto:" + address + "\">" + address + "</a>" + note;
                            delim = "<br />";
                        }
                    }
                    string sendtext = "";
                    if (mobile != "")
                    {
                        string delim = "";
                        foreach (string mobilesplit in mobile.Split('|'))
                        {
                            string number = mobilesplit.Split('~')[0];
                            string note = mobilesplit.Split('~')[1];
                            if (note != "")
                            {
                                note = " - " + note;
                            }
                            sendtext += delim + "<a href=\"tel:" + number + "\">" + number + "</a>" + note;
                            delim = "<br />";
                        }
                    }

                    string facebooklink = "";
                    if (facebook != "")
                    {
                        facebooklink = "<a href=\"" + facebook + "\" target=\"Facebook\">" + facebook + "</a>";
                    }

                    string rline = "";
                    if (relationships != "")
                    {
                        foreach (string relation in relationships.Split('\\'))
                        {
                            string rid = relation.Split('^')[0];
                            string rrelationship = relation.Split('^')[1];
                            string rname = relation.Split('^')[2];
                            string rfirstname = relation.Split('^')[3];
                            string rnote = relation.Split('^')[4];
                            if (rnote != "")
                            {
                                rnote = " - " + rnote;
                            }
                            rline += "<b>" + rname + "</b> " + rrelationship + rnote + "<br />";

                            string rphones = relation.Split('^')[5];
                            if (rphones != "")
                            {
                                foreach (string rphone in rphones.Split('|'))
                                {
                                    string rphonenumber = rphone.Split('~')[0];
                                    string rphonenote = rphone.Split('~')[1];
                                    if (rphonenote != "")
                                    {
                                        rphonenote = " - " + rphonenote;
                                    }
                                    rline += "<a href=\"tel:" + rphonenumber + "\">" + rphonenumber + "</a>" + rphonenote + "<br />";
                                }
                            }
                            string remails = relation.Split('^')[6];
                            if (remails != "")
                            {
                                foreach (string remail in remails.Split('|'))
                                {
                                    string remailaddress = remail.Split('~')[0];
                                    string remailnote = remail.Split('~')[1];
                                    if (remailnote != "")
                                    {
                                        remailnote = " - " + remailnote;
                                    }
                                    rline += "<a href=\"mailto:" + remailaddress + "\">" + remailaddress + "</a>" + remailnote + "<br />";
                                }
                            }
                        }
                    }

                    html += "<tr class=\"tr_person\" data-category=\"" + categories + "\">";
                    html += "<td>" + image + "</td>";
                    html += "<td>" + person + "</td><td>" + category + "</td><td>" + sendtext + "</td><td>" + sendemail + "</td><td>" + facebooklink + "</td>";
                    html += "<td>" + rline + "</td>";
                    html += "</tr>" + "\r\n";
                }
            }

            dr.Close();

        }
    }
}
