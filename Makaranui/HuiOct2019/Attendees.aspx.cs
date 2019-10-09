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

namespace Makaranui.HuiOct2019
{
    public partial class Attendees : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Makaranui;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("get_all_registrationsOct2019", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            //PrimaryContact	Firstname	lastname	Age	Dietary	medical	Medication	EmergencyContacts	FirstAidCertificate	Guid	koha	
            //Mobile	Email Address


                      try
            {
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string PrimaryContact = dr["PrimaryContact"].ToString();
                        string Firstname = dr["Firstname"].ToString();
                        string lastname = dr["lastname"].ToString();
                        string Age = dr["Age"].ToString();
                        string Dietary = dr["Dietary"].ToString();
                        string medical = dr["medical"].ToString();
                        string Medication = dr["Medication"].ToString();
                        string EmergencyContacts = dr["EmergencyContacts"].ToString();
                        string FirstAidCertificate = dr["FirstAidCertificate"].ToString();
                        string koha = dr["koha"].ToString();
                        string Mobile = dr["Mobile"].ToString();
                        string EmailAddress = dr["EmailAddress"].ToString();

                        html += "<tr><td>" + PrimaryContact + "</td><td>" + Firstname + "</td><td>" + lastname + "</td><td>" + Age + "</td><td>" + Dietary + "</td><td>" + medical + "</td><td>" + Medication + "</td><td>" + EmergencyContacts + "</td><td>" + FirstAidCertificate + "</td><td>" + Mobile + "</td><td>" + EmailAddress + "</td></tr>";

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
 