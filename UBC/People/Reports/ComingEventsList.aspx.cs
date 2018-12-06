﻿using Generic;
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

namespace UBC.People.Reports
{
    public partial class ComingEventsList : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("future_events_query", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    Boolean firsttime = true;
                    while (dr.Read())
                    {
                        if (firsttime)
                        {
                            html = "<thead><tr>"; //<th>Image</th>";
                            for (int f1 = 2; f1 < dr.FieldCount; f1++)
                            {
                                html += "<th>" + dr.GetName(f1) + "</th>";
                            }
                            // html += "<th>Edit</th>";
                            html += "</tr></thead>";
                            firsttime = false;
                            html += "<tbody>";
                        }


                        //string person_id = dr["person_id"].ToString();
                        //string guid = dr["guid"].ToString();


                        //string link = "<a href=\"../maint.aspx?id=" + guid + "\">Edit</a>";




                        html += "<tr>";
                        //html += "<td>" + image + "</td>";
                        for (int f1 = 1; f1 < dr.FieldCount; f1++)
                        {
                            string useval = dr[f1].ToString();

                            html += "<td>" + useval + "</td>";
                        }
                        //html += "<td>" + link + "</td>";


                        html += "</tr>";
                    }
                    html += "</tbody>";
                }

                dr.Close();
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