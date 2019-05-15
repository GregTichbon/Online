using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace iti.ninja
{
    public partial class data : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "Track_link":
                    string link = Request.QueryString["link"];

                    strConnString = "Data Source=localhost\\MSSQLSERVER2016;Initial Catalog=Iti_Ninja;Integrated Security=False;user id=iti_ninja;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("Track_link", con);

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add("@link", SqlDbType.VarChar).Value = link;

                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            html = "<a href=\"" + dr["url"].ToString() + "\">" + dr["url"].ToString() + "</a><br />";
                            html += "<table id=\"itininjatable\"><thead><tr><th>Date</th></tr></thead><tbody>";

                            do
                            {
                                string datetime = dr["datetime"].ToString();
                                html += "<tr><td>" + datetime + "</td></tr>";
                            }
                            while (dr.Read());

                            html += "</tbody></table>";

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

                    break;
            }
        }
    }
}