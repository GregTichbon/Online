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

namespace UBC.People.Reports
{
    public partial class CurrentMembers : System.Web.UI.Page
    {
        public string html;
        public string html_year = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                //string url = "../reports/currentmembers.aspx";
                //Response.Redirect("~/people/security/login.aspx?return=" + url);
				Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "1111"))
            {
                Response.Redirect("~/default.aspx");
            }
            //string year = Request.Form["dd_year"] ?? "";
            //if (year != "")
            //{
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("get_current_registrations", con);
                //cmd1.Parameters.Add("@year", SqlDbType.VarChar).Value = year;

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
                            html_year = dr["year"].ToString();
                            html = "<thead><tr><th>Image</th>";
                            for (int f1 = 3; f1 < dr.FieldCount; f1++)
                            {
                                html += "<th>" + dr.GetName(f1) + "</th>";
                            }
                            html += "<th class=\"noexport\">Display</th>";
                            html += "</tr></thead>";
                            firsttime = false;
                                html += "<tbody>";
                            }


                            //string id = dr["ltr_ctr"].ToString();
                            string person_id = dr["person_id"].ToString();
                            string guid = dr["guid"].ToString();

                            //string link = "<a href=\"maint.aspx?id=" + guid + "\" target=\"edit\">Edit</a>";
                            string displaylink = "";
                            //if (new string[] { "2017/18", "2018/19" }.Contains(year))
                            //{
                            //    displaylink = "../registerdisplay.aspx";
                            //} else
                            //{
                            displaylink = "../registrationdisplay.aspx";
                            //}

                            string link = "<br /><a href=\"../maint.aspx?id=" + guid + "\" target=\"_Blank\">Edit</a>  <a href=\"" + displaylink + "?guid=" + guid + "\" target=\"_Blank\">Display</a>";
                            string image = "<img src=\"../Images/" + person_id + ".jpg\" style=\"height: 50px\" />";

                        /*  0 year
                         *  1 person_id	
                         *  2 guid	
                         *  3 Name	
                         *  4 Gender	
                         *  5 Birth date	
                         *  6 Fee Category	
                         *  7 School and Year	
                         *  8 Email	
                         *  9 Phone	
                         * 10 Category	
                         * 11 Residential Address	
                         * 12 Invoice Recipient	
                         * 13 Invoice Address Type	
                         * 14 Invoice Address
                         * 15 Invoice Note
                         */


                        html += "<tr>";
                            html += "<td>" + image + "</td>";
                            for (int f1 = 3; f1 < dr.FieldCount; f1++)
                            {
                                string useval = dr[f1].ToString();
                                switch (f1)
                                {
                                case 3:
                                    useval = "<a href=\"../maint.aspx?id=" + guid + "\" target=\"_Blank\">" + useval + "</a>";
                                    //useval = useval + link;
                                    break;
                                case 8:
                                case 9:
                                case 10:
                                    useval = useval.Replace("|", "<br />");
                                    break;

                            }
                                html += "<td>" + useval + "</td>";
                            }

                            html += "<td class=\"noexport\"><a href=\"" + displaylink + "?guid=" + guid + "\" target=\"_Blank\">Display</a></td>";
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
            //}
        }
    }
}
