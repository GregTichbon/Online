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
    public partial class Report : System.Web.UI.Page
    {
        public string html;
        public string export;
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UBC_person_id"] == null)
            {
                string url = "../reports/ShowAttendees.aspx?id=" + guid;
                Response.Redirect("~/people/security/login.aspx?return=" + url);
            }
            */
            Boolean firsttime = true;
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand();
            cmd1.CommandType = CommandType.Text;
            cmd1.CommandText = @"select dbo.get_name(PE.person_id,'') as [Name]
                                , P.guid
                                , PE.Attendance, PE.role
                                , replace(PE.PersonNote,char(13),'<br />') as [Persons Note], replace(PE.note,char(13),'<br />') as [Note], replace(PE.PrivateNote,char(13),'<br />') as [Private Note]
                                , replace(PE.Accomodation,char(13),'<br />') as [Accomodation], replace(PE.Meals,char(13),'<br />') as [Meals], replace(PE.travel,char(13),'<br />') as [Travel]
                                , replace(PE.traveldetail,char(13),'<br />') as [Travel Detail], replace(PE.returntraveldetail,char(13),'<br />') as [Return Travel], replace(PE.others,char(13),'<br />') as [Others Coming]
                                , replace(PE.onsite,char(13),'<br />') as [Staying Onsite], replace(PE.OtherInformation,char(13),'<br />') as [Other Information]
                                from Person_Event PE
                                inner join Person P on P.Person_ID = PE.Person_ID
                                where event_id = 150 and Attendance <> 'Not Going' and Attendance <> 'No'
                                order by Accomodation desc, dbo.get_name(PE.person_id,'')";
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    export = "<input type=\"button\" id=\"export\" class=\"btn btn-info\" value=\"Export\" />";
                    html = "<table id=\"attendance\" class=\"table table-striped\">";

                    while (dr.Read())
                    {
                        if (firsttime)
                        {
                            html += "<thead><tr>";
                            for (int f1 = 0; f1 < dr.FieldCount; f1++)
                            {
                                html += "<th>" + dr.GetName(f1) + "</th>";
                            }
                            html += "</tr></thead><tbody>";
                            firsttime = false;
                        }
                        html += "<tr>";
                        html += "<td><a href=\"../attendance.aspx?e=539F7624-D761-4258-B6E0-700E28DD2A31&p=" + dr["guid"] + "\">" + dr[0] + "</a></td>";

                        for (int f1 = 1; f1 < dr.FieldCount; f1++)
                        {
                            html += "<td>" + dr[f1] + "</td>";
                        }
                        html += "</tr>";
                    }

                    html += "</tbody></table>";

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