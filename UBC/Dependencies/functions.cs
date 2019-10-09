using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace UBC.Dependencies
{
    public class functions
    {
        public static void tracker(string person_id = "", string person_guid = "", string url = "")
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;


            cmd.CommandText = "Add_Tracker";
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
            cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = person_guid;
            cmd.Parameters.Add("@url", SqlDbType.VarChar).Value = url;

            cmd.Connection = con;
            try
            {
                con.Open();
                //string result = cmd.ExecuteScalar().ToString();
                cmd.ExecuteNonQuery();
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