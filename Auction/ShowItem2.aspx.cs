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
    public partial class ShowItem2 : System.Web.UI.Page
    {
        public string user_ctr;
        public string username;
        public string item_ctr;

        public string seq;
        public string title;
        public string auctiontype;
        public string auctiontype_ctr;
        public string description;
        public string reserve;
        public string retailprice;
        public string itemimages;
        public string donorimages;

        public string hf_highestbid;
        public string highestbid;
        public string you;
        public string highestbidder;
        public string nextminimum;
        public string yourbid;


        public string displayregister;
        public string displayloggedin;
        public string displaylogin;


        protected void Page_Load(object sender, EventArgs e)
        {
            user_ctr = (string)Session["Auction_user_ctr"] ?? "";
            username = (string)Session["Auction_Fullname"] ?? "";

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
                    auctiontype = dr["auctiontype"].ToString();
                    description = dr["Description"].ToString();
                    reserve = dr["Reserve"].ToString();
                    retailprice = dr["RetailPrice"].ToString();
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

            string imagefolder = Server.MapPath("images\\auction\\items");
            string donorimagefolder = Server.MapPath("images\\auction\\donors");

            string thisimagefolder = imagefolder + "\\" + item_ctr;
            if (Directory.Exists(thisimagefolder))
            {
                string[] files = Directory.GetFiles(thisimagefolder, "*.*", SearchOption.TopDirectoryOnly);
                foreach (string filename in files)
                {
                    string justfilename = System.IO.Path.GetFileName(filename);
                    //if (filename.EndsWith("gif") || filename.EndsWith("jpg") || filename.EndsWith("png"))
                    //{
                    itemimages += "<img src=\"images/auction/items/" + item_ctr + "/" + justfilename + "\" border=\"0\" />" + System.Environment.NewLine;
                    //}
                }
            }
            if (itemimages != "")
            {
                itemimages = "<div class=\"cycle-slideshow item-slideshow\" data-cycle-timeout=2000 data-cycle-log=false>" + System.Environment.NewLine + itemimages + "</div>" + System.Environment.NewLine;
            }
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
                    hf_highestbid = dr["amount"].ToString();
                    highestbid = "$" + dr["amount"].ToString() + ".00";
                    if (dr["user_ctr"].ToString() == user_ctr)
                    {
                        you = " (YOU!)";
                    }
                    else
                    {
                        you = "";
                    }
                    highestbidder = dr["fullname"].ToString() + you;
                    nextminimum = "$" + dr["amount"].ToString() + 10 + ".00";
                    yourbid = dr["amount"].ToString() + 10;
                }
                else
                {
                    hf_highestbid = "0";
                    highestbid = "No bids yet .... be the first";
                    highestbidder = "Give it a go";
                    nextminimum = "$10.00";
                    yourbid = "10";
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
            }
        }
    }
}
