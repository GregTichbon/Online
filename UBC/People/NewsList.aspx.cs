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

namespace UBC.People
{
    public partial class NewsList : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_All_News", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<tr><th>Date</th><th>Title</th><th>Edit</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string news_id = dr["news_id"].ToString();
                        string title = dr["title"].ToString();
                        string article = dr["article"].ToString();
                        string date = Convert.ToDateTime( dr["date"].ToString()).ToString("ddd dd MMM yyyy");
                        string categories = dr["categories"].ToString();

                        string link = "<a href=\"news.aspx?id=" + news_id + "\">Edit</a>";
                        

                        html += "<tr>";
                        html += "<td>" + date + "</td><td>" + title + "</td><td>" + link + "</td>";
                        html += "</tr>";
                    }
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