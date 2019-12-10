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
    public partial class RegattaList : System.Web.UI.Page
    {
        public string html;
        public string id;
        public string export;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"] ?? "";

            if (Session["UBC_person_id"] == null)
            {
                //string url = "../reports/regattalist.aspx?id=" + id;
                //Response.Redirect("~/people/security/login.aspx?return=" + url);
                Session["UBC_URL"] = HttpContext.Current.Request.Url.PathAndQuery;
                Response.Redirect("~/people/security/login.aspx");
            }


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Regatta_List", con);
            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = id;


            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    if (id != "")
                    {
                        html = "<table class=\"table table-striped\">";
                        html += "<tr><th>Name</th><th>Status</th><th>Role</th><th>Note</th><th>Personal Note</th><th>Private Note</th><th>Phone</th><th>Dietry</th><th>Medical</th></tr>";

                        while (dr.Read())
                        {
                            //string person_id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string attendance = dr["attendance"].ToString();
                            string role = dr["role"].ToString();
                            string note = dr["note"].ToString();
                            string personnote = dr["personnote"].ToString();
                            string privatenote = dr["privatenote"].ToString();
                            string phone = dr["phone"].ToString().Replace("|","<br />");
                            string dietry = dr["dietry"].ToString();
                            string medical = dr["medical"].ToString();



                            html += "<tr>";
                            html += "<td>" + name + "</td><td>" + attendance + "</td><td>" + role + "</td><td>" + note + "</td><td>" + personnote + "</td><td>" + privatenote + "</td><td>" + phone + "</td><td>" + dietry + "</td><td>" + medical + "</td>";
                            html += "</tr>";
                        }
                    }
                    html += "</table>";
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