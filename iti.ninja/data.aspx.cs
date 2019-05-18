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
                    string format = Request.QueryString["format"];
                    if(format == "")
                    {
                        format = "simple";
                    }

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
                            string datetime = dr["datetime"].ToString();
                            html = "<a href=\"" + dr["url"].ToString() + "\">" + dr["url"].ToString() + "</a><br />";

                            switch (format)
                            {
                                case "table":
                                    html += "<table id=\"itininjatable\"><thead><tr><th>Date</th></tr></thead><tbody>";
                                    break;
                            }

                            do
                            {
                                datetime = dr["datetime"].ToString();
                                switch (format)
                                {
                                    case "table":
                                        html += "<tr><td>" + datetime + "</td></tr>";
                                        break;
                                    case "simple":
                                        html += datetime + "<br />";
                                        break;
                                }
                                
                            }
                            while (dr.Read());
                            switch (format)
                            {
                                case "table":
                                    html += "</tbody></table>";
                                    break;
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

                    break;
            }
        }
    }
}