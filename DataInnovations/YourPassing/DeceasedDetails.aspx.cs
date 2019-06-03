using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YourPassing
{
    public partial class DeceasedDetails : System.Web.UI.Page
    {
        public string html = "";
        static string deceased_ctr;
        string strConnString = "Data Source=toh-app;Initial Catalog=Koha4U;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                deceased_ctr = Request.QueryString["id"];
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Get_Deceased", con);
                cmd.Parameters.Add("@deceased_ctr", SqlDbType.VarChar).Value = deceased_ctr;

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                html = "<table>";
                html += "<thead>";
                html += "</thead>";
                html += "<tbody>";


                while (dr.Read())
                {
                    html += "<tr><td>First name</td><td>" + dr["firstname"].ToString() + "</td></tr>";
                    html += "<tr><td>Last name</td><td>" + dr["lastname"].ToString() + "</td></tr>";
                    html += "<tr><td>Known as</td><td>" + "</td></tr>";
                    html += "<tr><td>Date of birth</td><td>" + "</td></tr>";
                    html += "<tr><td>Last residence</td><td>" + "</td></tr>";
                    html += "<tr><td>Date of death</td><td>" + "</td></tr>";
                    html += "<tr><td>Place of death</td><td>" + "</td></tr>";
                    //html += "<td>" + DateTime.Parse(dr[8].ToString()).ToString("ddd dd-MMM-yyyy") + "</td>";
                }
                dr.Close();
                html += "</tbody>";
                html += "</table>";


                dr.Close();
                con.Close();
                con.Dispose();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            decimal amount;
            if (dd_amount.Text == "Other")
            {
                amount = Convert.ToDecimal(tb_amount.Text);
            }
            else
            {
                amount = Convert.ToDecimal(dd_amount.Text);
            }

            cmd.CommandText = "Update_Message";
            cmd.Parameters.Add("@message_ctr", SqlDbType.VarChar).Value = "new";
            cmd.Parameters.Add("@deceased_ctr", SqlDbType.VarChar).Value = deceased_ctr;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = amount;
            cmd.Parameters.Add("@message", SqlDbType.VarChar).Value = tb_message.Text;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string guid = dr[0].ToString();
            con.Close();

            con.Dispose();
            Response.Redirect("payment.aspx?id=" + guid);
        }


    }
}