using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace TichbonKumeroa.Accounts
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS
   
    public class data : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_account_options()
        {
            List<accountoptionsClass> list_accountoptions = new List<accountoptionsClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["TKConnectionString"].ConnectionString;
            //string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_account_options", con);
            cmd.CommandType = CommandType.StoredProcedure;

            //cmd.Parameters.Add("@list_id", SqlDbType.Int).Value = list_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        list_accountoptions.Add(new accountoptionsClass
                        {
                            fullaccount = dr["fullaccount"].ToString()
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
            Context.Response.Write(JS.Serialize(list_accountoptions));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_coding_options()
        {
            List<codingoptionsClass> list_codingoptions = new List<codingoptionsClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["TKConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_coding_options", con);
            cmd.CommandType = CommandType.StoredProcedure;

            //cmd.Parameters.Add("@list_id", SqlDbType.Int).Value = list_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        list_codingoptions.Add(new codingoptionsClass
                        {
                            codeid = dr["codeid"].ToString(),
                            type = dr["type"].ToString(),
                            area = dr["area"].ToString(),
                            detail = dr["detail"].ToString()
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
            Context.Response.Write(JS.Serialize(list_codingoptions));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_transactions(string account, string creditcard, string uncoded, string datefrom, string dateto, string search, string coded)
        {
            List<transactionsClass> list_transactions = new List<transactionsClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["TKConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_transactions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@account", SqlDbType.VarChar).Value = account;
            cmd.Parameters.Add("@creditcard", SqlDbType.VarChar).Value = creditcard;
            cmd.Parameters.Add("@uncoded", SqlDbType.VarChar).Value = uncoded;
            cmd.Parameters.Add("@datefrom", SqlDbType.VarChar).Value = datefrom;
            cmd.Parameters.Add("@dateto", SqlDbType.VarChar).Value = dateto;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = search;
            cmd.Parameters.Add("@coded", SqlDbType.VarChar).Value = coded;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        list_transactions.Add(new transactionsClass
                        {
                            transactionid = dr["transactionid"].ToString(),
                            account = dr["account"].ToString(),
                            type = dr["type"].ToString(),
                            posteddate = dr["posteddate"].ToString(),
                            transactiondate = dr["transactiondate"].ToString(),
                            amount = dr["amount"].ToString(),
                            name = dr["name"].ToString(),
                            memo = dr["memo"].ToString(),
                            query = dr["query"].ToString(),
                            recurringcreated = dr["recurringcreated"].ToString()
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
            Context.Response.Write(JS.Serialize(list_transactions));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void get_items(string transactionid)
        {
            List<itemsClass> list_items = new List<itemsClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["TKConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("get_items", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@transactionid", SqlDbType.VarChar).Value = transactionid;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        list_items.Add(new itemsClass
                        {

                            itemid = dr["itemid"].ToString(),
                            narrative = dr["narrative"].ToString(),
                            code = dr["code"].ToString(),
                            amount = dr["amount"].ToString(),
                            query = dr["query"].ToString(),
                            invoice = dr["invoice"].ToString(),
                            invoicenarrative = dr["invoicenarrative"].ToString(),
                            invoicenotes = dr["invoicenotes"].ToString()
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
            Context.Response.Write(JS.Serialize(list_items));
        }
    }

    #region classes
    public class accountoptionsClass
    {
        public string fullaccount;
    }

    public class codingoptionsClass
    {
        public string codeid;
        public string type;
        public string area;
        public string detail;

    }

    public class transactionsClass
    {
        public string transactionid;
        public string account;
        public string type;
        public string posteddate;
        public string transactiondate;
        public string amount;
        public string name;
        public string memo;        
        public string query;        
        public string recurringcreated;
    }

    public class itemsClass
    {
        public string itemid;
        public string narrative;
        public string code;
        public string amount;
        public string query;
        public string invoice;
        public string invoicenarrative;
        public string invoicenotes;
    }

    #endregion classes
}
