using System;
using System.Collections.Generic;
//using System.Linq;
//using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
//using System.IO;
//using System.Text;

//using System.Web.Script.Services;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

using System.Net.Http;
using System.Xml;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Net;

namespace Online.data
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
        public void RestFulClient(string type, string URL)
        {
            List<TestList> resultlist = new List<TestList>();


            System.Xml.Linq.XDocument xDocument = System.Xml.Linq.XDocument.Load(URL);

            var xmlDocument = new XmlDocument();
            using (var xmlReader = xDocument.CreateReader())
            {
                xmlDocument.Load(xmlReader);
            }


            string passresult = Newtonsoft.Json.JsonConvert.SerializeXmlNode(xmlDocument);

            /*  THIS WORKS BUT I WANT TO PASS THE 'DOCUMENT' BACK AS JSON
                        try
                        {
                            System.Xml.XmlReader xr = System.Xml.XmlReader.Create(URL);
                            while (xr.Read())
                            {
                                if (xr.NodeType == System.Xml.XmlNodeType.Element)
                                {
                                    if (xr.Name == "d:Name")
                                    {
                                        resultlist.Add(new TestList
                                        {
                                            id = "Name",
                                            value = xr.ReadElementContentAsString()
                                        });
                                        break;
                                    }
                                }
                            }
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e.Message);
                        }


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultlist);

            */

            Context.Response.Write(passresult);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void CharityInformation(string param1)
        {
            //List<TestList> resultlist = new List<TestList>();
            string response = "Charity not found";

            try
            {

                System.Xml.XmlReader xr = System.Xml.XmlReader.Create("http://www.odata.charities.govt.nz/Organisations?$filter=CharityRegistrationNumber eq '" + param1 + "'");

                while (xr.Read())
                {
                    if (xr.NodeType == System.Xml.XmlNodeType.Element)
                    {
                        if (xr.Name == "d:Name")
                        {
                            response = xr.ReadElementContentAsString();
                            /*
                            resultlist.Add(new TestList
                            {
                                id = "Name",
                                value = xr.ReadElementContentAsString()
                            });
                            */
                            break;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            JavaScriptSerializer JS = new JavaScriptSerializer();

            Context.Response.Write(JS.Serialize(response));


        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void FoodGrading(string businessname, string address, string grade)
        {

            List<foodgrading> foodgradingList = new List<foodgrading>();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_Food_Gradings", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@businessname", SqlDbType.VarChar).Value = businessname;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = address;
            cmd.Parameters.Add("@grade", SqlDbType.VarChar).Value = grade;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        foodgradingList.Add(new foodgrading
                        {

                            businessname = dr["businessname"].ToString(),
                            address = dr["businessaddress"].ToString(),
                            grade = dr["grading"].ToString()
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
            Context.Response.Write(JS.Serialize(foodgradingList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void RIDChargesX(string property_no, int next_year)
        {


            List<RIDCharges> RIDChargesList = new List<RIDCharges>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_RID_ChargesNEW", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property_no;
            cmd.Parameters.Add("@nextyear", SqlDbType.Int).Value = next_year;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string method = dr["method"].ToString();
                        string units = dr["units"].ToString();
                        if (method == "Valuation")
                        {
                            units = string.Format("{0:C0}", Convert.ToDecimal(units));
                        }
                        string rate = dr["rate"].ToString();
                        if (rate == "")
                        {
                            rate = "0";
                        };
                        rate = rate.Replace("$", "0");
                        rate = string.Format("{0:C6}", Convert.ToDecimal(rate));

                        string amount = dr["amount"].ToString();
                        if (amount == "")
                        {
                            amount = "0";
                        };
                        amount = string.Format("{0:C2}", Convert.ToDecimal(amount));

                        RIDChargesList.Add(new RIDCharges
                        {

                            charge_type = dr["charge_type"].ToString(),
                            charge_description = dr["charge_description"].ToString(),
                            method = method,
                            units = units,
                            amount = amount,
                            rate = rate
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
        public void RIDCharges(string property_no, string year, string showamounts, string run_ctr)
        {

            List<RIDCharges> RIDChargesList = new List<RIDCharges>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_RID_Charges", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.Int).Value = property_no;
            cmd.Parameters.Add("@showamounts", SqlDbType.Int).Value = showamounts;
            cmd.Parameters.Add("@year", SqlDbType.VarChar).Value = year;
            cmd.Parameters.Add("@run_ctr", SqlDbType.Int).Value = run_ctr;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string method = dr["method"].ToString();
                        string units = dr["units"].ToString();
                        if (method == "Valuation")
                        {
                            units = string.Format("{0:C0}", Convert.ToDecimal(units));
                        }
                        string rate = dr["rate"].ToString();
                        if (rate == "")
                        {
                            rate = "0";
                        };
                        rate = rate.Replace("$", "0");
                        rate = string.Format("{0:C6}", Convert.ToDecimal(rate));

                        string amount = dr["amount"].ToString();
                        if (amount == "")
                        {
                            amount = "0";
                        };
                        amount = string.Format("{0:C2}", Convert.ToDecimal(amount));

                        RIDChargesList.Add(new RIDCharges
                        {

                            charge_type = dr["charge_type"].ToString(),
                            charge_description = dr["charge_description"].ToString(),
                            method = method,
                            units = units,
                            amount = amount,
                            rate = rate
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
        public void Consents(string property_no)
        {

            List<Consents> ConsentsList = new List<Consents>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_Consents", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.Int).Value = property_no;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                        //amount = string.Format("{0:C2}", Convert.ToDecimal(amount));

                        ConsentsList.Add(new Consents
                        {
                            //group = dr["group"].ToString(),
                            ram_year = dr["ram_year"].ToString(),
                            ram_id = dr["ram_id"].ToString(),
                            category = dr["category"].ToString(),
                            description = dr["description"].ToString(),
                            //estimated_cost = dr["estimated_cost"].ToString(),
                            decision = dr["decision"].ToString()
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
            Context.Response.Write(JS.Serialize(ConsentsList));

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void RIDHeader(string property_no)
        {
            List<RIDHeader> RIDHeaderList = new List<RIDHeader>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_RID_Header", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property_no;
            //cmd.Parameters.Add("@nextyear", SqlDbType.Int).Value = next_year;

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
                            //Land_value = dr["Land_value"].ToString(),
                            //Capital_value = dr["Capital_value"].ToString(),
                            Land_value = string.Format("{0:C0}", dr["Land_value"]),
                            Capital_value = string.Format("{0:C0}", dr["Capital_value"]),
                            New_Land_value = string.Format("{0:C0}", dr["New_Land_value"]),
                            New_Capital_value = string.Format("{0:C0}", dr["New_Capital_value"]),
                            //This_year = dr["This_year"].ToString(),
                            //Show_next_year = dr["Show_next_year"].ToString(),
                            //Show_amounts = dr["Show_amounts"].ToString()
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
                            Location = dr["Location"].ToString(),
                            AccessID = dr["accessid"].ToString(),
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

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
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
        public void GetAnnualRates(string property, string year)
        {
            string response = "0";
            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_Annual_Rates", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property;
            cmd.Parameters.Add("@year", SqlDbType.VarChar).Value = year;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();

                    response = dr["rates"].ToString();
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


            //JavaScriptSerializer JS = new JavaScriptSerializer();

            //Context.Response.Write(JS.Serialize(response));
            Context.Response.Write(response);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GetAnnualHorizonsRates(string property)
        {
            string response = "0";
            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GET_AnnualHorizons_Rates", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@prop_no", SqlDbType.VarChar).Value = property;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();

                    response = dr["rates"].ToString();
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


            //JavaScriptSerializer JS = new JavaScriptSerializer();

            //Context.Response.Write(JS.Serialize(response));
            Context.Response.Write(response);

        }


        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void EntitySearch(string term, string mode, string system="")
        {
            List<EntityClass> EntityList = new List<EntityClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("EntitySearch", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;
            cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = system;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        EntityList.Add(new EntityClass
                        {
                            label = dr["name"].ToString(),
                            value = dr["Entity_CTR"].ToString(),
                            residentialaddress = dr["residentialaddress"].ToString(),
                            reference = dr["reference"].ToString()
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
            Context.Response.Write(JS.Serialize(EntityList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void NZPostAddressSearch(string term)
        {
            //WDCFunctions.WDCFunctions.Log("NZPostAddressSearch", "Term=" + term, "");
            List<LabelResponse> LabelResponseList = new List<LabelResponse>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            // GREG 31/8/2017 // String strConnString = "Data Source=192.168.1.225;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";  // GREG 31/8/2017

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
        public void entity_usernameemailaddress(string usernameemailaddress, string entity_ctr)
        {

            string response;

           String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("usernameemailaddress_check", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@usernameemailaddress", SqlDbType.VarChar).Value = usernameemailaddress;
            cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = entity_ctr;
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
            if (response != "")
            {
                Context.Response.Write(JS.Serialize(response));
            }
            else
            {
                Context.Response.Write(JS.Serialize(true));
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void contractor_usernameemailaddress(string usernameemailaddress, string contractor_ctr)
        {

            string response;

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("contractor_usernameemailaddress_check", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@usernameemailaddress", SqlDbType.VarChar).Value = usernameemailaddress;
            cmd.Parameters.Add("@contractor_ctr", SqlDbType.VarChar).Value = contractor_ctr;
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
            if (response != "")
            {
                Context.Response.Write(JS.Serialize(response));
            }
            else
            {
                Context.Response.Write(JS.Serialize(true));
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void entity_username(string tb_username)
        {

            string response;

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("username_check", con);
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
            if (response != "")
            {
                Context.Response.Write(JS.Serialize(response));
            }
            else
            {
                Context.Response.Write(JS.Serialize(true));
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void communitycontracts_emailaddress(string tb_emailaddress, string submissionperiod)
        {

            string response;

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("cc_emailaddress_check", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@submissionperiod", SqlDbType.VarChar).Value = submissionperiod;
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
            if (response != "")
            {
                Context.Response.Write(JS.Serialize(response));
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

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
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

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
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
        public void MapInformation(string module)
        {

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GetFile(string filename)
        {
            //string text = System.IO.File.ReadAllText(filename);
            //Context.Response.Write(text);

            FileStream MyFileStream;
            long FileSize;

            MyFileStream = new FileStream(filename, FileMode.Open);
            FileSize = MyFileStream.Length;

            byte[] Buffer = new byte[(int)FileSize];
            MyFileStream.Read(Buffer, 0, (int)FileSize);
            MyFileStream.Close();

            Context.Response.BinaryWrite(Buffer);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GetFileCheckSum(string filename)
        {
            string CheckSum = "";
            //byte[] CheckSum = null;
            if(File.Exists(filename))
            {
                using (var md5 = MD5.Create())
                {
                    using (var stream = File.OpenRead(filename))
                    {
                        //CheckSum = md5.ComputeHash(stream);
                        //CheckSum = System.Text.Encoding.Default.GetString(md5.ComputeHash(stream));
                        CheckSum = Convert.ToBase64String(md5.ComputeHash(stream));
                    }
                }
            } else
            {
                CheckSum = "Does not exist";
            }
            Context.Response.Write(CheckSum);

        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GetSQLCheckSum(string routinename)
        {
            string routine = "";

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_sql_routine", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@routinename", SqlDbType.VarChar).Value = routinename;
            cmd.Connection = con;
            try
            {
                con.Open();
                routine = cmd.ExecuteScalar().ToString();

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


            string CheckSum = "";

            if (routine != "")
            {
                using (var md5 = MD5.Create())
                {
                    CheckSum = BitConverter.ToString(md5.ComputeHash(Encoding.UTF8.GetBytes(routine)));
                }
            }
            else
            {
                CheckSum = "Does not exist";
            }
            Context.Response.Write(CheckSum);
        }
    }

    #region classes
    public class TestClass
    {
        public string id;
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
    public class EntityClass
    {
        public string label;   //name
        public string value;   //entity_ctr
        public string residentialaddress;
        public string reference;
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
        public string AccessID;
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
        //public string This_year;
        //public string Show_next_year;
        //public string Show_amounts;
        public string New_Land_value;
        public string New_Capital_value;
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

    public class Consents
    {
        //public string group;
        public string ram_year;
        public string ram_id;
        public string category;
        public string description;
        //public string estimated_cost;
        public string decision;
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

    public class updateresultClass
    {
        public string status;
        public string message;
        public string id;  //added record
    }

    #endregion
}
