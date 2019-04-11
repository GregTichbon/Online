using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

using System.Web.Script.Serialization;


namespace Online.TestAndPlay
{
    public partial class NestedList2 : System.Web.UI.Page
    {
        //public string passresult = "";

        //public string EnrolementID = "";
        //public string name = "";
        //public string address = "";

        //public string LastEnrolementID = "";
        //public string Lastname = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //var Personlist = new List<PersonClass>();
            //var Addresslist = new List<AddressClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            //SqlConnection con = new SqlConnection(strConnString);
            //SqlCommand cmd = new SqlCommand("Get_Pickups", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Add("@program", SqlDbType.Int).Value = 1;
            //cmd.Connection = con;
            //try
            //{
            //    con.Open();
            //    SqlDataReader dr = cmd.ExecuteReader();
            //    if (dr.HasRows)
            //    {
            //        while (dr.Read())
            //        {
            //            EnrolementID = dr["EnrolementID"].ToString();
            //            name = dr["name"].ToString();
            //            address = dr["address"].ToString();


            //            if (EnrolementID != LastEnrolementID)
            //            {
            //                if (LastEnrolementID != "")
            //                {
            //                    Personlist.Add(new PersonClass()
            //                    {
            //                        enrollmentId = LastEnrolementID,
            //                        name = Lastname,
            //                        address = Addresslist
            //                    });
            //                    Addresslist.Clear();
            //                }
            //                LastEnrolementID = EnrolementID;
            //                Lastname = name;
            //            }
            //            Addresslist.Add(new AddressClass()
            //            {
            //                address = address
            //            });
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}
            //finally
            //{
            //    con.Close();
            //    con.Dispose();
            //}

            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //passresult = JS.Serialize(Personlist);


        }
    }

    //public class PersonClass
    //{
    //    public string enrollmentId;
    //    public string name;
    //    public List<AddressClass> address;
    //}
    //public class AddressClass
    //{
    //    public string address;
    //}

}