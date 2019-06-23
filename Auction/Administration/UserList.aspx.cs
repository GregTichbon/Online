using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction.Administration
{
    public partial class UserList : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            string user_ctr;
            string fullname;
            string emailaddress;
            string mobilenumber;
            string passcode;
            string textnotifications;
            int itemsbidon;


            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Users", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = parameters["Auction_CTR"];
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        user_ctr = dr["user_ctr"].ToString();
                        fullname = dr["fullname"].ToString();
                        emailaddress = dr["emailaddress"].ToString();
                        mobilenumber = dr["mobilenumber"].ToString();
                        passcode = dr["passcode"].ToString();
                        textnotifications = dr["textnotifications"].ToString();
                        itemsbidon = Convert.ToInt16(dr["itemsbidon"]);

                        string itemsbidonlink = "";
                        if (itemsbidon > 0)
                        {
                            //itemsbidonlink = "<a href=\"useritemsbidon.aspx?user=" + user_ctr + "\" target=\"useritemsbidon\">" + itemsbidon.ToString() + "</a>";
                            itemsbidonlink = "<span class=\"itemsbidon\" id=\"user_" + user_ctr + "\">" + itemsbidon.ToString() + " - View</span>";
                        }

                        html += "<tr><td><a href=user.aspx?id=" + user_ctr + ">" + fullname + "</a><td>" + emailaddress + "</td><td>" + mobilenumber + "</td><td>" + passcode + "</td><td>" + textnotifications + "</td><td>" + itemsbidonlink + "</td></tr>";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Close();
                con.Close();
                con.Dispose();
            }
        }
    }
}