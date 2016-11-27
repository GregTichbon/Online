using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace TOHW.Rewards
{
    public partial class _default : System.Web.UI.Page
    {
        public string EnrolementID = "";
        public string name = "";
        public string lastname = "";
        public string rewarddate = "";
        public int points = 0;

        public string html = "";
        public string delim = "";
        public string notes = "";
        public string lines = "";
        public int cnt_date = 0;
        public int sum_points = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_rewards", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@program", SqlDbType.Int).Value = 2;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        EnrolementID = dr["EnrolementID"].ToString();
                        name = dr["name"].ToString();
                        if (Convert.IsDBNull(dr["date"]))
                        {
                            rewarddate = "";
                        }
                        else
                        {
                            rewarddate = Convert.ToDateTime(dr["date"]).ToString("d MMM yy");
                            cnt_date += 1;

                        }
                        if (Convert.IsDBNull(dr["points"]))
                        {
                            points = 0;
                        }
                        else
                        {
                            points = Convert.ToInt16(dr["points"]);
                            sum_points += points;
                        }
                        if (Convert.IsDBNull(dr["notes"]))
                        {
                            notes = "";
                        }
                        else
                        {
                            notes = dr["notes"].ToString();
                        }
                        if (name != lastname)
                        {
                            if (lastname != "")
                            {
                                html += "<p><b>" + lastname + "</b></p>";
                                html += lines;
                                if (sum_points != 0) { 
                                html += "<br /><b>Total: " + sum_points + " Average: " + sum_points/cnt_date;
                                }
                                lines = "";
                                sum_points = 0;
                                cnt_date = 0;
                            }
                            lastname = name;
                        }
                        lines += "<br />" + rewarddate + " " + points;

                    }
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
            lbl_table.Text = html;


        }
    }
}