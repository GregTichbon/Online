using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using Online.Models;
using System.Reflection;

namespace Online.TestAndPlay
{
    public partial class listtodict1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
/*
            Dictionary<string, Models.fields> fieldsdict = new Dictionary<string, Models.fields>();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_definitions", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@definition_ctr", SqlDbType.Int).Value = 4;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        fieldsdict.Add(dr["title"].ToString(), new Models.fields(dr["db_name"].ToString()
                                                                        , dr["title"].ToString()
                                                                        , dr["type"].ToString()
                                                                        , dr["multi_flag"].ToString()
                                                                        , dr["subtable_flag"].ToString()
                                                                        , dr["field_name"].ToString()
                                                                        , dr["sql_datatype"].ToString()
                                                                        , dr["sp_datatype"].ToString()
                                                                        , Convert.ToInt32(dr["sequence"])
                                                                        , dr["fieldtype"].ToString()
                                                                        , dr["controltype"].ToString()
                                                                        , dr["definitionfields_ctr"].ToString()
                                                                       , "")
                                                                        );
                    }
                }
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


            Dictionary<string, string> dictfields = new Dictionary<string, string>();


            Boolean firstrow = true;
            string html = "";
            html += "<table border=\"1\" id=\"maintable\" class=\"StripedTable\">";

            //foreach (KeyValuePair<string, Models.fields> row in fieldsdict)
            foreach (var datarow in fieldsdict)
            {
                if (firstrow)
                {
                    html += "<thead>";
                    html += "<tr>";
                    foreach (var item in fieldsdict)
                    {
                        html += "<th>" + item.Key + "</th>";
                    }
                    html += "</tr>";
                    html += "</thead>";
                    firstrow = false;
                }
                html += "<tr>";

                fields datarowfields = datarow.Value;

                PropertyInfo[] properties = datarowfields.GetType().GetProperties();
                foreach (PropertyInfo pi in properties)
                {
                    //html += "<td>" + pi.Name + "=" + pi.GetValue(datarowfields, null) + "</td>";
                    dictfields[pi.Name] = pi.GetValue(datarowfields, null).ToString();

                }
                


                html += "</tr>";
            }
            html += "</table";

            lbl_html.Text = html;
  */
        }


    }
}