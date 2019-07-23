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
    public partial class Winners : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            string bid_ctr;
            string user_ctr;
            string fullname;
            string emailaddress;
            string mobilenumber;
            string item_ctr;
            string title;
            string created;
            double amount = 0;
            double autobid = 0;
            string response;
            double reserve = 0;

            string last_item_ctr = "";
            Boolean topbiddone = false;


            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Bids", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@order", SqlDbType.VarChar).Value = "-1";
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                      
                        //B.Bid_CTR, B.user_ctr, U.Fullname, U.EmailAddress, U.MobileNumber, I.Item_CTR, I.Title, B.Created, B.Amount, B.autobid, B.response
                        bid_ctr = dr["Bid_CTR"].ToString();
                        user_ctr = dr["user_ctr"].ToString();
                        fullname = dr["Fullname"].ToString();
                        emailaddress = dr["EmailAddress"].ToString();
                        mobilenumber = dr["MobileNumber"].ToString();
                        item_ctr = dr["Item_CTR"].ToString();
                        title = dr["Title"].ToString();
                        created = dr["Created"].ToString();
                        string amounttext = dr["amount"].ToString();
                        string autobidtext = dr["autobid"].ToString();
                        string reservetext = dr["reserve"].ToString();
                        if (amounttext != "")
                        {
                            amount = Convert.ToDouble(amounttext);
                        }
                        if (autobidtext != "")
                        {
                            autobid = Convert.ToDouble(autobidtext);
                        }
                        if (reservetext != "")
                        {
                            reserve = Convert.ToDouble(reservetext);
                        }
                        response = dr["response"].ToString();

                        
                        string space = "";
                        string myclass = "";
                        string reservenotmet = "";



                        if (last_item_ctr != item_ctr)
                        {
                            html += "<tr><td class=\"header\" colspan=\"7\">" + title + "</td></tr>";
                            /*
                            if (last_item_ctr != "")
                            {
                                html += "<tr class=\"divider\"><td colspan=\"7\"></td></tr>";
                            }
                            */
                            last_item_ctr = item_ctr;
                            topbiddone = false;
                        }
                        

                        if (response != "Leading" && response != "Autobid actioned")
                        {
                            myclass = "bidnotactioned";
                            space = " ";
                        }
                        else
                        {
                            if (topbiddone == true)
                            {
                                myclass += space + "earlierbid";
                                space = " ";
                            }
                            else
                            {
                                myclass += space + "topbid";
                                space = " ";
                                topbiddone = true;
                                if(reserve > amount)
                                {
                                    reservenotmet = "Reserve not met ";
                                }
                            }
                        }

                        /*
                        if (last_item_ctr == item_ctr)
                        {
                            myclass += space + "earlierbid";
                            //bidnotactioned = " class=\"bidnotactioned\"";
                            title = "";
                        }
                        else
                        {
                            if(response == "Leading") { 
                                myclass += space + "topbid";
                                last_item_ctr = item_ctr;
                            }
                        }
                        */
                        if (myclass != "")
                        {
                            myclass = " class=\"" + myclass + "\"";
                        }
                       

                        html += "<tr" + myclass + "><td></td><td>" + created + "</td><td>" + fullname + "</td><td class=\"numeric\">" + reservenotmet + reserve.ToString("0.00") + "</td><td class=\"numeric\">" + amount.ToString("0.00") + "</td><td class=\"numeric\">" + autobid.ToString("0.00") + "</td><td class=\"bidnotactionedtd\">" + response + "</td></tr>";
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