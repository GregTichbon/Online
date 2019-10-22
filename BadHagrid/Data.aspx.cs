using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Xml;
//using OfficeOpenXml;
using System.IO;
using System.Configuration;
using System.Web.UI.WebControls;

namespace BadHagrid
{
    public partial class Data : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string news_ctr = Request.QueryString["id"] ?? "0";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("badhagrid_get_news", con);
            cmd1.Parameters.Add("@news_ctr", SqlDbType.VarChar).Value = news_ctr;
            cmd1.Parameters.Add("@onlyactive", SqlDbType.VarChar).Value = "Yes";
            cmd1.Parameters.Add("@nofuture", SqlDbType.VarChar).Value = "Yes";
            cmd1.Parameters.Add("@next", SqlDbType.VarChar).Value = "Next";

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;

            try
            {

                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();

                    string news_id = dr["badhagrid_news_ctr"].ToString();
                    if (news_id == "-1")
                    {
                        html = news_id + "|";
                    }
                    else
                    {
                        string title = dr["title"].ToString();
                        string article = dr["article"].ToString();
                        //string datetime = Convert.ToDateTime(dr["datetime"].ToString()).ToString("ddd dd MMM yyyy HH:mm");

                        html = news_id + "|<h2>" + title + "</h2>";
                        //html += "<input type=\"hidden\" id=\"hf_news_id\" value=\"" + news_id + "\" />";
                        html += article;
                    }
                }

                dr.Close();
            }

            catch (Exception ex)
            {
                throw ex;
            }



            con.Close();
            con.Dispose();
      
        }
    }
}