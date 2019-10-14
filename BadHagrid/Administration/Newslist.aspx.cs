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

namespace BadHagrid.Administration
{
    public partial class Newslist : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("badhagrid_Get_All_News", con);

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
                        string news_ctr = dr["badhagrid_news_ctr"].ToString();
                        string title = dr["title"].ToString();
                        string article = dr["article"].ToString();
                        string datetime = Convert.ToDateTime(dr["datetime"].ToString()).ToString("ddd dd MMM yyyy HH:mm");
                      

                        string link = "<a href=\"newsmaint.aspx?id=" + news_ctr + "\">Edit</a>";


                        html += "<tr>";
                        html += "<td>" + datetime + "</td><td>" + title + "</td><td>" + link + "</td>";
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