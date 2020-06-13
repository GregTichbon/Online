using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Quiz
{
    public partial class data : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "get_question":

                    string quizid = Request.QueryString["quizid"];
                    string question_number = Request.QueryString["question_number"];

                    string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
                    using (SqlConnection con = new SqlConnection(strConnString))
                    using (SqlCommand cmd = new SqlCommand("Get_Quiz_Question", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        //cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                        cmd.Parameters.Add("@quiz_ctr", SqlDbType.VarChar).Value = quizid;
                        cmd.Parameters.Add("@question_number", SqlDbType.VarChar).Value = question_number;
                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        dr.Read();
                        string question = dr["question"].ToString();
                        string seconds = dr["seconds"].ToString();
                        string last = dr["last"].ToString();
                        html += "Question: " + question;
                        html += "<br />" + seconds + " seconds";
                        //html += "<br /><input type=\"button\" id=\"act_action\" value=\"Send\" />";


                        dr.Close();
                    }
                    break;
            }
        }
    }
}