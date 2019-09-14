using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Row
{
    public partial class Entry : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Row_User_CTR"] == null)
                {
                    //Response.Redirect("login.aspx");
                }
                string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                string sql = "get_user_clubs";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.Add("@user_ctr", SqlDbType.VarChar).Value = Session["Row_User_CTR"];

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection = con;

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dd_club.Items.Add(new ListItem(dr["club_ctr"].ToString(), dr["name"].ToString()));
                    }
                }
                dr.Close();
                if (dd_club.Items.Count > 1)
                {
                    dd_club.Items.Insert(0, new ListItem("--- Please Select ---", ""));
                }

                sql = "get_entries";

                cmd = new SqlCommand(sql, con);
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@regatta_ctr", SqlDbType.VarChar).Value = 1;
                cmd.Parameters.Add("@club_ctr", SqlDbType.VarChar).Value = Session["Row_Club_CTR"];

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection = con;

                //con.Open();
                dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string crew_ctr = dr["crew_ctr"].ToString();
                        string event_ctr = dr["event_ctr"].ToString();
                        string title = dr["title"].ToString();
                        string club_ctr = dr["club_ctr"].ToString();
                        string club = dr["club"].ToString();
                        string members = dr["members"].ToString();
                        string boat = dr["boat"].ToString();
                        string prognostic = dr["prognostic"].ToString();
                        string prognosticoverride = dr["prognosticoverride"].ToString();



                        html += "<tr id=\"" + crew_ctr + "\">";
                        html += "<td>" + club + "</td>";
                        html += "<td>" + title + "</td>";
                        html += "<td>" + boat + "</td>";
                        html += "<td>" + members + "</td>";
                        html += "<td>" + prognostic + "</td>";
                        html += "<td>" + prognosticoverride + "</td>";
                        html += "</tr>";



                        /*
Crew_CTR	Event_CTR	Title	            Club_CTR	Name	        Members                     Boat
1	        1	        Winter Series 9K	1	        Union Boat Club	Bob Evans, Justin Evans
*/

                    }
                }
                dr.Close();
                con.Close();
                con.Dispose();
            }
        }
    }
}