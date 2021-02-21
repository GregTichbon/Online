using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC
{
    //Configure in IIS | Error Pages | 404 | Execute URL | /main.aspx 
    public partial class Main : System.Web.UI.Page
    {
        public string url;
        protected void Page_Load(object sender, EventArgs e)
        {
            //https://ubc.org.nz/main.aspx?404;https://ubc.org.nz:80/people/reports/loginregister1.pdf

            //url = Request.QueryString["aspxerrorpath"].ToString(); 
            url = Request.Url.ToString(); //.Substring(54);

            int x = url.IndexOf("404;");
            url = url.Substring(x + 4);

            string newurl = "";
            string[] urlparts = url.Split('/');
            string trackerid = "";
            string delim = "";
            foreach(string urlpart in urlparts)
            {
                if(urlpart.StartsWith("Folder"))
                {
                    trackerid = urlpart.Substring(6);
                } else
                {
                    newurl += delim + urlpart;
                    delim = "/";
                }
            }
            if(trackerid != "")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;

   
                cmd.CommandText = "Add_Tracker";
                cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = trackerid;
                cmd.Parameters.Add("@url", SqlDbType.VarChar).Value = newurl;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    //string result = cmd.ExecuteScalar().ToString();
                    cmd.ExecuteNonQuery();
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

                Response.Redirect(newurl);
            }
        }
    }
}