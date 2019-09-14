using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.Row
{
    public partial class data1 : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString;
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "get_entry":
                    string entry_id = Request.QueryString["id"];
                    string discipline = Request.QueryString["Discipline"];

                    //get_event_person event_id mode='Recorded'
                    strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("get_entry", con);
                    cmd1.Parameters.Add("@entry_id", SqlDbType.VarChar).Value = entry_id;
                    cmd1.Parameters.Add("@discipline", SqlDbType.VarChar).Value = discipline;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {

                            html = "<table><thead><tr><th>Name</th><th>Attendance</th><th>Note</th><th>Person's Note</th></tr></thead><tbody>";

                            while (dr.Read())
                            {
                                string name = dr["name"].ToString();
                                string attendance = dr["attendance"].ToString();
                                string note = dr["note"].ToString();
                                string personnote = dr["personnote"].ToString();

                                html += "<tr><td>" + name + "</td><td>" + attendance + "</td><td>" + note + "</td><td>" + personnote + "</td></tr>";

                            }
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
                    
                    /*
            Functions genericfunctions = new Functions();
            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
            functionoptions.Add("storedprocedure", "");
            functionoptions.Add("usevalues", "");
            functionoptions.Add("parameters", "|" + Discipline + "|");
            //html = genericfunctions.buildandpopulateselect(strConnString, "@boats", "", functionoptions, "None");
            */
        }
    }
}