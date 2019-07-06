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

namespace BadHagrid
{
    public partial class Default : System.Web.UI.Page
    {
        public string response = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["id"];
            if(!string.IsNullOrEmpty(guid))
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;

                cmd.CommandText = "Confirm_BadHagrid";
                cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;

                con.Open();
                response = cmd.ExecuteScalar().ToString();
                con.Close();
                con.Dispose();
            }
        }
    }
}