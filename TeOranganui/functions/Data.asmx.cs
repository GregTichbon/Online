using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace TeOranganui.data
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
            standardResponse.status = "teoranganui.datainn.co.nz";
            standardResponse.message = myvalue;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(standardResponse));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void updatelistitem(string list_item_id, string list_id, string label, string value)   
        {
            standardResponseClass standardResponse = new standardResponseClass();
            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("update_list_item", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@List_item_ID", SqlDbType.VarChar).Value = list_item_id;
            cmd.Parameters.Add("@List_ID", SqlDbType.VarChar).Value = list_id;  //0 = insert
            cmd.Parameters.Add("@label", SqlDbType.VarChar).Value = label;
            cmd.Parameters.Add("@value", SqlDbType.VarChar).Value = value;  //-1 = Delete

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();

                standardResponse.created_id = dr["created_id"].ToString();
                standardResponse.status = dr["status"].ToString();
                standardResponse.message = dr["message"].ToString();
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
            Context.Response.Write(JS.Serialize(standardResponse));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GroupSearch(string grouptype, string name)
        {
            List<GroupRecord> GroupRecordList = new List<GroupRecord>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Search_Groups", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@grouptype", SqlDbType.VarChar).Value = grouptype;
            cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = name;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        GroupRecordList.Add(new GroupRecord
                        {
                            name = dr["Name"].ToString(),
                            group_type = dr["group_type"].ToString(),
                            group_id = dr["group_id"].ToString()

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
            Context.Response.Write(JS.Serialize(GroupRecordList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GroupAutoComplete(string term)
        {
            List<GroupRecord> GroupRecordList = new List<GroupRecord>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GroupAutoComplete", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@name", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        GroupRecordList.Add(new GroupRecord
                        {
                            name = dr["Name"].ToString(),
                            group_type = dr["group_type"].ToString(),
                            group_id = dr["group_id"].ToString(),
                            label = dr["Name"].ToString() + " - " + dr["group_type"].ToString()
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
            Context.Response.Write(JS.Serialize(GroupRecordList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_grouptype()
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_grouptype", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["description"].ToString(),
                            value = dr["grouptype_id"].ToString()
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
            Context.Response.Write(JS.Serialize(dropdownlist));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_list(int dd_grouptype)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_list", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@grouptype_id", SqlDbType.Int).Value = dd_grouptype;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["name"].ToString(),
                            value = dr["list_id"].ToString()
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
            Context.Response.Write(JS.Serialize(dropdownlist));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_list_item(int list_id)
        {
            List<list_itemClass> list_itemlist = new List<list_itemClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_list_item", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@list_id", SqlDbType.Int).Value = list_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        list_itemlist.Add(new list_itemClass
                        {
                            List_item_ID = Convert.ToInt32(dr["List_item_ID"]),
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString(),
                            count = "23"
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
            Context.Response.Write(JS.Serialize(list_itemlist));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_groupnarrative(int group_id)
        {
            List<narrativeClass> narrativelist = new List<narrativeClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_groupnarrative", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;
            //cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        narrativelist.Add(new narrativeClass
                        {
                            groupnarrative_id = dr["groupnarrative_id"].ToString(),
                            group_id = dr["group_id"].ToString(),
                            date = dr["date"].ToString(),
                            user_id = dr["user_id"].ToString(),
                            narrative = dr["narrative"].ToString(),
                            action = dr["action"].ToString(),
                            action_user_id = dr["action_user_id"].ToString(),
                            action_date = dr["action_date"].ToString()
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
            Context.Response.Write(JS.Serialize(narrativelist));
        }
        
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_group_system(string group_id)
        {
            List<GroupSystem> GroupSystemList = new List<GroupSystem>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_group_system", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        GroupSystemList.Add(new GroupSystem
                        {
                            group_system_id = dr["group_system_id"].ToString(),
                            system_id = dr["system_id"].ToString()
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
            Context.Response.Write(JS.Serialize(GroupSystemList));
        }

        
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_school_programme(string group_id)
        {
            List<SchoolProgrammeClass> school_programmeList = new List<SchoolProgrammeClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_school_programme", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        school_programmeList.Add(new SchoolProgrammeClass
                        {
                            School_Programme_ID = dr["School_Programme_ID"].ToString(),
                            group_id = dr["group_id"].ToString(),
                            list_item_id = dr["list_item_id"].ToString(),
                            startdate = dr["startdate"].ToString(),
                            enddate = dr["enddate"].ToString(),
                            note = dr["note"].ToString()
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
            Context.Response.Write(JS.Serialize(school_programmeList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_groupcommunication(string group_id)
        {
            List<CommunicationClass> GroupCommunicationsList = new List<CommunicationClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_groupcommunication", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        GroupCommunicationsList.Add(new CommunicationClass
                        {
                            communication_id = dr["groupcommunication_id"].ToString(),
                            parent_id = dr["group_id"].ToString(),
                            communicationtype_id = dr["communicationtype_id"].ToString(),
                            detail = dr["detail"].ToString(),
                            note = dr["note"].ToString(),
                            current = dr["current"].ToString()

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
            Context.Response.Write(JS.Serialize(GroupCommunicationsList));
        }
        
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_group_persons(string group_id)
        {
            List<GroupPerson> GroupPersonList = new List<GroupPerson>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_group_persons", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        GroupPersonList.Add(new GroupPerson
                        {
                            group_person_id = dr["group_person_id"].ToString(),
                            person_id = dr["person_id"].ToString(),
                            role_id = dr["role_id"].ToString()
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
            Context.Response.Write(JS.Serialize(GroupPersonList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_person(string person_id)
        {
            List<personClass> personList = new List<personClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_person", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = person_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        personList.Add(new personClass
                        {
                            lastname = dr["lastname"].ToString(),
                            firstname = dr["firstname"].ToString(),
                            gender = dr["gender"].ToString(),
                            notes = dr["notes"].ToString()
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
            Context.Response.Write(JS.Serialize(personList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_personaddress(string person_id)
        {
            List<personaddressClass> personaddressList = new List<personaddressClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_personaddress", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = person_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        personaddressList.Add(new personaddressClass
                        {
                            personaddress_id = dr["personaddress_id"].ToString(),
                            addresstype_id = dr["addresstype_id"].ToString(),
                            detail = dr["detail"].ToString(),
                            note = dr["note"].ToString(),
                            current = dr["current"].ToString()
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
            Context.Response.Write(JS.Serialize(personaddressList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_personcommunication(string person_id)
        {
            List<CommunicationClass> personCommunicationsList = new List<CommunicationClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_personcommunication", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = person_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        personCommunicationsList.Add(new CommunicationClass
                        {
                            communication_id = dr["personcommunication_id"].ToString(),
                            parent_id = dr["person_id"].ToString(),
                            communicationtype_id = dr["communicationtype_id"].ToString(),
                            detail = dr["detail"].ToString(),
                            note = dr["note"].ToString(),
                            current = dr["current"].ToString()

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
            Context.Response.Write(JS.Serialize(personCommunicationsList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_school_policy(string group_id)
        {
            List<SchoolPolicyClass> school_policyList = new List<SchoolPolicyClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_school_policy", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        school_policyList.Add(new SchoolPolicyClass
                        {
                            School_Policy_ID = dr["School_policy_ID"].ToString(),
                            group_id = dr["group_id"].ToString(),
                            list_item_id = dr["list_item_id"].ToString(),
                            DateImplemented = dr["DateImplemented"].ToString(),
                            DateReview = dr["DateReview"].ToString(),
                            ReviewDone = dr["ReviewDone"].ToString(),
                            note = dr["note"].ToString()
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
            Context.Response.Write(JS.Serialize(school_policyList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_school_accreditation(string group_id)
        {
            List<SchoolAccreditationClass> school_AccreditationList = new List<SchoolAccreditationClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_school_Accreditation", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        school_AccreditationList.Add(new SchoolAccreditationClass
                        {
                            School_Accreditation_ID = dr["School_Accreditation_ID"].ToString(),
                            group_id = dr["group_id"].ToString(),
                            list_item_id = dr["list_item_id"].ToString(),
                            DateAccredited = dr["DateAccredited"].ToString(),
                            DateReview = dr["DateReview"].ToString(),
                            ReviewDone = dr["ReviewDone"].ToString(),
                            note = dr["note"].ToString()
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
            Context.Response.Write(JS.Serialize(school_AccreditationList));
        }
        
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_group_person_links(string person_id)
        {
            List<grouppersonlinkClass> grouppersonlinksList = new List<grouppersonlinkClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_group_person_links", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@person_id", SqlDbType.Int).Value = person_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        grouppersonlinksList.Add(new grouppersonlinkClass
                        {
                            Group = dr["Group"].ToString(),
                            Role = dr["Role"].ToString()
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
            Context.Response.Write(JS.Serialize(grouppersonlinksList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_dropdown(string type, string param1 = "")
        {
            List<dropdownClass> DropDownList = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_dropdown", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.Add("@param1", SqlDbType.VarChar).Value = param1;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        DropDownList.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
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
            Context.Response.Write(JS.Serialize(DropDownList));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_school(string group_id)
        {
            List<schoolClass> SchoolList = new List<schoolClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["HFConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_school", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@group_id", SqlDbType.Int).Value = group_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                { 
                    dr.Read();
                    SchoolList.Add(new schoolClass
                    {
                        groupname = dr["groupname"].ToString(),
                        gendertype = dr["gendertype"].ToString(),
                        authority = dr["authority"].ToString(),
                        decile = dr["decile"].ToString(),
                        moenumber = dr["moenumber"].ToString(),
                        type = dr["type"].ToString(),
                        startyear = dr["startyear"].ToString(),
                        endyear = dr["endyear"].ToString()
                    });
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
            Context.Response.Write(JS.Serialize(SchoolList));
        }
    }
    #region classes
 

    public class GroupRecord
    {
        public string name;
        public string group_type;
        public string group_id;
        public string label;
    }
    public class GroupSystem
    {
        public string group_system_id;
        public string system_id;
    }
    public class GroupPerson
    {
        public string group_person_id;
        public string person_id;
        public string role_id;
    }
    public class dropdownClass
    {
        public string label;
        public string value;
    }
    public class list_itemClass
    {
        public int List_item_ID;
        public string label;
        public string value;
        public string count;
    }
    public class schoolClass
    {
        public string groupname;
        public string gendertype;
        public string authority;
        public string decile;
        public string moenumber;
        public string type;
        public string startyear;
        public string endyear;
    }

    public class personClass
    {
        public string lastname;
        public string firstname;
        public string gender;
        public string notes;
    }

    public class personaddressClass
    {
        public string personaddress_id;
        public string addresstype_id;
        public string detail;
        public string note;
        public string current;
    }

    public class grouppersonlinkClass
    {
        public string Group;
        public string Role;
    }

    public class narrativeClass
    {
        public string groupnarrative_id;
        public string group_id;
        public string date;
        public string user_id;
        public string narrative;
        public string action;
        public string action_user_id;
        public string action_date;
    }

    public class CommunicationClass
    {
        public string communication_id;
        public string parent_id;
        public string communicationtype_id;
        public string detail;
        public string note;
        public string current;
    }

    public class SchoolProgrammeClass
    {
        public string School_Programme_ID;
        public string group_id;
        public string list_item_id;
        public string startdate;
        public string enddate;
        public string note;
    }

    public class SchoolPolicyClass
    {
        public string School_Policy_ID;
        public string group_id;
        public string list_item_id;
        public string DateImplemented;
        public string DateReview;
        public string ReviewDone;
        public string note;
    }

    public class SchoolAccreditationClass
    {
        public string School_Accreditation_ID;
        public string group_id;
        public string list_item_id;
        public string DateAccredited;
        public string DateReview;
        public string ReviewDone;
        public string note;
    }

    public class standardResponseClass
    {
        public string created_id;
        public string status;
        public string message;
    }
    #endregion
}
