using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.StrengthFinders
{
    public partial class Matches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=StrengthFinders;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Strengths_Matrix", con);
            //cmd.Parameters.Add("@???????", SqlDbType.VarChar).Value = ??????;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();

                    //LitRows.Text = "<div id=\"parent\">";
                    LitRows.Text = "<div class=\"sticky-table sticky-headers sticky-ltr-cells\">";

                    //LitRows.Text += "<table class=\"table table-bordered table-striped zui-table\"><thead>";
                    LitRows.Text += "<table class=\"table table-bordered table-striped\"><thead>";

                    LitRows.Text += "<tr class=\"sticky-row\">";
                    LitRows.Text += "<th class=\"left sticky-cell\">Name</th>";
                    for (int f1 = 2; f1 <= dr.FieldCount - 1; f1++)
                    {
                        string[] fieldname = dr.GetName(f1).ToString().Split('|');
                        LitRows.Text += "<th id=\"C" + fieldname[0] + "\" class=\"column\">" + fieldname[1] + "</th>";
                    }

                    LitRows.Text += "</tr></thead><tbody>";

                    do
                    {
                        string person = dr["person1_ctr"].ToString();
                        LitRows.Text += "<tr>";
                        LitRows.Text += "<td id=\"R" + person + "\" class=\"row left sticky-cell\">" + dr["name"] + "</td>"; // "<br /><span class=\"subgroup\">" + dr["subgroup"] + "</span></td>";

                        for (int f1 = 2; f1 <= dr.FieldCount - 1; f1++)
                        {
                            //string[] fieldname = dr.GetName(f1).ToString().Split('.');
                            //string id = "R_" + person + "_" + fieldname[0];
                            string score = dr.GetValue(f1).ToString();
                            //LitRows.Text += "<td id=\"" + id + "\" class=\"rank\" person=\"" + person + "\" strength=\"" + fieldname[0] + "\" rank=\"" + rank + "\">" + rank + "</td>";
                            LitRows.Text += "<td>" + score + "</td>";
                        }
                        LitRows.Text += "</tr>";
                    }
                    while (dr.Read());
                    LitRows.Text += "</tbody></table></div>";

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
    }
}
 