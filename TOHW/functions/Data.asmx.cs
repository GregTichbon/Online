using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace TOHW.data
{
 /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS

    public class Data : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void test(string myvalue)
        {
            standardResponseClass standardResponse = new standardResponseClass();
            standardResponse.created_id = "created_id";
            standardResponse.status = "whanganui.teorahou.org.nz";
            standardResponse.message = myvalue;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(standardResponse));
        }
        
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void TestMethodGet(string mode, string param1)
        {

            if (mode == "List")
            {
                List<TestList> resultlist = new List<TestList>();

                resultlist.Add(new TestList
                {
                    id = "1",
                    value = param1
                });
                resultlist.Add(new TestList
                {
                    id = "2",
                    value = "Black"
                });
                resultlist.Add(new TestList
                {
                    id = "3",
                    value = "Blue"
                });
                resultlist.Add(new TestList
                {
                    id = "4",
                    value = "Red"
                });
                resultlist.Add(new TestList
                {
                    id = "5",
                    value = "White"
                });

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultlist);

                Context.Response.Write(passresult);
            }
            else
            {
                TestClass resultclass = new TestClass();
                resultclass.id = param1;

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                Context.Response.Write(passresult);
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_encounters(int id)
        {
            List<Encounter> EncounterList = new List<Encounter>();
            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("GET_Encounters", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@entityid", SqlDbType.VarChar).Value = id;
            cmd.Connection = con;

            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        EncounterList.Add(new Encounter
                        {
                            encounterid = Convert.ToInt16(dr["encounterid"]) ,
                            startdatetime = dr["startdatetime"].ToString(),
                            enddatetime = dr["enddatetime"].ToString(),
                            narrative = dr["narrative"].ToString(),
                            worker_entityid = Convert.ToInt16(dr["worker_entityid"]),
                            worker_name = dr["worker_name"].ToString()
                        });
                    }
                }
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(EncounterList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void RIDCharges(string property_no, string year, string next_year)
        {


            List<RIDCharges> RIDChargesList = new List<RIDCharges>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_RID_ChargesNEW", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property_no;
            cmd.Parameters.Add("@year", SqlDbType.VarChar).Value = year;
            cmd.Parameters.Add("@nextyear", SqlDbType.VarChar).Value = next_year;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        RIDChargesList.Add(new RIDCharges
                        {

                            charge_type = dr["charge_type"].ToString(),
                            charge_description = dr["charge_description"].ToString(),
                            method = dr["method"].ToString(),
                            units = dr["units"].ToString(),
                            rate = dr["rate"].ToString(),
                            amount = dr["amount"].ToString()

                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(RIDChargesList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void RIDHeader(string property_no, string next_year)
        {


            List<RIDHeader> RIDHeaderList = new List<RIDHeader>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_RID_HeaderNEW", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property_no;
            cmd.Parameters.Add("@nextyear", SqlDbType.VarChar).Value = next_year;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        RIDHeaderList.Add(new RIDHeader
                        {

                            Assessment_number = dr["Assessment_number"].ToString(),
                            Address = dr["Address"].ToString(),
                            Legal_description = dr["Legal_description"].ToString(),
                            Area = dr["Area"].ToString(),
                            Certificates_of_title = dr["Certificates_of_title"].ToString(),
                            Land_value = dr["Land_value"].ToString(),
                            Capital_value = dr["Capital_value"].ToString(),
                            This_year = dr["This_year"].ToString(),
                            Next_year = dr["Next_year"].ToString(),
                            Show_amounts = dr["Show_amounts"].ToString()

                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(RIDHeaderList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void CemeterySearch(string surname, string forenames)
        {


            List<BurialRecord> BurialRecordList = new List<BurialRecord>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("cemeterysearch", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@surname", SqlDbType.VarChar).Value = surname;
            cmd.Parameters.Add("@forenames", SqlDbType.VarChar).Value = forenames;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        BurialRecordList.Add(new BurialRecord
                        {
                            Name = dr["Name"].ToString(),
                            Age = dr["Age"].ToString(),
                            Date_of_Death = dr["Date_of_Death"].ToString(),
                            Gender = dr["Gender"].ToString(),

                            Warrant = dr["Warrant"].ToString(),
                            Date_of_Burial = dr["Date_of_Burial"].ToString(),
                            Date_of_Birth = dr["Date_of_Birth"].ToString(),
                            Residence = dr["Residence"].ToString(),
                            Occupation = dr["Occupation"].ToString(),
                            Minister = dr["Minister"].ToString(),
                            Director = dr["Director"].ToString(),

                            Date_of_Medical_Certificate = dr["Date_of_Medical_Certificate"].ToString(),
                            Marital_Status = dr["Marital_Status"].ToString(),
                            Place_of_Death = dr["Place_of_Death"].ToString(),
                            Register_No = dr["Register_No"].ToString(),

                            Stillborn = dr["Stillborn"].ToString(),
                            Location = dr["Location"].ToString()
                            //,
                            //GISID = dr["GISID"].ToString()

                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(BurialRecordList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void PropertySelect(string term, string mode)
        {


            List<Property> PropertyList = new List<Property>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("usrPropertyAutoComplete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        PropertyList.Add(new Property
                        {
                            label = dr["formattedaddress"].ToString(),
                            value = dr["Property_No"].ToString(),
                            area = dr["area"].ToString(),
                            legaldescription = dr["legaldescription"].ToString(),
                            assessment_no = dr["assessment_no"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(PropertyList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void NZPostAddressSearch(string term)
        {

            //WDCFunctions.WDCFunctions.Log("NZPostAddressSearch", "Term=" + term, "");
            List<LabelResponse> LabelResponseList = new List<LabelResponse>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("NZPostAddressSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        LabelResponseList.Add(new LabelResponse
                        {
                            label = dr["search_line"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(LabelResponseList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void PriorUse(string fieldname, string term)
        {

            List<LabelResponse> LabelResponseList = new List<LabelResponse>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("PriorUse", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@fieldname", SqlDbType.VarChar).Value = fieldname;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        LabelResponseList.Add(new LabelResponse
                        {
                            label = dr["search_line"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(LabelResponseList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void communitycontracts_username(string tb_username)
        {

            string response;

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("cc_username_check", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = tb_username;
            cmd.Connection = con;
            try
            {
                con.Open();
                response = cmd.ExecuteScalar().ToString();

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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            if (response == "exists")
            {
                Context.Response.Write(JS.Serialize("This username already exists, try another one"));
            }
            else
            {
                Context.Response.Write(JS.Serialize(true));
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void ApplicationSelect(string term)
        {
            List<Application> ApplicationList = new List<Application>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_ApplicationDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        ApplicationList.Add(new Application
                        {
                            id = dr["ID"].ToString(),
                            description = dr["description"].ToString(),
                            type = dr["type"].ToString(),
                            propertyaddress = dr["propertyaddress"].ToString(),
                            businessname = dr["businessname"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(ApplicationList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void InvoiceAmounts(string type, string reference1, string reference2)
        {
            List<InvoiceAmounts> InvoiceAmountsList = new List<InvoiceAmounts>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_InvoiceAmounts", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.Add("@reference1", SqlDbType.VarChar).Value = reference1;
            cmd.Parameters.Add("@reference2", SqlDbType.VarChar).Value = reference2;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        InvoiceAmountsList.Add(new InvoiceAmounts
                        {
                            result = dr["Result"].ToString(),
                            detail = dr["detail"].ToString(),
                            amount = dr["amount"].ToString(),
                            gst = dr["gst"].ToString(),
                            balance = dr["balance"].ToString(),
                            transactionfee = dr["transactionfee"].ToString(),
                            surcharge = dr["surcharge"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(InvoiceAmountsList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void WMCCalendar(string start, string end)
        {

            List<wmccalendar> wmccalendarList = new List<wmccalendar>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_WMC_Calendar", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@start", SqlDbType.VarChar).Value = start;
            cmd.Parameters.Add("@end", SqlDbType.VarChar).Value = end;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        wmccalendarList.Add(new wmccalendar
                        {
                            type = dr["type"].ToString(),
                            start = dr["start"].ToString(),
                            end = dr["end"].ToString(),
                            allday = dr["allday"].ToString(),
                            status = dr["status"].ToString(),
                            expires = dr["expires"].ToString(),
                            title = dr["title"].ToString(),
                            description = dr["description"].ToString(),
                            notes = dr["notes"].ToString(),
                            publicdescription = dr["publicdescription"].ToString(),
                            url = dr["url"].ToString()
                        });
                    }
                }

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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(wmccalendarList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void pickup_update(int id, string address, string status, string assignedto)
        {
            string response;
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("pickup_update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
            cmd.Parameters.Add("@status", SqlDbType.VarChar).Value = status;
            cmd.Parameters.Add("@assignedto", SqlDbType.VarChar).Value = assignedto;

            cmd.Connection = con;
            try
            {
                con.Open();
                response = cmd.ExecuteScalar().ToString();

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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            if (response == "xxxxx")
            {
                Context.Response.Write(JS.Serialize("Update failed"));
            }
            else
            {
                Context.Response.Write(JS.Serialize(true));
            }
        }

    }
    #region classes
    public class TestClass
    {
        public string id;
    }

    public class Encounter
    {
        public int encounterid;
        public string startdatetime;
        public string enddatetime;
        public string narrative;
        public int worker_entityid;
        public string worker_name;
    }

    public class TestList
    {
        public string id;
        public string value;
    }

    public class InvoicePaymentResult
    {
        public string emailaddress;
    }

    public class Property
    {
        public string label;   //formated address
        public string value;   //property number
        public string area;
        public string legaldescription;
        public string assessment_no;
    }

    public class LabelResponse
    {
        public string label;
    }

    public class Application
    {
        public string id;  //RAM_process_ctr
        public string description;
        public string type;
        public string propertyaddress;
        public string businessname;
    }

    public class BurialRecord
    {
        public string Name;
        public string Age;
        public string Date_of_Death;
        public string Gender;

        public string Warrant;
        public string Date_of_Burial;
        public string Date_of_Birth;
        public string Residence;
        public string Occupation;
        public string Minister;
        public string Director;

        public string Date_of_Medical_Certificate;
        public string Marital_Status;
        public string Place_of_Death;
        public string Register_No;

        public string Stillborn;
        public string Location;
        //public string GISID;
    }

    public class RIDHeader
    {
        public string Assessment_number;
        public string Address;
        public string Legal_description;
        public string Area;
        public string Certificates_of_title;
        public string Land_value;
        public string Capital_value;
        public string This_year;
        public string Next_year;
        public string Show_amounts;
    }

    public class RIDCharges
    {
        public string charge_type;
        public string charge_description;
        public string method;
        public string units;
        public string rate;
        public string amount;
    }

    public class foodgrading
    {
        public string businessname;
        public string address;
        public string grade;
    }

    public class InvoiceAmounts
    {
        public string result;
        public string detail;
        public string amount;
        public string gst;
        public string balance;
        public string transactionfee;
        public string surcharge;
    }

    public class wmccalendar
    {
        public string type;
        public string start;
        public string end;
        public string allday;
        public string status;
        public string expires;
        public string title;
        public string description;
        public string notes;
        public string publicdescription;
        public string url;
    }
    public class standardResponseClass
    {
        public string created_id;
        public string status;
        public string message;
    }

    #endregion
}
