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
    public partial class Select : System.Web.UI.Page
    {
        public string meeting_name;
        public string meeting_title;
        public string meeting_description;
        public string table = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string meeting_ctr = "";
            string entity_ctr = "";
            string sql = "";

            string id = Request.QueryString["ID"];
            //id = "C97A0959-5F86-4FC7-8611-2BDA723D6FDF";
            string connectionString = "Data Source=toh-app;Initial Catalog=MeetingScheduler;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                sql = "select * from meeting_entity where guid = '" + id + "'";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.CommandType = CommandType.Text;

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        meeting_ctr = dr["meeting_ctr"].ToString();
                        entity_ctr = dr["entity_ctr"].ToString();

                    }
                    dr.Close();

                }
                if (meeting_ctr != "")
                {

                    sql = "select * from meeting where meeting_ctr = " + meeting_ctr;
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.CommandType = CommandType.Text;

                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();
                            meeting_name = dr["name"].ToString();
                            meeting_description = dr["Description"].ToString();
                            DateTime open = (DateTime)dr["opendatetime"];
                            DateTime close = (DateTime)dr["closedatetime"];
                            int duration = (int)dr["duration"];
                            meeting_title = dr["title"].ToString();
                            string type = dr["type"].ToString();

                            //.formatdate(dr["EventDate"].ToString(), "dd MMM yyyy HH:mm");
                        }
                        dr.Close();

                    }



                    var dt = new DataTable();
                    using (var da = new SqlDataAdapter("Get_MeetingOptions", con))
                    {
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                        da.SelectCommand.Parameters.Add("@meeting_ctr", SqlDbType.Int).Value = meeting_ctr;
                        da.Fill(dt);
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (table == "")
                            {
                                table = "<thead><tr><th></th>";
                                for (int f1 = 1; f1 < dt.Columns.Count; f1++)
                                {
                                    DateTime start = Convert.ToDateTime(dt.Columns[f1].ColumnName.Split('|')[0]);

                                    table += "<th>" + start.ToString("ddd d MMM yy\"<br />\"h:mmtt") + "</th>";
                                }
                                table += "</tr></thead><tbody>";
                            }
                            table += "<tr>";
                            string myclass = "";
                            string myclasslabel = "";
                            string entity = "";

                            string[] nameParts = dr[0].ToString().Split('|');
                            if (nameParts[1] == entity_ctr)
                            {
                                myclass = " mine";
                                myclasslabel = "mylabel";
                                entity = " data-entity=\"" + entity_ctr + "\"";

                            }
                            table += "<th class=\"" + myclasslabel + "\">" + nameParts[0] + "</th>";

                            for (int f1 = 1; f1 < dt.Columns.Count; f1++)
                            {
                                string ids = "";
                                if (entity != "")
                                {
                                    ids = entity + " data-option=\"" + dt.Columns[f1].ColumnName.Split('|')[1] + "\"";
                                }
                                string value = "";
                                switch (dr[f1])
                                {
                                    case 0:
                                        value = "No";
                                        break;
                                    case 1:
                                        value = "Yes";
                                        break;
                                    default:
                                        break;
                                }
                                table += "<td class=\"c" + dr[f1] + myclass + "\"" + ids + ">" + value + "</td>";
                            }
                            table += "</tr>";
                        }
                        table += "</tbody>";

                    }
                }
                con.Close();

            }
        }
    }
}