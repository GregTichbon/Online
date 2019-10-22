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
    public partial class NewsMaint : System.Web.UI.Page
    {
        public string news_ctr = "";
        public string datetime = "";
        public string day = "";
        public string title = "";
        public string article = "";
        public string active = "";

        public string[] yesno = new string[2] { "Yes", "No" };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Functions genericfunctions = new Functions();


                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                news_ctr = Request.QueryString["id"];

                if (news_ctr != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("badhagrid_get_news", con);
                    cmd1.Parameters.Add("@news_ctr", SqlDbType.VarChar).Value = news_ctr;
                    cmd1.Parameters.Add("@onlyactive", SqlDbType.VarChar).Value = "No";
                    cmd1.Parameters.Add("@nofuture", SqlDbType.VarChar).Value = "No";

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            title = dr["title"].ToString();
                            article = dr["article"].ToString();
                            datetime = Convert.ToDateTime(dr["datetime"].ToString()).ToString("ddd dd MMM yyyy HH:mm");
                            active = dr["active"].ToString();
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string news_ctr = Request.Form["hf_news_ctr"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("badhagrid_update_news", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@news_ctr", SqlDbType.VarChar).Value = news_ctr;
            cmd1.Parameters.Add("@datetime", SqlDbType.VarChar).Value = Request.Form["tb_datetime"].Trim();
            cmd1.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["tb_title"].Trim();
            cmd1.Parameters.Add("@article", SqlDbType.VarChar).Value = Request.Form["tb_article"].Trim();
            cmd1.Parameters.Add("@active", SqlDbType.VarChar).Value = Request.Form["dd_active"].Trim();

            cmd1.Connection = con;
            try
            {
                news_ctr = cmd1.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }

            con.Close();
            con.Dispose();

 
            Response.Redirect("newslist.aspx");
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            string news_ctr = Request.Form["hf_news_ctr"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("badhagrid_delete_news", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@news_ctr", SqlDbType.VarChar).Value = news_ctr;
          

            cmd1.Connection = con;
            try
            {
               string response = cmd1.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }

            con.Close();
            con.Dispose();


            Response.Redirect("newslist.aspx");
        }
    }
}
