using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Row
{
    public partial class RP7Import : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string racenumber = "";
            string racedescription = "";
            string distance = "";
            string time = "";
            string lastline = "";
            string racetype = "";
            string alpha = "";
            string club = "";
            string competitors = "";
            int crewcnt = 0;
            string eventnumber = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=RP7;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();




            string[] lines = System.IO.File.ReadAllLines(@"\\toh-dc\RedirectedFolders$\gtichbon\My Documents\Visual Studio 2017\Projects\ExtractRP7\ExtractRP7\wcc2.txt");

            foreach (string line in lines)
            {
                string myline = line + "                                ";
                /*
                if (myline.Contains("F4"))
                {
                    MessageBox.Show("1");
                }
                */
                if (myline.StartsWith("  RACE "))
                {
                    racenumber = myline.Substring(7, 3).Trim();
                    racedescription = myline.Substring(13, 45).Trim();
                    distance = myline.Substring(58, 4).Trim();
                    time = myline.Substring(66, 8).Trim();
                    lastline = "Race";
                }
                else if (lastline == "Race")
                {
                    if (line == "")
                    {
                        racetype = "Final";
                    }
                    else
                    {
                        racetype = myline.Substring(13, 6);
                    }
                    lastline = "";
                }
                else if (myline.StartsWith("  Time : "))
                {
                    cmd.CommandText = "insert into rp7race (number, eventnumber, description, distance, time, type) values (" + racenumber + "," + eventnumber + ",'" + racedescription + "'," + distance + ",'" + time + "','" + racetype + "')";
                    cmd.ExecuteNonQuery();
                    Response.Write(cmd.CommandText.ToString() + "<br />");
                    Response.Write(racenumber + " - " + racedescription + " - " + distance + " - " + time + " - " + racetype + "<br />");

                    if (competitors != "")
                    {
                        foreach (string name in competitors.Split(','))
                        {
                            cmd.CommandText = "insert into rp7person (crewnumber, name) values (" + crewcnt + ",'" + name.Replace("'","''") + "')";
                            cmd.ExecuteNonQuery();

                        }
                        Response.Write(competitors);
                    }
                    racenumber = "";
                    racedescription = "";
                    distance = "";
                    time = "";
                    lastline = "";
                    racetype = "";
                    alpha = "";
                    club = "";
                    competitors = "";
                    eventnumber = "";
                }
                else if (line == "  Lane PlaceCrew")
                {
                    //write race to db
                    //cmd.CommandText = "insert into rp7race (number, eventnumber, description, distance, time, type) values (" + racenumber + "," + eventnumber + ",'" + racedescription + "'," + distance + ",'" + time + "','" + racetype + "')";
                    //cmd.ExecuteNonQuery();
                    //Response.Write(cmd.CommandText.ToString() + "<br />");
                    //Response.Write(racenumber + " - " + racedescription + " - " + distance + " - " + time + " - " + racetype + "<br />");

                }
                else if (myline.Substring(7,4) == "____")
                {
                    if (competitors != "")
                    {
                        foreach(string name in competitors.Split(','))
                        {
                            cmd.CommandText = "insert into rp7person (crewnumber, name) values (" + crewcnt + ",'" + name.Replace("'","''") + "')";
                            cmd.ExecuteNonQuery();

                        }
                        Response.Write(competitors + "<br />");
                        competitors = "";
                    }
                    alpha = myline.Substring(3, 2).Trim();
                    eventnumber = myline.Substring(12, 2).Trim();
                    for (int f1 = 17; f1 < myline.Length; f1++)
                    {
                        string mychar = myline.Substring(f1, 1);
                        if (Regex.IsMatch(mychar, @"^\d+$"))
                        {
                            crewcnt++;
                            club = myline.Substring(12, f1 - 10).Trim();
                            //write alpha club to db
                            cmd.CommandText = "insert into rp7crew (number, racenumber, alpha, lane, club) values (" + crewcnt + "," + racenumber + ",'" + alpha.Substring(0,1) + "'," + alpha.Substring(1, 1) + ",'" + club.Replace("'","''") + "')";
                            cmd.ExecuteNonQuery();
                            Response.Write(racenumber + " - " + alpha + " - " + club + "<br />");

                            competitors += myline.Substring(f1 + 1).Trim();
                            break;
                        }
                    }
                    lastline = "detail";

                }
                else if (lastline == "detail" && line != "")
                {
                    if (competitors != "")
                    {
                        competitors += " ";
                    }
                    competitors += myline.Trim();
                }
            }
            con.Close();
            con.Dispose();

        }
    }
}