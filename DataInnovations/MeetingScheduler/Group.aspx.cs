using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class Group : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string sql = "select G.Name as [Group], G.Status, E.Name, GE.FromDate, GE.ToDate, isnull(GE.mobile,E.Mobile) as [Mobile], isnull(GE.EmailAddress,E.EmailAddress) as EmailAddress, E.Greeting " +
           "from [group] G " +
           "left outer join Group_Entity GE on GE.Group_CTR = G.Group_ctr " +
           "left outer join Entity E on E.Entity_CTR = GE.Entity_CTR " +
           "order by G.Name, E.Name";
         
            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd = new SqlCommand();

            html = "<table><thead><tr><th>Group</th><th>Status</th><th>From</th><th>To</th><th>Mobile</th><th>Email</th><th>Greeting</th></tr></thead><tbody>";

            cmd = new SqlCommand(sql, con);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            try
            {
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    string group = dr["group"].ToString();
                    string status = dr["status"].ToString();
                    string name = dr["name"].ToString();
                    string fromdate = "";
                    string todate = "";
                    string mobile = dr["mobile"].ToString();
                    string emailaddress = dr["emailaddress"].ToString();
                    string greeting = dr["greeting"].ToString();
                    if (dr["fromdate"] != DBNull.Value)
                    {
                        fromdate = Convert.ToDateTime(dr["fromdate"]).ToString("dd MMM yy");
                    }
                    if (dr["todate"] != DBNull.Value)
                    {
                        todate = Convert.ToDateTime(dr["todate"]).ToString("dd MMM yy");
                    }
                    if (emailaddress != "")
                    {
                        emailaddress = "<a href=\"mailto:" + emailaddress + "\">" + emailaddress + "</a>";
                    }

                    html += "<tr><td>" + group + "</td><td>" + status + "</td><td>" + name + "</td><td>" + fromdate + "</td><td>" + todate + "</td><td>" + mobile + "</td><td>" + emailaddress + "</td><td>" + greeting + "</td></tr>";
                }

                html += "</tbody></table>";

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