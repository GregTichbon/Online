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
    public partial class FindPhone : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UBC_person_id"] == null)
            {
                Response.Redirect("~/people/security/login.aspx");
            }
            if (!Functions.accessstringtest(Session["UBC_AccessString"].ToString(), "11110001"))
            {
                Response.Redirect("~/default.aspx");
            }

            if (tb_phonenumber.Text != "")
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd1 = new SqlCommand("find_phone", con);
                cmd1.Parameters.Add("@phone", SqlDbType.VarChar).Value = tb_phonenumber.Text;

                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd1.ExecuteReader();
                    if (dr.HasRows)
                    {

                        html = "<table class=\"table\"><tr><th>Name</th><th>Phone</th></tr>";

                        while (dr.Read())
                        {
                            html += "<tr><td>" + dr["name"].ToString() + "</td><td>" + dr["phone"].ToString() + "</td></tr>" ;
                        }
                        html += "</table>";
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
            }
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}