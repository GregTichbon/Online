using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using Generic;


namespace UBC.People
{
    public partial class RegistrationDisplay : System.Web.UI.Page
    {
        public string documenthtml = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string registration_id = Request.QueryString["id"];
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_Registration";
            cmd.Parameters.Add("@registration_id", SqlDbType.VarChar).Value = registration_id;
            cmd.Connection = con;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                documenthtml = dr["document"].ToString();
            }

            dr.Close();
            con.Close();
            con.Dispose();
        }

    }
}