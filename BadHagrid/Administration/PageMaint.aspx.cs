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
    public partial class PageMaint : System.Web.UI.Page
    {
        public string page_ctr = "";
        public string title = "";
        public string content = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Functions genericfunctions = new Functions();


                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                page_ctr = Request.QueryString["id"];

                if (page_ctr != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("badhagrid_get_page", con);
                    cmd1.Parameters.Add("@page_ctr", SqlDbType.VarChar).Value = page_ctr;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            title = dr["title"].ToString();
                            content = dr["content"].ToString();

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
            string page_ctr = Request.Form["hf_page_ctr"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("badhagrid_update_page", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@page_ctr", SqlDbType.VarChar).Value = page_ctr;
            cmd1.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["tb_title"].Trim();
            cmd1.Parameters.Add("@content", SqlDbType.VarChar).Value = Request.Form["tb_content"].Trim();

            cmd1.Connection = con;
            try
            {
                page_ctr = cmd1.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                throw ex;
            }

            con.Close();
            con.Dispose();


            Response.Redirect("pagelist.aspx");
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            string page_ctr = Request.Form["hf_page_ctr"];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("badhagrid_delete_page", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@page_ctr", SqlDbType.VarChar).Value = page_ctr;


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


            Response.Redirect("pagelist.aspx");
        }
    }
}
