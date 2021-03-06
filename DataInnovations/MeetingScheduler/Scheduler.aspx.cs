﻿using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.MeetingScheduler
{
    public partial class Scheduler : System.Web.UI.Page
    {
        public string meeting_ctr;
        public string meetingname;
        public string meetingtitle;
        public string thisentityname;
        public int cols;
        public int rowincrement;
        public string html;

        protected void Page_Load(object sender, EventArgs e)
        {
            string passed_entity_guid = Request.QueryString["entity"] + "";
            string passed_meeting_guid = Request.QueryString["meeting"] + "";

            if(passed_entity_guid == "" || passed_meeting_guid == "") {
                Response.Redirect("Default.aspx");
            }

            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);

            string meetingdescription = "";
            int timeslots;
            int duration;

            SqlCommand cmd1 = new SqlCommand("Get_Meeting", con);
            cmd1.Parameters.Add("@meeting_guid", SqlDbType.VarChar).Value = passed_meeting_guid;
            //cmd1.Parameters.Add("@???????", SqlDbType.VarChar).Value = guiduser_guid

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    meeting_ctr = dr["meeting_ctr"].ToString();
                    meetingname = dr["name"].ToString();
                    meetingtitle = dr["title"].ToString();
                    meetingdescription = dr["description"].ToString();
                    timeslots = Convert.ToInt16(dr["timeslots"]);
                    duration = Convert.ToInt16(dr["duration"]);
                    //should see that the entity_guid is in here otherwise don't show!!!

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

            //string html = "";
            html = "";
            string h1 = "";
            string h2 = "";
            string entity_ctr;
            string entity_guid;
            string entityname;
            string lastupdated;
            string lastdate = "";
            string theday = "";

            string colname;
            int cnt = 0;
            int d = 0;
            int day = 0;

            var table2 = new DataTable();
            using (var da = new SqlDataAdapter("Get_Meeting_Slots '" + passed_meeting_guid + "'", strConnString))
            {
                da.Fill(table2);
            }

            h1 += "<th class=\"zui-sticky-col\" title=\"" + meetingdescription + "\">" + meetingname + "<br />" + meetingtitle + "</th>";

            cols = table2.Columns.Count;
            for (int f1 = 4; f1 < cols; f1++)
            {
                colname = table2.Columns[f1].ColumnName.Substring(0, 9);
                if (colname != lastdate)
                {
                    if (cnt > 0)
                    {
                        d = 1 - d;
                        day++;
                        h1 += "<th class=\"day d" + d + "\" colspan=\"" + cnt + "\" data-day=\"" + day + "\">" + theday + " " + lastdate + "</th>";
                        cnt = 0;
                    }
                    lastdate = colname;
                    theday = Convert.ToDateTime(lastdate).ToString("ddd");
                }
                cnt++;
            }
            d = 1 - d;
            day++;
            h1 += "<th class=\"day d" + d + "\" colspan=\"" + cnt + "\" data-day=\"" + day + "\">" + theday + " " + lastdate + "</th>";

            rowincrement = 255 / table2.Rows.Count;
            foreach (DataRow row in table2.Rows)
            {
                if (html == "")
                {
                    html += "<thead>";
                    h2 += "<tr><th class=\"zui-sticky-col\">Name</th>";
                    for (int f1 = 4; f1 < cols; f1++)
                    {
                        h2 += "<th>" + table2.Columns[f1].ColumnName.Substring(10) + "</th>";
                    }

                    h2 += "</tr>";
                    html += "<tr>" + h1 + "</tr>" + h2 + "</thead><tbody>";
                }

                entity_ctr = row["entity_ctr"].ToString();
                entity_guid = row["guid"].ToString();
                entityname = row["name"].ToString();
                lastupdated = row["lastupdated"].ToString();

                if (String.Equals(passed_entity_guid, entity_guid, StringComparison.OrdinalIgnoreCase))
                {
                    thisentityname = entityname;
                    entityname = "<span class=\"myname\">" + entityname + "</span>";
                }

                html += "<tr><td class=\"zui-sticky-col\" title=\"" + lastupdated + "\">" + entityname + "</td>";
                day = 0;

                for (int f1 = 4; f1 < cols; f1++)
                {
                    colname = table2.Columns[f1].ColumnName.Substring(0, 9);
                    string columnvalue = row[f1].ToString();
                    /*
                    if (columnvalue == "")
                    {
                        columnvalue = "0";
                    }
                    */

                    if (String.Equals(passed_entity_guid, entity_guid, StringComparison.OrdinalIgnoreCase))
                    {
                        if (colname != lastdate)
                        {
                            day++;
                            lastdate = colname;
                        }
                        string start = table2.Columns[f1].ColumnName;

                        //html += "<td class=\"slot s" + columnvalue + "\" data-rank=\"" + columnvalue + "\" data-origrank=\"" + columnvalue + "\" data-day=\"" + day + "\" data-changed=\"0\" data-reference=\"" + entity_ctr + "|" + start + "\">&nbsp;</td>";
                        html += "<td class=\"slot s" + columnvalue + "\" data-rank=\"" + columnvalue + "\" data-col=\"" + f1 + "\" data-origrank=\"" + columnvalue + "\" data-day=\"" + day + "\" data-reference=\"" + entity_ctr + "|" + start + "\">&nbsp;</td>";
                    }
                    else
                    {
                        html += "<td class=\"s" + columnvalue + "\" data-rank=\"" + columnvalue + "\" data-col=\"" + f1 + "\" >&nbsp;</td>";
                    }
                }
                html += "</tr>";
            }

            html += "<tr><td class=\"zui-sticky-col\">Score</td>";
            for (int f1 = 4; f1 < cols; f1++)
            {
                html += "<td id=\"score_" + f1 + "\"></td>";
            }
            html += "</tr>";

            html += "</tbody>";

            //Lit_html.Text = html;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Update_Meeting_Slot", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();


            foreach (string key in Request.Form.Keys)
            {
                if (!(key.StartsWith("_") || key.StartsWith("btn_")))
                {
                    string[] reference = key.Split('|');
                    string entity_ctr = reference[0];
                    string startdatetime = reference[1];
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@meeting_ctr", SqlDbType.VarChar).Value = meeting_ctr;
                    cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = entity_ctr;
                    cmd.Parameters.Add("@startdatetime", SqlDbType.VarChar).Value = startdatetime;
                    cmd.Parameters.Add("@rank", SqlDbType.VarChar).Value = Request.Form[key];

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        //meetingname = dr["name"].ToString();
                    }
                    dr.Close();
                }
            }
            con.Close();
            con.Dispose();

            Functions funcs = new Functions();
            funcs.sendemailV2("datainn.co.nz", "meetingscheduler@datainn.co.nz", "Meeting Scheduler", "m33t1ng", "Meeting Scheduler update by: " + thisentityname, "Meeting: " + meetingname + ".  " + meetingtitle, "", "greg@datainn.co.nz", "", "");

            Response.Redirect(Request.RawUrl);

        }
    }
}
