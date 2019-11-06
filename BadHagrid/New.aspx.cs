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
    public partial class New : System.Web.UI.Page
    {
        public string result;
        public string none = "none";
        public string html_about = "";
        public string html_contact = "";
        public string html_dates = "";
        public string images = "";
        public Dictionary<string, string> pages;

        protected void Page_Load(object sender, EventArgs e)
        {
            pages = new Dictionary<string, string>();

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "badhagrid_get_all_pages";

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    
                    string page_ctr = dr["badhagrid_page_ctr"].ToString();
                    string title = dr["title"].ToString();
                    string content = dr["content"].ToString();

                    pages[page_ctr] = content;


                }
            }

            dr.Close();

            string guid = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(guid))
            {

                cmd.CommandText = "Confirm_BadHagrid";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                con.Open();
                result = cmd.ExecuteScalar().ToString();
               
            }
            con.Close();
            con.Dispose();

            string path = Server.MapPath("~/userfiles/image/Gallery");
            foreach (string file in Directory.GetFiles(path))
            {
                images += "<img src=\"userfiles/image/Gallery/" + Path.GetFileName(file) + "\" /><br />";
            }

        }
    }
}