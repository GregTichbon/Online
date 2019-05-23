using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.SMS.Administration
{
    public partial class GroupSend : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string group_ctr = Request.QueryString["id"].ToString();
            Generic.Functions gFunctions = new Generic.Functions();

            string strConnString = "Data Source=toh-app;Initial Catalog=SMS;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string sql1 = "get_numbers_for_group";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@group_ctr", SqlDbType.VarChar).Value = group_ctr;

            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                html += "<table>";
                html += "<thead>";
                html += "<tr><td colspan=\"4\"><input id=\"cb_toggleall\" type=\"checkbox\" /></td></tr>";
                html += "<tr>";
                html += "<td>Select</td><td>Number</td><td>Name</td><td>Greeting</td><td>Status</td>";
                html += "</tr></thead><tbody>";

                while (dr.Read())
                {
                    string id = dr[0].ToString();
                    string mobile = dr[2].ToString();
                    string greeting = dr[4].ToString();
                    html += "<tr>";
                    html += "<td><input class=\"checkbox\" type=\"checkbox\" id=\"cb_" + id + "\" name=\"cb_" + id + "\" value=\"x\" /></td>";
                    html += "<td id=\"N_" + dr[1].ToString() + "\">" + mobile + "</td>";
                    html += "<td>" + dr[3].ToString() + "</td>";
                    html += "<td>" + greeting + "</td>";
                    html += "<td>" + dr[5].ToString() + "</td>";
                    html += "</tr>";

                    if (IsPostBack)
                    {
                        string val = Request.Form["cb_" + id];
                        if (val == "x")
                        {
                            string textmessage = tb_message.Text;
                            

                            textmessage = textmessage.Replace("||greeting||", greeting);
                            textmessage = textmessage.Replace("||ID||", id);

                            foreach (string mobilex in mobile.Split(';'))
                            {
                                Response.Write(gFunctions.SendRemoteMessage(mobilex, textmessage, "SMS Group") + "<br />");
                                //Response.Write(mobilex + " " + textmessage + "<br />");


                            }
                        }
                    }



                }
                html += "</tbody>";
                html += "</table>";

                dr.Close();
                con.Close();
                con.Dispose();

            }
        }

        protected void tb_message_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}