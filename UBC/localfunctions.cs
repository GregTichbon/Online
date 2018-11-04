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

namespace UBC
{
    public class localfunctions
    {

        public static string get_person_category (string person_id)
        {
            string guid = get_person_guid(person_id);

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_person_category", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
            cmd1.Parameters.Add("@options", SqlDbType.VarChar).Value = "|string|";
            cmd1.Connection = con;
            try
            {
                con.Open();
                return (cmd1.ExecuteScalar().ToString());
  
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

        public static string get_person_guid(string person_id)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_person_guid", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;

            cmd1.Connection = con;
            try
            {
                con.Open();
                return (cmd1.ExecuteScalar().ToString());

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