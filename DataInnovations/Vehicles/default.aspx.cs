using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace datainn.co.nz.Vehicles
{
    public partial class _default : System.Web.UI.Page
    {
        public string tabledata;
        protected void Page_Load(object sender, EventArgs e)
        {
            tabledata = "var tableData = [";
            string delim = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string sql1 = "SELECT vehicle_CTR, registration, description, format(wofdue,'dd MMM yy') as wofdue, format(registrationdue,'dd MMM yy') as registrationdue , format(servicedue,'dd MMM yy') as servicedue , notes, email, format(holdemailtill,'dd MMM yy') as holdemailtill , mobile, format(holdmobiletill,'dd MMM yy') as holdmobiletill  from vehicle order by description, registration";

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
                while (dr.Read())
                {
                    tabledata += delim + "{id:" + dr[0].ToString();
                    for (int f1 = 0; f1 <= dr.FieldCount - 1; f1++)
                    {
                        tabledata += ", " + dr.GetName(f1).ToString() + ":\"" + dr[f1].ToString() + "\"";
                    }
                    tabledata += "}";
                    delim = ",";
                }
                dr.Close();
                con.Close();
                con.Dispose();
                tabledata += "]";
            }
        }
    }
}
