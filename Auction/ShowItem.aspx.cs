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

namespace Auction
{
    public partial class ShowItem : System.Web.UI.Page
    {
        public string user_ctr;
        public string fullname;
        public string item_ctr;

        public string seq;
        public string title;
        public string shortdescription;
        public string description;
        public double reserve;
        public string retailprice;
        public string itemimages;
        public string donorimages;
        public double increment;
        public double startbid;
        public double autobid;

        public string hf_highestbid;
        public string hf_highestbidder;
        public string highestbidmessage;
        public string you;
        public string highestbidder;
        public string nextminimum;



        public string displayregister;
        public string displayloggedin;
        public string displaylogin;
        public string displayautobid = "None";
        public string autobidamount = "";
        public string autobidchecked = "";

        public Dictionary<string, string> parameters;
        protected void Page_Load(object sender, EventArgs e)
        {

            parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            if (parameters["Closeat"] != "")
            {
                if (DateTime.Now > Convert.ToDateTime(parameters["Closeat"]))
                {
                    //logout
                    HttpContext.Current.Session.Remove("Auction_user_ctr");
                    HttpContext.Current.Session.Remove("Auction_Fullname");

                    HttpContext.Current.Response.Cookies["Auction_user_ctr"].Expires = DateTime.Now.AddDays(-1);
                    HttpContext.Current.Response.Cookies["Auction_Fullname"].Expires = DateTime.Now.AddDays(-1);

                }
            }


            user_ctr = (string)Session["Auction_user_ctr"] ?? "";
            fullname = (string)Session["Auction_Fullname"] ?? "";

            //user_ctr = user_ctr ?? "";
            //fullname = fullname ?? "";

            if (user_ctr == "")
            {
                if (Request.Cookies["Auction_user_ctr"] != null)
                {
                    user_ctr = Request.Cookies["Auction_user_ctr"].Value + "";
                    fullname = Request.Cookies["Auction_Fullname"].Value + "";
                }
            }

            item_ctr = Request.QueryString["id"];

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Item", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    title = dr["title"].ToString();
                    shortdescription = dr["shortdescription"].ToString();
                    description = dr["Description"].ToString();
                    reserve = Convert.ToDouble(dr["Reserve"]);
                    retailprice = dr["RetailPrice"].ToString();
                    increment = Convert.ToDouble(dr["increment"]);
                    if(increment == 0)
                    {
                        increment = Convert.ToDouble(parameters["Increment"]);
                    }
                    startbid = Convert.ToDouble(dr["startbid"]);
                    
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

            itemimages = "";

            string imagefolder = Server.MapPath("images\\auction" + parameters["Auction_CTR"] + "\\items");
            string donorimagefolder = Server.MapPath("images\\auction" + parameters["Auction_CTR"] + "\\donors");

            string thisimagefolder = imagefolder + "\\" + item_ctr;
            if (Directory.Exists(thisimagefolder))
            {
                string[] files = Directory.GetFiles(thisimagefolder, "*.*", SearchOption.TopDirectoryOnly);
                foreach (string filename in files)
                {
                    string justfilename = System.IO.Path.GetFileName(filename);
                    //if (filename.EndsWith("gif") || filename.EndsWith("jpg") || filename.EndsWith("png"))
                    //{
                    itemimages += "<img src=\"images/auction" + parameters["Auction_CTR"] + "/items/" + item_ctr + "/" + justfilename + "\" />";
                    //}
                }
            }
            if (itemimages != "")
            {
                itemimages = "<div class=\"cycle-slideshow showitem-slideshow\" data-cycle-timeout=2000 data-cycle-log=false>" + itemimages + "</div>";
            }

            double yourbid;
            con = new SqlConnection(strConnString);
            cmd = new SqlCommand("Get_bid_information", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();

                    double currentbid = Convert.ToDouble(dr["amount"]);

                    string reservenote = "";
                    if (reserve > currentbid)
                    {
                        reservenote = " <span class=\"reservenote\">Reserve not met</span>";
                    }

                    string autobidnote = "";

                    hf_highestbid = currentbid.ToString("#.00");
                    hf_highestbidder = dr["user_ctr"].ToString();


                    if (hf_highestbidder == user_ctr)
                    {
                        you = " <b>(YOU!)</b>";
                        autobid = Convert.ToDouble(dr["autobid"]);
                        if (autobid > currentbid)
                        {
                            autobidnote = " <b>Autobid</b>: $" + autobid.ToString("#.00");
                        }
                    }
                    else
                    {
                        you = "";
                    }
                    highestbidmessage = "$" + hf_highestbid + autobidnote + reservenote;
                    highestbidder = dr["fullname"].ToString() + you;
                    yourbid = currentbid + increment;
                    if (yourbid < startbid) {
                        yourbid = startbid;
                    }
                    nextminimum = yourbid.ToString("#.00");
                }
                else
                {
                    hf_highestbid = "0";
                    highestbidmessage = "No bids yet .... be the first";
                    highestbidder = "Give it a go";
                    yourbid = startbid;
                    nextminimum = yourbid.ToString("#.00");
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
            if (user_ctr == "")
            {
                // usernamelabel = "Returning user?<br />Enter your pass code to bid:";
                //usernamedisplay = "<input name=\"passcode\" type=\"text\" id=\"passcode\">"; //replace with style
                displayloggedin = "none";
                displaylogin = "";
                displayregister = "";
            }
            else
            {
                //usernamelabel = "Logged in as:";
                //usernamedisplay = username + "&nbsp;&nbsp;<input type=\"button\" name=\"logout\" id=\"logout\" value=\"Log out\">"; //replace with style
                displayloggedin = "";
                displaylogin = "none";
                displayregister = "none";

                con = new SqlConnection(strConnString);
                cmd = new SqlCommand("Get_AutoBid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@user_ctr", SqlDbType.VarChar).Value = user_ctr;
                cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    double autobid = Convert.ToDouble(cmd.ExecuteScalar());
                    
                    //Get the an auto bid for this user and item if it is greater than the current bid -- This will also need to be done in data.asmx
                    if(autobid != 0)
                    {
                        displayautobid = "";
                        autobidamount = autobid.ToString("#.00");
                        //autobidchecked = " checked";
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
            }
        }
    }
}
