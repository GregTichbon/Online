using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Generic;

namespace Makaranui.HuiOct2019
{
    public partial class Register : System.Web.UI.Page
    {
        public string registrationhtml = "";
        public string tshirtshtml = "";
        public string[] tshirtsizes = new string[10] { "Child, size 10", "Child, size 12", "Child, size 14", "Adult, size Small", "Adult, size Medium", "Adult, size Large", "Adult, size XL", "Adult, size 2XL", "Adult, size 3XL", "Adult, size 4XL" };
        public string strConnString = "Data Source=toh-app;Initial Catalog=Makaranui;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
        public string guid;
        public string koha = "0.00";

        protected void Page_Load(object sender, EventArgs e)
        {
            //hidden row, used for creating new rows client side
            registrationhtml += "<tr style=\"display:none\">";
            registrationhtml += "<td class=\"maintain\">Edit</td>";
            registrationhtml += "<td style=\"text-align:center\">" + "<input type=\"radio\" value=\"Yes\" name=\"primarycontact\">" + "</td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td class=\"right\"></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "<td></td>";
            registrationhtml += "</tr>";

            guid = Request.QueryString["id"] ?? "";
            if (guid != "")
            {
                SqlConnection con = new SqlConnection(strConnString);
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "get_RegistrationOct2019";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                cmd.Connection = con;
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {


                    while (dr.Read())
                    {
                        koha = Convert.ToDecimal(dr["koha"]).ToString("0.00");
                        string primarycontact = dr["primarycontact"].ToString();
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

                        string primarycontactchecked = "";
                        if (primarycontact == "Yes")
                        {
                            primarycontactchecked = " checked";
                        }
                        //"<input type=\"radio\" name=\"gender\" value=\"male\">"

                        //registrationhtml += "<tr class=\"maintain\">";
                        registrationhtml += "<tr id=\"person_" + person_ctr + "\">";
                        registrationhtml += "<td class=\"maintain\">Edit</td>";
                        registrationhtml += "<td style=\"text-align:center\">" + "<input type=\"radio\" name=\"primarycontact\" value=\"" + person_ctr + "\"" + primarycontactchecked + ">" + "</td>";
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

                cmd.CommandText = "get_registartionOct2019_tshirts";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                //con.Open();
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    string size = dr["size"].ToString();
                    string quantity = dr["quantity"].ToString();

                    tshirtshtml += "<tr class=\"altcolour\"><td>" + size + "</td><td><input class=\"tshirt numeric\" name=\"tshirt_" + size + "\" value=\"" + quantity + "\" /></td></tr>";

                }
                dr.Close();


                con.Close();
                con.Dispose();

            }
            else
            {
                foreach (string tshirtsize in tshirtsizes)
                {
                    tshirtshtml += "<tr class=\"altcolour\"><td>" + tshirtsize + "</td><td><input class=\"tshirt numeric\" name=\"tshirt_" + tshirtsize + "\" value=\"" + 0 + "\" /></td></tr>";
                }
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            /*
            string x = "";
            foreach (string name in Request.Form)
            {
                x += "<br />" + name + "=" + Request.Form[name];
            }
            Response.Write(x);
            */
            string guid = Request.Form["guid"] ?? "";

            string strConnString = "Data Source=toh-app;Initial Catalog=Makaranui;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            if (guid == "")
            {
                cmd.CommandText = "Update_RegistrationOct2019";
                //con.Open();
                guid = cmd.ExecuteScalar().ToString();
                //con.Close();
            }


            foreach (string key in Request.Form)
            {
                if (key.StartsWith("person_"))
                {
                    string person_id = key.Substring(7);
                    if (person_id.EndsWith("_delete"))
                    {
                        cmd.CommandText = "Delete_RegistrationOct2019_Person";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
                        cmd.Parameters.Add("@person_ctr", SqlDbType.VarChar).Value = person_id.Substring(0, person_id.Length - 7);
                    }
                    else
                    {
                        if (person_id.StartsWith("new"))
                        {
                            person_id = "new";
                        }

                        string[] valuesSplit = Request.Form[key].Split('\x00FE');
                        cmd.CommandText = "Update_RegistrationOct2019_Person";
                        cmd.Parameters.Clear();

                        // primarycontact, firstname, lastname, phone, email, age, diet, health, medication, emergency, firstaid;
                        cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
                        cmd.Parameters.Add("@person_ctr", SqlDbType.VarChar).Value = person_id;
                        cmd.Parameters.Add("@primarycontact", SqlDbType.VarChar).Value = valuesSplit[0];

                        cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = valuesSplit[1];
                        cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = valuesSplit[2];
                        cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = valuesSplit[3];
                        cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = valuesSplit[4];
                        cmd.Parameters.Add("@age", SqlDbType.VarChar).Value = valuesSplit[5];
                        cmd.Parameters.Add("@diet", SqlDbType.VarChar).Value = valuesSplit[6];
                        cmd.Parameters.Add("@health", SqlDbType.VarChar).Value = valuesSplit[7];
                        cmd.Parameters.Add("@medication", SqlDbType.VarChar).Value = valuesSplit[8];
                        cmd.Parameters.Add("@emergency", SqlDbType.VarChar).Value = valuesSplit[9];
                        cmd.Parameters.Add("@firstaid", SqlDbType.VarChar).Value = valuesSplit[10];
                    }
                    //con.Open();
                    string result = cmd.ExecuteScalar().ToString();
                    //con.Close();
                }
                else if (key.StartsWith("tshirt_"))
                {
                    cmd.CommandText = "Update_RegistrationOct2019_Tshirt";
                    cmd.Parameters.Clear();

                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
                    cmd.Parameters.Add("@size", SqlDbType.VarChar).Value = key.Substring(7);
                    cmd.Parameters.Add("@quantity", SqlDbType.VarChar).Value = Request.Form[key];

                    //con.Open();
                    string result = cmd.ExecuteScalar().ToString();
                    //con.Close();
                }
            }
            Generic.Functions gFunctions = new Generic.Functions();
            string host = "70.35.207.87";
            string emailfrom = "makaranui@datainn.co.nz";
            string emailfromname = "Makaranui";
            string password = "39%3Zxon";

            string emailRecipients = "";
            string textRecipients = "";
            decimal koha = 0;

            string thstyle = " style=\"border:1px solid black;padding:10px;text-align:left\"";
            string tdstyle = " style=\"border:1px solid black;padding:10px\"";

            string emailhtml = "<html><body>";

            emailhtml += "<p>Thanks for your registration for Makaranui hui, see your details below.</p>";
            emailhtml += "<p>You can make changes to your registration <a href=\"http://makaranui.nz/huiOct2019/register.aspx?id=" + guid + "\">here</a>.</p>";
            emailhtml += "<p>Registration is payable to:  Kotahitanga Tribal Committee  38-9014-0036435-00</p>";
            emailhtml += "<p>Reference:  your name, so we can match the payment to the registration</p>";
            emailhtml += "<p>Note that Tshirt orders must be paid by 17th October so they can be ordered.</p>";
            emailhtml += "<p>For more information, text Sheryl Connell on 021 969127.</p>";

            emailhtml += "<table style=\"border:1px solid black;border-collapse:collapse;\">";
            emailhtml += "<thead>";
            emailhtml += "<tr>";
            emailhtml += "<th" + thstyle + ">Primary Contact</th>";
            emailhtml += "<th" + thstyle + ">First Name</th>";
            emailhtml += "<th" + thstyle + ">Last Name</th>";
            emailhtml += "<th" + thstyle + ">Phone</th>";
            emailhtml += "<th" + thstyle + ">Email</th>";
            emailhtml += "<th style=\"border:1px solid black;padding:10px;text-align:right\">Age</th>";
            emailhtml += "<th" + thstyle + ">Dietary Needs</th>";
            emailhtml += "<th" + thstyle + ">Health/Medical<br />Issues</th>";
            emailhtml += "<th" + thstyle + ">Medication</th>";
            emailhtml += "<th" + thstyle + ">Emergency Contact</th>";
            emailhtml += "<th" + thstyle + ">First Aid</th>";
            emailhtml += "</tr>";
            emailhtml += "</thead>";
            emailhtml += "<tbody>";

            cmd.CommandText = "get_registrationOct2019";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

            //cmd.Connection = con;
            //con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                string primarycontact = dr["primarycontact"].ToString();
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
                koha = (decimal)dr["koha"];

                if (emailRecipients == "" && email != "")
                {
                    emailRecipients = email;
                }
                if (textRecipients == "" && phone != "") //might not be mobile
                {
                    textRecipients = phone;
                }
                emailhtml += "<tr>";
                emailhtml += "<td" + tdstyle + ">" + primarycontact + "</td>";
                emailhtml += "<td" + tdstyle + ">" + firstname + "</td>";
                emailhtml += "<td" + tdstyle + ">" + lastname + "</td>";
                emailhtml += "<td" + tdstyle + ">" + phone + "</td>";
                emailhtml += "<td" + tdstyle + ">" + email + "</td>";
                emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\">" + age + "</td>";
                emailhtml += "<td" + tdstyle + ">" + dietary + "</td>";
                emailhtml += "<td" + tdstyle + ">" + medical + "</td>";
                emailhtml += "<td" + tdstyle + ">" + medication + "</td>";
                emailhtml += "<td" + tdstyle + ">" + emergencycontacts + "</td>";
                emailhtml += "<td" + tdstyle + ">" + firstaidcertificate + "</td>";
                emailhtml += "</tr>";
            }
            emailhtml += "</tbody>";
            emailhtml += "</table>";
            emailhtml += "<br /><br />";
            dr.Close();

            emailhtml += "<table style=\"border:1px solid black;border-collapse:collapse;\">";
            emailhtml += "<thead>";
            emailhtml += "<tr>";
            emailhtml += "<th" + thstyle + ">Size</th>";
            emailhtml += "<th style=\"border:1px solid black;padding:10px;text-align:right\">Quantity</th>";
            emailhtml += "</tr>";
            emailhtml += "</thead>";
            emailhtml += "<tbody>";

            cmd.CommandText = "get_registrationOct2019_tshirts";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

            //cmd.Connection = con;
            //con.Open();
            dr = cmd.ExecuteReader();

            int tshirts = 0;

            while (dr.Read())
            {
                string size = dr["size"].ToString();
                string quantity = dr["quantity"].ToString();

                tshirts += Convert.ToInt16(quantity);

                emailhtml += "<tr>";
                emailhtml += "<td" + tdstyle + ">" + size + "</td>";
                emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\">" + quantity + "</td>";
                emailhtml += "</tr>";

            }
            dr.Close();
            con.Close();
            con.Dispose();

            decimal tshirtsamount = tshirts * 15;

            decimal total = 50 + Convert.ToDecimal(koha) + tshirtsamount;

            emailhtml += "</tbody>";
            emailhtml += "</table>";
            emailhtml += "<br /><br />";

            emailhtml += "<table style=\"border:1px solid black;border-collapse:collapse;\">";
            emailhtml += "<thead>";
            emailhtml += "<tr>";
            emailhtml += "<th" + thstyle + ">Description</th>";
            emailhtml += "<th style=\"border:1px solid black;padding:10px;text-align:right\">Amount</th>";
            emailhtml += "</tr>";
            emailhtml += "</thead>";
            emailhtml += "<tbody>";

            emailhtml += "<tr>";
            emailhtml += "<td" + thstyle + ">Whanau Contributions</td>";
            emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\">$50.00</th>";
            emailhtml += "</tr>";
            emailhtml += "<tr>";
            emailhtml += "<td" + thstyle + ">Koha</td>";
            emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\">$" + koha.ToString("0.00") + "</th>";
            emailhtml += "</tr>";
            emailhtml += "<tr>";
            emailhtml += "<td" + thstyle + ">" + tshirts + " T-shirts</td>";
            emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\">$" + tshirtsamount.ToString("0.00") + "</th>";
            emailhtml += "</tr>";
            emailhtml += "<tr>";
            emailhtml += "<td" + thstyle + "><b>Total</b></td>";
            emailhtml += "<td style=\"border:1px solid black;padding:10px;text-align:right\"><b>$" + total.ToString("0.00") + "</b></th>";
            emailhtml += "</tr>";


            emailhtml += "</body></html>";





            foreach (string emailRecipient in emailRecipients.Split(';'))
            {
                gFunctions.sendemailV3(host, emailfrom, emailfromname, password, "Makaranui Wananga Oct 2019", emailhtml, emailRecipient, "jkumeroa@teorahou.org.nz", "");
            }

            foreach (string textRecipient in textRecipients.Split(';'))
            {
                if (textRecipient.StartsWith("02"))
                {
                    gFunctions.SendRemoteMessage(textRecipient, "Thanks for you Wananga Registration.  You can maintain your details at: http://makaranui.nz/huiOct2019/register.aspx?id=" + guid, "Makaranui Wananga");
                }
            }

            //Response.Redirect("?id=" + guid);
            Response.Redirect("Complete.aspx");
        }
    }
}
 