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

namespace BadHagrid.Administration
{
    public partial class SendText : System.Web.UI.Page
    {
        public string html;
        public string response = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {




                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                //Functions genericfunctions = new Functions();
                string sql1 = "select * from badhagrid  order by [name]";

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand(sql1, con);

                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = con;
                //try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {

                        html = "<thead><th><input id=\"cb_textall\" type=\"checkbox\" /> Number</th><th>Name</th><th>Greeting</th><th>Inject</th><th>Confirmed</th><th>Notes</th></thead><tbody>";

                        while (dr.Read())
                        {
                            string ctr = dr["badhagrid_ctr"].ToString();
                            string name = dr["name"].ToString();
                            string mobilenumber = dr["mobilenumber"].ToString();
                            string greeting = dr["greeting"].ToString();
                            string confirmed = dr["confirmed"].ToString();
                            string notes = dr["notes"].ToString();
                            if (confirmed == "")
                            {
                                confirmed = "No";
                            } else
                            {
                                confirmed = "";
                            }

                            if (mobilenumber != "")
                            {
                                html += "<tr class=\"tr_person\" id=\"tr_person_id_" + ctr + "\">";
                                html += "<td><input id=\"cb_text_" + ctr + "\" name=\"cb_text_" + ctr + "\" type=\"checkbox\" value=\"" + mobilenumber + "\" /> <a href=\"tel:" + mobilenumber + "\">" + mobilenumber + "</a></td>";
                                html += "<td>" + name + "</td>";
                                html += "<td>" + greeting + "</td>";
                                html += "<td><input name=\"inject_" + ctr + "\" type=\"text\" /></td>";
                                html += "<td>" + confirmed + "</td>";
                                html += "<td>" + notes + "</td>";
                                html += "</tr>" + "\r\n";
                            }
                        }
                        html += "</tbody>";
                    }
                    dr.Close();
                }

                //catch (Exception ex)
                {
                    //throw ex;
                }
                //finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }
    }
}
