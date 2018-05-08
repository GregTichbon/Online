using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class Scheduler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["id"] + "";

            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);

            string meetingname = "";
            int timeslots;
            int duration;

            SqlCommand cmd1 = new SqlCommand("Get_Meeting", con);
            cmd1.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = 2;
            cmd1.Parameters.Add("@???????", SqlDbType.VarChar).Value = guid;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    meetingname = dr["name"].ToString();
                    timeslots = Convert.ToInt16(dr["timeslots"]);
                    duration = Convert.ToInt16(dr["duration"]);
                    //should see that the guid is in here otherwise don't show!!!

                    /*
                    string DBDate = dr["pdate1"].ToString();
                    DateTime theDate;
                    if (DateTime.TryParse(DBDate, out theDate))
                    {
                        formattedDate = theDate.ToString("d MMM yyyy");
                    }
                    */
                    dr.Close();
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

            string html = "";
            string h1 = "";
            string h2 = "";
            string entity_ctr;
            string entityname;
            string lastdate = "";

            string colname;
            int cnt = 0;
            int d = 0;
            int day = 0;

            var table2 = new DataTable();
            using (var da = new SqlDataAdapter("Get_Meeting_Slots 2", strConnString))
            {
                da.Fill(table2);
            }

            h1 += "<th class=\"zui-sticky-col\">" + meetingname + "</th>";

            for (int f1 = 2; f1 < table2.Columns.Count; f1++)
            {
                colname = table2.Columns[f1].ColumnName.Substring(0, 8);
                if (colname != lastdate)
                {
                    if (cnt > 0)
                    {
                        d = 1 - d;
                        day++;
                        h1 += "<th class=\"day d" + d + "\" colspan=\"" + cnt + "\" data-day=\"" + day + "\">" + lastdate + "</th>";
                        cnt = 0;
                    }
                    lastdate = colname;
                }
                cnt++;
            }
            d = 1 - d;
            day++;
            h1 += "<th class=\"day d" + d + "\" colspan=\"" + cnt + "\" data-day=\"" + day + "\">" + lastdate + "</th>";

            foreach (DataRow row in table2.Rows)
            {
                if (html == "")
                {
                    html += "<thead>";
                    h2 += "<tr><th class=\"zui-sticky-col\">Name</th>";
                    for (int f1 = 2; f1 < table2.Columns.Count; f1++)
                    {
                        h2 += "<th>" + table2.Columns[f1].ColumnName.Substring(9) + "</th>";
                    }

                    h2 += "</tr>";
                    html += "<tr>" + h1 + "</tr>" + h2 + "</thead><tbody>";
                }

                entity_ctr = row["entity_ctr"].ToString();
                entityname = row["name"].ToString();

                html += "<tr><td class=\"zui-sticky-col\">" + entityname + "</td>";
                day = 0;

                for (int f1 = 2; f1 < table2.Columns.Count; f1++)
                {
                    colname = table2.Columns[f1].ColumnName.Substring(0, 8);
                    string columnvalue = row[f1].ToString();
                    if (columnvalue == "")
                    {
                        columnvalue = "0";
                    }
                    if (entity_ctr == guid)
                    {
                        if (colname != lastdate)
                        {
                            day++;
                            lastdate = colname;
                        }
                        html += "<td class=\"slot s" + columnvalue + "\" data-rank=\"" + columnvalue + "\" data-day=\"" + day + "\">&nbsp;</td>";
                    }
                    else
                    {
                        html += "<td class=\"s" + columnvalue + "\" data-rank=\"" + columnvalue + "\">&nbsp;</td>";
                    }
                }
                html += "</tr>";
            }
            html += "</tbody>";


            #region temp
            /*
            SqlCommand cmd2 = new SqlCommand("Get_Meeting_Slots", con);
            cmd2.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = 2;
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Connection = con;
            try
            {
                //con.Open();
                SqlDataReader dr = cmd2.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        if (html == "")
                        {
                            html += "<thead>";
                            //h1 += "<tr><th class=\"zui-sticky-col\">????</th>";
                            h2 += "<tr><th class=\"zui-sticky-col\">Name</th>";
                            for (int f1 = 2; f1 < dr.FieldCount; f1++)
                            {
                                if(dr.GetName(f1).Substring(0,8) != lastdate)
                                {
                                    lastdate = dr.GetName(f1).Substring(0,8);
                                }
                                h2 += "<th>" + dr.GetName(f1).Substring(9) + "</th>";
                            }

                            h2 += "</tr>";
                            html += h1 + h2 + "</thead><tbody>";
                        }

                        entity_ctr = Convert.ToInt16(dr["entity_ctr"]);
                        entityname = dr["name"].ToString();

                        html += "<tr><td class=\"zui-sticky-col\">" + entityname + "</td>";

                        for (int f1 = 2; f1 < dr.FieldCount; f1++)
                        {
                            string columnname = dr.GetName(f1);
                            string columnvalue = dr[f1].ToString();
                            if(columnvalue == "")
                            {
                                columnvalue = "0";
                            }
                            html += "<td class=\"slot s" + columnvalue + "\" data-rank=\"" + columnvalue + "\"></td>";
                        }
                    }
                    html += "</tr></tbody>";
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
            */
            #endregion

            Lit_html.Text = html;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}