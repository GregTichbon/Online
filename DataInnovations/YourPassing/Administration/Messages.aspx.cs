﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YourPassing.Administration
{
    public partial class Messages : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Messages", con);
            //cmd.Parameters.Add("@agent_ctr", SqlDbType.VarChar).Value = Session["K4U_Agent_CTR"];

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            html = "<table>";
            html += "<thead>";
            html += "<tr><th>Name</th><th>Message</th><th>Amount</th><th>Approved</th></tr>";
            html += "</thead>";
            html += "<tbody>";


            while (dr.Read())
            {

                html += "<tr data-id=\"" + dr["message_ctr"].ToString() + "\">";
                html += "<td>" + dr["name"].ToString() + "</td>";
                //html += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";
                html += "<td>" + dr["message"].ToString() + "</td>";
                html += "<td>" + dr["amount"].ToString() + "</td>";
                html += "<td>" + dr["approved"].ToString() + "</td>";
                //html += "<td><button data-id=\"btn_edit\" type=\"button\">" + "Edit" + "</button></td>";
                html += "</tr>";
            }
            dr.Close();
            html += "</tbody>";
            html += "</table>";
            dr.Close();
            con.Close();
            con.Dispose();
        }
    }
}