using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Generic;

namespace Makaranui.HuiOct2019
{
    public partial class Default : System.Web.UI.Page
    {
        public string registrationhtml = "";
        public string tshirtshtml = "";
        public string[] tshirtsizes = new string[10] { "Child, size 10", "Child, size 12", "Child, size 14", "Adult, size Small", "Adult, size Medium", "Adult, size Large", "Adult, size XL", "Adult, size 2XL", "Adult, size 3XL", "Adult, size 4XL" };
        public string strConnString = "Data Source=toh-app;Initial Catalog=Makaranui;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_registartionOct2019";
            cmd.Parameters.Add("@ctr", SqlDbType.VarChar).Value = 1;

            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string keycontact = dr["keyContact"].ToString();
                        string person_ctr = dr["person_ctr"].ToString();
                        string firstname = dr["Firstname"].ToString();
                        string lastname = dr["Lastname"].ToString();
                        string phone = dr["number"].ToString();
                        string email = dr["address"].ToString();
                        string age = dr["Age"].ToString();
                        string dietary = dr["Dietary"].ToString();
                        string medical = dr["Medical"].ToString();
                        string medication = dr["Medication"].ToString();
                        string emergencycontacts = dr["EmergencyContacts"].ToString();
                        string firstaidcertificate = dr["FirstAidCertificate"].ToString();

                        registrationhtml += "<tr>";
                        registrationhtml += "<td>" + keycontact + "</td>";
                        registrationhtml += "<td>" + firstname + "</td>";
                        registrationhtml += "<td>" + lastname + "</td>";
                        registrationhtml += "<td>" + phone + "</td>";
                        registrationhtml += "<td>" + email + "</td>";
                        registrationhtml += "<td class=\"right\">" + age + "</td>";
                        registrationhtml += "<td>" + dietary + "</td>";
                        registrationhtml += "<td>" + medical + "</td>";
                        registrationhtml += "<td>" + medication + "</td>";
                        registrationhtml += "<td>" + emergencycontacts + "</td>";
                        registrationhtml += "<td>" + firstaidcertificate + "</td>";
                        registrationhtml += "</tr>";
                    }
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            foreach (string tshirtsize in tshirtsizes)
            {
                tshirtshtml += "<tr><td>" + tshirtsize + "</td><td><input class=\"numeric\" name=\"" + tshirtsize + "\" value=\"" + 0 + "\"</td></tr>";
            }
        }
    }
}