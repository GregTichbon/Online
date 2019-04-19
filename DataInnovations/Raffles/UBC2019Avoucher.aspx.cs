using Generic;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.Raffles
{
    public partial class UBC2019Avoucher : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["id"] ?? "";

            if (Request.Cookies["chefschoiceaccess"] == null)
            {
                Session["raffle_goto"] = "UBC2019AVoucher.aspx?id=" + guid;
                Response.Redirect("UBC2019ALogin.aspx");
            }
            else
            {
                string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                SqlConnection con = new SqlConnection(strConnString);
                con.Open();

                SqlCommand cmd = new SqlCommand();
                if (guid == "")
                {
                    html += "<table><thead><tr><th>Draw</th><th>Ticket</th><th>Name</th><th>Email</th><th>Phone</th><th>Status</th></tr></thead><tbody>";

                    cmd = new SqlCommand("Get_Raffle_Winners", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    try
                    {

                        SqlDataReader dr = cmd.ExecuteReader();

                        while (dr.Read())
                        {
                            string name = dr["purchaser"].ToString();
                            string mobile = dr["mobile"].ToString();
                            string email = dr["emailaddress"].ToString();
                            string identifier = dr["identifier"].ToString();
                            string draw = dr["draw"].ToString();
                            string ticketnumber = dr["ticketnumber"].ToString();
                            string greeting = dr["greeting"].ToString();
                            string status = dr["status"].ToString();
                            string notes = dr["notes"].ToString();
                            string response = dr["response"].ToString();
                            guid = dr["guid"].ToString();

                            if (email != "")
                            {
                                email = "<a href=\"mailto:" + email + "\">" + email + "</a>";
                            }

                            html += "<tr><td><a href=\"?id=" + guid + "\" target=\"ticket\">" + identifier + " " + draw + "</a></td><td>" + ticketnumber + "</td><td>" + name + "</td><td>" + email + "</td><td>" + mobile + "</td><td>" + status + "</td></tr>";
                        }

                        html += "</tbody></table>";



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
                else
                {
                    cmd = new SqlCommand("Get_Raffle_Winners", con);
                    cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = guid;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;

                    try
                    {

                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            dr.Read();

                            string raffleWinner_ID = dr["raffleWinner_ID"].ToString();
                            string name = dr["purchaser"].ToString();
                            string mobile = dr["mobile"].ToString();
                            string email = dr["emailaddress"].ToString();
                            string identifier = dr["identifier"].ToString();
                            string draw = dr["draw"].ToString();
                            string ticketnumber = dr["ticketnumber"].ToString();
                            string greeting = dr["greeting"].ToString();
                            string status = dr["status"].ToString();
                            string notes = dr["notes"].ToString();
                            string response = dr["response"].ToString();

                            html += "<input type=\"hidden\" id=\"hf_id\" value=\"" + raffleWinner_ID + "\">";
                            html += "<div class=\"bigfont\">";
                            html += "<table>";
                            html += "<tr><td>Draw</td><td>" + identifier + "/" + draw + "</td></tr>";

                            html += "<tr><td>Ticket </td><td>" + ticketnumber + "</td></tr>";
                            html += "<tr><td>Name </td><td>" + name + "</td></tr>";
                            if(email != "")
                            {
                                email = "<a href=\"mailto:" + email + "\">" + email + "</a>";
                            }
                            html += "<tr><td>Email</td><td>" + email + "</td></tr>";
                            html += "<tr><td>Phone</td><td>" + mobile + "</td></tr>";
                            html += "<tr><td>Notes</td><td>" + notes + "</td></tr>";
                            html += "<tr><td>Response</td><td>" + response + "</td></tr>";
                            html += "<tr><td>Status</td><td>";
                            //html += status;
                            Functions genericfunctions = new Functions();
                            string[] status_values = new string[3] { "Winner", "Ordered", "Collected" };
                            html += "<select class=\"bigfont\" id=\"sel_status\">";
                            html += Functions.populateselect(status_values, status, "None");
                            html += "</select>";
                            html += "</td></tr>";
                            html += "</table>";

                            html += "<br /><p class=\"pc\"><a href=\"?id=\">See all</a></p>";
                            html += "</div>";
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





                /*
                switch (winnerstatus)
                {
                    case "Winner":
                        break;
                    case "Ordered":
                        break;
                    case "Closed":
                        Session["raffleMessage"] = "Sorry, we have already processed your selection of: " + winnerresponse;
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                    case "Collected":
                        Session["raffleMessage"] = "Sorry, we have already processed your selection and delivered it.";
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                    default:
                        Session["raffleMessage"] = "Sorry, something has gone wrong.";
                        Response.Redirect("UBC2019AMessage.aspx");
                        break;
                }
                */
            }
        }
    }
}