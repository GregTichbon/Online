using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class SendText : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Generic.Functions gFunctions = new Generic.Functions();

            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("select distinct GN.number, N.greeting from Group_Number GN inner join number N on N.Number = GN.number where [group_ctr] = 3 order by number", con);

            cmd.CommandType = CommandType.Text;
            //cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string mobile = dr["mobile"].ToString();
                    string response = ""; // gFunctions.SendMessage(mobile, "Test").ToString();

                    LitRows.Text += "<tr>";
                    LitRows.Text += "<td>" + dr["mobile"] + "</td>";
                    LitRows.Text += "<td>" + dr["person"] + "</td>";
                    LitRows.Text += "<td>" + response + "</td>";
                    LitRows.Text += "</tr>";
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
        }



        protected void btn_submit_Click(object sender, EventArgs e)
        {
        }
    }
}

            

       