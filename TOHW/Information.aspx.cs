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

namespace TOHW
{
    public partial class Information : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            html += "<tr><th>Name</th><th>Status</th><th>Gender</th><th>Assigned</th></tr>";
            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Pickups", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@program", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@debug", SqlDbType.VarChar).Value = Session["pickups_name"];

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string EnrolementID = dr["EnrolementID"].ToString();
                        string name = dr["name"].ToString();
                     
                        string note = dr["note"].ToString();
                        string address = dr["address"].ToString();
                        string gender = dr["Gender"].ToString();
                        string EnrolementStatus = dr["EnrolementStatus"].ToString();
                        //Pickedup = dr["Pickedup"].ToString();
                        string worker = dr["worker"].ToString();
                        string whakapakari = dr["whakapakari"].ToString();
                        //if (address != "")
                        //{
                        //    name_addresses += name_addresses_delim + name + "~" + address;
                        //    name_addresses_delim = "|";
                        //}
                        string assigned = "To do";
                        foreach (var item in address.Split('|'))
                        {
                            
                        };

                        html += "<tr id=\"ID_" + EnrolementID + "\" data-status=\"" + EnrolementStatus + "\"><td>" + name + "</td><td>" + EnrolementStatus + "</td><td>" + gender + "</td><td>" + assigned + "</td></tr>";
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


        }
    }
}
   