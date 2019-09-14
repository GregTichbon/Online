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
    public partial class CurrentMembers : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                Response.Redirect("~/default.aspx");
            }
            string year = Request.Form["dd_year"] ?? "";
            if (year != "")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("get_current_registrations", con);
                cmd1.Parameters.Add("@year", SqlDbType.VarChar).Value = year;

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
                                html = "<thead><tr><th>Image</th>";
                                for (int f1 = 2; f1 < dr.FieldCount; f1++)
                                {
                                    html += "<th>" + dr.GetName(f1) + "</th>";
                                }
                                html += "</tr></thead>";
                                firsttime = false;
                                html += "<tbody>";
                            }


                            //string id = dr["ltr_ctr"].ToString();
                            string person_id = dr["person_id"].ToString();
                            string guid = dr["guid"].ToString();

                            //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                            string link = "<br /><a href=\"../maint.aspx?id=" + guid + "\">Edit</a>  <a href=\"../registerdisplay.aspx?id=" + guid + "\">Display</a>";
                            string image = "<img src=\"../Images/" + person_id + ".jpg\" style=\"height: 50px\" />";



                            html += "<tr>";
                            html += "<td>" + image + "</td>";
                            for (int f1 = 2; f1 < dr.FieldCount; f1++)
                            {
                                string useval = dr[f1].ToString();
                                switch (f1)
                                {
                                    case 2:
                                        useval = useval + link;
                                        break;
                                    case 8:
                                    case 9:
                                    case 10:
                                        useval = useval.Replace("|", "<br />");
                                        break;
                                    case 4:
                                    case 11:
                                    case 13:
                                        /*
                                        if (useval != "")
                                        {
                                            useval = Convert.ToDateTime(useval).ToString("dd MMM yy");
                                        }  */
                                        break;
                                      

                                }
                                if (f1 == 7 || f1 == 8 || f1 == 9)
                                {

                                }
                                html += "<td>" + useval + "</td>";
                            }


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
}