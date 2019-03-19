using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations
{
    public partial class log : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            

            string sql1 = "select * from [log] order by [DateTime] desc";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                string guid = dr["guid"].ToString();
                string location = dr["location"].ToString();
                string message = dr["message"].ToString();
                string datetime = dr["datetime"].ToString();


                html += "<tr><td>" + guid + "</td><td>" + location + "</td><td>" + message + "</td><td>" + datetime + "</td></tr>";

                
            }



            dr.Close();
            con.Close();
            con.Dispose();

            
        }
    }
}