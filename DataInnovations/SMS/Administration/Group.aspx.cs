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
    public partial class Group : System.Web.UI.Page
    {
        //public string html;
        public string tabledata;
        public string addrow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (cb_group.Text != "")
            {
                addrow = "<span id=\"addrow\">Add</span>";
                string group_ctr = cb_group.SelectedValue;
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
                    tabledata = "var tableData = [";
                    string delim1 = "";
                    /*
                    html += "<table>";
                    html += "<thead>";
                    html += "<tr>";
                    html += "<td>Number</td><td>Name</td><td>Greeting</td><td>Status</td><td>Action</td>";
                    html += "</tr></thead><tbody>";
                    */

                    while (dr.Read())
                    {
                        /*
                        html += "<tr id=\"G_" + dr[0].ToString() + "\">";
                        html += "<td id=\"N_" + dr[1].ToString() + "\">" + dr[2].ToString() + "</td>";
                        html += "<td>" + dr[3].ToString() + "</td>";
                        html += "<td>" + dr[4].ToString() + "</td>";
                        html += "<td>" + dr[5].ToString() + "</td>";
                        html += "<td><span class=\"remove\">Remove from Group</span></td>";
                        */

                        tabledata += delim1 + "{"; // id:" + dr[0].ToString();
                        string delim2 = "";
                        for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                        {
                            tabledata += delim2 + dr.GetName(f1).ToString() + ":\"" + dr[f1].ToString() + "\"";
                            delim2 = ", ";
                        }
                        //html += "</tr>";
                        tabledata += "}";
                        delim1 = ",";

                    }
                    //html += "</tbody>";
                    //html += "</table>";
                    //lbl_html.Text = html;

                    dr.Close();
                    con.Close();
                    con.Dispose();
                    tabledata += "]";

                }
            }
        }

        protected void cb_group_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Page_Load(sender, e);
        }
    }
}