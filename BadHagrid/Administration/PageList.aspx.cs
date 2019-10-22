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
    public partial class PageList : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("badhagrid_Get_All_Pages", con);

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<tr><th>Title</th><th>Edit</th></tr>";

                    while (dr.Read())
                    {
                        //string id = dr["ltr_ctr"].ToString();
                        string page_ctr = dr["badhagrid_page_ctr"].ToString();
                        string title = dr["title"].ToString();
                        string content = dr["content"].ToString();

                        string link = "<a href=\"pagemaint.aspx?id=" + page_ctr + "\">Edit</a>";


                        html += "<tr>";
                        html += "<td>" + title + "</td><td>" + link + "</td>";
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