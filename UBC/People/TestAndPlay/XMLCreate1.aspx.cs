using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace UBC.People.TestAndPlay
{
    public partial class XMLCreate1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_person";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = "09DB9E21-D49E-441F-9076-2626B37E099C";


            cmd.Connection = con;

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                dr.Read();


                string person_id = dr["person_id"].ToString();
                string firstname = dr["firstname"].ToString();
                string lastname = dr["lastname"].ToString();
                string birthdate = dr["birthdate"].ToString();
                string gender = dr["gender"].ToString();
                string school = dr["school"].ToString();
                string schoolyear = dr["schoolyear"].ToString();


                string medical = dr["medical"].ToString();
                string dietary = dr["dietry"].ToString();
                string emailaddress = dr["emailaddress"].ToString();
                string residentialaddress = dr["residentialaddress"].ToString();

                string swimmer = dr["swimmer"].ToString();

                string invoicerecipient = dr["invoicerecipient"].ToString();
                string invoicetype = dr["invoiceaddresstype"].ToString();
                string invoiceaddress = dr["invoiceaddress"].ToString();
                //string invoicenote = dr["financialnote"].ToString();
                string membershiptype = dr["feecategory"].ToString();
                string familydiscount = dr["familymember"].ToString();
                string boatinstorage = dr["boatstorage"].ToString();
                

                if (birthdate != "")
                {
                    birthdate = Convert.ToDateTime(birthdate).ToString("dd MMM yyyy");
                }

                dr.Close();

                cmd.CommandText = "get_person_phone";
                dr = cmd.ExecuteReader();

                XElement phonerepeater = new XElement("PhoneRepeater");

                while (dr.Read())
                {
                    string phonenumber = dr["Phone"].ToString();

                    XElement phone = new XElement("Phone",
                        new XElement("number", phonenumber));

                    phonerepeater.Add(phone);
                }
                dr.Close();

                cmd.CommandText = "get_person_parentcargiver";
                dr = cmd.ExecuteReader();

                XElement parentrepeater = new XElement("ParentRepeater");

                while (dr.Read())
                {
                    string parentname = dr["name"].ToString();
                    string parentemail = dr["name"].ToString();
                    string parentphone = dr["phone"].ToString();

                    XElement parent = new XElement("Parent",
                         new XElement("name", parentname),
                         new XElement("email", parentemail)
                    );

                    //XElement Xparentphone = new XElement("phone");
                    string[] parentphoneparts = parentphone.Split('|');
                    foreach(string part in parentphoneparts)
                    {
                        XElement Xparentphone = new XElement("Phone",
                            new XElement("number", part)
                            );
                        parent.Add(Xparentphone);
                    }
                    
                    parentrepeater.Add(parent);
                }
                dr.Close();

                

                XDocument doc = new XDocument(
                    new XElement("Root",
                        new XElement("firstname", firstname),
                        new XElement("lastname", lastname),
                        new XElement("person_id", person_id),
                        new XElement("firstname", firstname),
                        new XElement("lastname", lastname),
                        new XElement("birthdate", birthdate),
                        new XElement("gender", gender),
                        new XElement("school", school),
                        new XElement("schoolyear", schoolyear),
                        new XElement("medical", medical),
                        new XElement("dietary", dietary),
                        new XElement("emailaddress", emailaddress),
                        new XElement("residentialaddress", residentialaddress),
                        new XElement("swimmer", swimmer),
                        new XElement("invoicerecipient", invoicerecipient),
                        new XElement("invoicetype", invoicetype),
                        new XElement("invoiceaddress", invoiceaddress),
                        new XElement("membershiptype", membershiptype),
                        new XElement("familydiscount", familydiscount),
                        new XElement("boatinstorage", boatinstorage),
                        phonerepeater,
                        parentrepeater
                   ));

                string x = "1";
            }
            dr.Close();
            con.Close();
            con.Dispose();

        }
    }
}