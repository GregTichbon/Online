using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz.Host
{
    public partial class Quiz : System.Web.UI.Page
    {
        public int quizquestion = 0;
        public string title = "";
        public string description = "";
        public int questions = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            string quizid = Request.QueryString["quizid"].ToString();
            quizid = "1";

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            using (SqlConnection con = new SqlConnection(strConnString))
            using (SqlCommand cmd = new SqlCommand("Get_Quiz", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@quiz_ctr", SqlDbType.VarChar).Value = quizid;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        title = dr["title"].ToString();
                        description   = dr["description"].ToString();
                        questions = (int)dr["questions"];
                    }
                }
                else
                {
                    Console.WriteLine("No rows found.");
                }
                dr.Close();
            }



        }
    }
}