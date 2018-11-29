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

namespace DataInnovations.Row.Timing
{
    public partial class Finish : System.Web.UI.Page
    {
        public string race_values;

        protected void Page_Load(object sender, EventArgs e)
        {
            Functions genericfunctions = new Functions();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("Get_Races", con);
            cmd1.Parameters.Add("@regatta_CTR", SqlDbType.VarChar).Value = 1;
            cmd1.Parameters.Add("@started", SqlDbType.VarChar).Value = 1;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //RaceTimer_CNT	RaceID	Race	ScheduledStart	StartTime	regatta_ctr
                        string RaceTimer_CNT = dr["RaceTimer_CNT"].ToString();
                        string race = dr["race"].ToString();
                        string scheduledstart = dr["scheduledstart"].ToString();
                        string starttime = dr["starttime"].ToString();
                        race_values += "<option data-scheduledstart=\"" + scheduledstart + "\" data-starttime=\"" + starttime + "\" value=\"" + RaceTimer_CNT + "\">" + race + "</option>";
                    }
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
}