using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BadHagrid.Administration
{
    public partial class SignedUp : System.Web.UI.Page
    {
        //public string html = "";
        public string tabledata;
        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string val;
            tabledata = "var tableData = [";
            string delim = "";

            string sql1 = "select * from badhagrid  order by [name]";


            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;
            //try
            //{
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                //html += "<thead><tr>";
                //for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                //{
                    //html += "<th>";
                    //val = dr.GetName(f1).ToString();
                    //html += val;
                    //html += "</th>";
                //}
                //html += "</tr></thead><tbody>";

                while (dr.Read())
                {
                    //html += "<tr>";
                    tabledata += delim + "{id:" + dr[0].ToString();
                    for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                    {
                        //html += "<td>";
                        //val = dr[f1].ToString();
                        //html += val;
                        //html += "</td>";

                        tabledata += ", " + dr.GetName(f1).ToString() + ":\"" + dr[f1].ToString() + "\"";
                    }
                    //html += "</tr>";
                    tabledata += "}";
                    delim = ",";

                    /*var tableData = [
    {id:1, name:"Billy Bob", age:"12", gender:"male", height:1, col:"red", dob:"", cheese:1},
    {id:2, name:"Mary May", age:"1", gender:"female", height:2, col:"blue", dob:"14/05/1982", cheese:true},
]*/

                }
                //html += "</tbody>";
            }
            dr.Close();
            con.Close();
            con.Dispose();
            tabledata += "]";
        }
    }
}