using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
//using System.Text;

//using System.Web.Script.Services;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

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
        public void updatelistitem(string list_item_id, string list_id, string label, string value)   
        {
            standardResponseClass standardResponse = new standardResponseClass();

            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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
        public void get_system(string group_id)
        {
            List<GroupSystem> GroupSystemList = new List<GroupSystem>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_system", con);
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
                            system_id = dr["system_id"].ToString(),
                            systemname = dr["systemname"].ToString()
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
        public void get_group_persons(string group_id)
        {
            List<GroupPerson> GroupPersonList = new List<GroupPerson>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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
                            personname = dr["personname"].ToString(),
                            role_id = dr["role_id"].ToString(),
                            roledescription = dr["roledescription"].ToString()
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
        public void get_school(string group_id)
        {
            List<schoolClass> SchoolList = new List<schoolClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
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
        public string systemname;
    }
    public class GroupPerson
    {
        public string group_person_id;
        public string person_id;
        public string personname;
        public string role_id;
        public string roledescription;
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
        public string gendertype;
        public string authority;
        public string decile;
        public string moenumber;
        public string type;
        public string startyear;
        public string endyear;
    }

    public class standardResponseClass
    {
        public string created_id;
        public string status;
        public string message;
    }
    #endregion
}
