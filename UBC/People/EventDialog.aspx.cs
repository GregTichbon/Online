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

namespace UBC.People
{
    public partial class EventDialog : System.Web.UI.Page
    {
        public string event_id;
        public string title;
        public string description;
        public string allday;
        public string allday_checked;
        public string startdatetime;
        public string enddatetime;
        public string datetime;
        public string type;
        public string role;
        public string categories;
        public string html_persons;


        public string[] type_values = new string[3] { "Training", "Regatta", "Promotion" };
        public string categories_values;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                btn_delete.Visible = false;

                Functions genericfunctions = new Functions();
                Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                categories = "";

                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                event_id = Request.QueryString["id"];

                if (event_id != "new")
                {
                    SqlConnection con = new SqlConnection(strConnString);
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("get_event", con);
                    cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd1.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            title = dr["title"].ToString();
                            description = dr["description"].ToString();
                            allday = dr["allday"].ToString();
                            startdatetime = dr["startdatetime"].ToString();
                            enddatetime = dr["enddatetime"].ToString();
                            type = dr["type"].ToString();
                            categories = dr["categories"].ToString();

                            if (allday != "Yes")
                            {
                                datetime = "/time";
                                startdatetime = Convert.ToDateTime(startdatetime).ToString("dd MMM yy HH:mm");
                                enddatetime = Convert.ToDateTime(enddatetime).ToString("dd MMM yy HH:mm");
                                allday_checked = " checked";
                            }
                            else
                            {
                                datetime = "";
                                startdatetime = Convert.ToDateTime(startdatetime).ToString("dd MMM yy");
                                enddatetime = Convert.ToDateTime(enddatetime).ToString("dd MMM yy");
                            }
                            if( Convert.ToDateTime(startdatetime) > DateTime.Now)
                            {
                                btn_delete.Visible = true;
                            }

                         
                        }

                        dr.Close();
                    }

                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
                else
                {
                    startdatetime = Request.QueryString["date"] + " 0:00";
                    enddatetime = startdatetime;

                }

                functionoptions.Clear();
                functionoptions.Add("storedprocedure", "");
                functionoptions.Add("usevalues", "");
                categories_values = genericfunctions.buildandpopulateselect(strConnString, "@category", categories, functionoptions, "None");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string event_id = Request.Form["hf_event_id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("update_event", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd1.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["tb_title"].Trim();
            cmd1.Parameters.Add("@description", SqlDbType.VarChar).Value = Request.Form["tb_description"].Trim();
            cmd1.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = Request.Form["tb_startdatetime"].Trim();
            cmd1.Parameters.Add("@enddatetime", SqlDbType.VarChar).Value = Request.Form["tb_enddatetime"].Trim();
            cmd1.Parameters.Add("@allday", SqlDbType.VarChar).Value = Request.Form["cb_allday"];
            cmd1.Parameters.Add("@type", SqlDbType.VarChar).Value = Request.Form["dd_type"];
            cmd1.Parameters.Add("@categories", SqlDbType.VarChar).Value = Request.Form["dd_categories"];

            cmd1.Connection = con;
            try
            {
                event_id = cmd1.ExecuteScalar().ToString();

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

            Response.Redirect("eventdialogclose.html");

        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            string event_id = Request.Form["hf_event_id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();

            SqlCommand cmd1 = new SqlCommand("delete_event", con);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;

            cmd1.Connection = con;
            try
            {
                string result = cmd1.ExecuteScalar().ToString();

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

            Response.Redirect("eventdialogclose.html");

        }
    }
}
