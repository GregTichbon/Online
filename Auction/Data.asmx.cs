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
using System.Web.Services;
using System.Web.Script.Serialization;
using Generic;

namespace Auction
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Data : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public void logout()
        {
            HttpContext.Current.Session.Remove("Auction_user_ctr");
            HttpContext.Current.Session.Remove("Auction_Fullname");

            HttpContext.Current.Response.Cookies["Auction_user_ctr"].Expires = DateTime.Now.AddDays(-1);
            HttpContext.Current.Response.Cookies["Auction_Fullname"].Expires = DateTime.Now.AddDays(-1);
        }

        [WebMethod]
        public void verifyemailaddress(string r_emailaddress)
        {
            Boolean response = false;
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("VerifyEmailAddress", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = r_emailaddress;
            cmd.Connection = con;
            try
            {
                con.Open();
                string TorF = cmd.ExecuteScalar().ToString();
                if (TorF == "True")
                {
                    response = true;
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

            //return response;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(response));

        }

        [WebMethod(EnableSession = true)]
        public void verifypasscode()
        {
            Context.Response.Write(true);
        }

        [WebMethod(EnableSession = true)]
        public void makebid(string item_ctr, double bid, string user_ctr, string passcode, string fullname, double increment, string autobid = "false")
        {
            //http://localhost:50459/data.asmx/makebid?user_ctr=2&item_ctr=23&bid=140.00&fullname=Neo Tichbon&passcode=undefined&increment=10&autobid=
            Dictionary<string, string> parameters;
            parameters = General.Functions.Functions.get_Auction_Parameters(Context.Request.Url.AbsoluteUri);

            Generic.Functions gFunctions = new Generic.Functions();
            string emailBCC = parameters["EmailAlerts"];
            string host = parameters["EmailHost"];
            string emailfrom = parameters["EmailFrom"];
            string emailfromname = parameters["EmailFromName"];
            string password = parameters["EmailPassword"];
            string bidemail = parameters["BidEmail"];
            string bidtext = parameters["BidText"];
            string bidlog = parameters["BidLog"];
            string advisetest = parameters["AdviseTest"];

            Dictionary<string, string> emailoptions = new Dictionary<string, string>();
            /*
            if (bidemail.Contains("log")) {
                emailoptions.Add("log", "");
            }
            */
            Dictionary<string, string> textoptions = new Dictionary<string, string>();
            /*
            if (bidtext.Contains("log"))
            {
                textoptions.Add("log", "");
            }
            */


            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;

            Boolean userok = true;
            string status = "";
            string message = "";
            string highestbid = "";
            string highestbidmessage = "";
            string highestbidder_user_ctr = "";
            string highestbidder_fullname = "";
            string thisusersautobid = "";
            double nextbid = 0;
            string nextminimum = "";

            if (user_ctr == "" && passcode != "")
            {
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("Get_User", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@passcode", SqlDbType.VarChar).Value = passcode;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        user_ctr = dr["user_ctr"].ToString();
                        fullname = dr["fullname"].ToString();
                        string emailaddress = dr["emailaddress"].ToString();
                        string mobilenumber = dr["mobilenumber"].ToString();
                        HttpContext.Current.Session.Add("Auction_user_ctr", user_ctr);
                        HttpContext.Current.Session.Add("Auction_Fullname", fullname);
                    }
                    else
                    {
                        status = "Invalid pass code";
                        message = "Sorry - we didn't recognise the pass code";
                        userok = false;
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

            if (userok)
            {
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("make_bid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                cmd.Parameters.Add("@user_ctr", SqlDbType.VarChar).Value = user_ctr;
                cmd.Parameters.Add("@bid", SqlDbType.VarChar).Value = bid;
                cmd.Parameters.Add("@autobidflag", SqlDbType.VarChar).Value = autobid;
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                dr.Read();

                string db_response = dr["response"].ToString();
                string db_result = dr["result"].ToString();
                //double db_reserve = Convert.ToDouble(dr["reserve"]);
                string db_reservemessage = dr["reservemessage"].ToString();
                string db_title = dr["title"].ToString();
                double db_newbid = Convert.ToDouble(dr["newbid"]);
                string db_newuser_ctr = dr["newuser_ctr"].ToString();
                string db_newfullname = dr["newfullname"].ToString();

                string db_otheruser_ctr = dr["otheruser_ctr"].ToString();
                string db_adviseotherbidder = dr["adviseotherbidder"].ToString();
                double db_thisusersautobid = Convert.ToDouble(dr["thisusersautobid"]);

                thisusersautobid = db_thisusersautobid.ToString("#.00");

                double db_lastbid = 0;
                double db_otherautobid = 0;
                string db_otherfullname = "";
                string db_otheremailaddress = "";
                string db_othermobilenumber = "";

                if (db_adviseotherbidder != "" && db_otheruser_ctr != "")
                {
                    db_lastbid = Convert.ToDouble(dr["lastbid"]);
                    db_otherautobid = Convert.ToDouble(dr["otherautobid"]);
                    db_otherfullname = dr["otherfullname"].ToString();
                    db_otheremailaddress = dr["otheremailaddress"].ToString();
                    db_othermobilenumber = dr["othermobilenumber"].ToString();
                }

                string autobidnote = "";
                if (db_thisusersautobid > db_newbid)
                {
                    autobidnote = " <b>Autobid: $" + thisusersautobid;
                }

                string reservenote = "";
                string reservemessage = "";
                if (db_reservemessage != "")
                {
                    reservenote = " <span class=\"reservenote\">Reserve not met</span>";
                    reservemessage = ", however, the reserve price has not yet been reached";
                }
                //double increment = Convert.ToDouble(dr["increment"]);
                string body = "";
                string subject = "";
                string replyto = "";
                string[] attachments = new string[0];

                status = db_result;
                message = db_response + reservemessage;
                highestbid = db_newbid.ToString("#.00");
                highestbidmessage = "$" + highestbid + autobidnote + reservenote;

                highestbidder_user_ctr = db_newuser_ctr;
                highestbidder_fullname = db_newfullname;

                if (highestbidder_user_ctr == user_ctr)
                {
                    highestbidder_fullname += " <b>(YOU!)</b>";
                }
                nextbid = db_newbid + increment;
                nextminimum = nextbid.ToString("#.00");

                if (db_adviseotherbidder != "")
                {
                    if (advisetest == "Yes")
                    {
                        message += "<br />Email to: " + db_otheremailaddress;
                        message += "<br />Text to: " + db_othermobilenumber;
                        message += "<br />You have been outbid";
                        message += "<br />Your bid: $" + db_lastbid.ToString("#.00");
                        message += "<br />New bid: $" + db_newbid.ToString("#.00") + reservemessage;
                        message += "<br />Made by: " + db_newfullname;
                        message += "<br />Next minimum bid: $" + nextminimum;
                    }
                    else
                    {
                        if (bidemail == "Yes")
                        {
                            body = "<html>";
                            body += "<head>";
                            body += "<title>" + parameters["Auction"] + " - You have been out bid</title>";
                            body += "</head>";
                            body += "<body>";
                            body += "<p>You have been outbid for the following</p>";
                            body += "<p><b>Item:</b>" + db_title + "</p>";
                            body += "<p><b>Your bid:</b> $" + db_lastbid.ToString("#.00") + "</p>";
                            body += "<p><b>New bid:</b> $" + db_newbid.ToString("#.00") + reservemessage + ".</p>";
                            body += "<p><b>Made by:</b> " + db_otherfullname + "</p>";
                            body += "<p><b>Next minimum bid:</b> $" + nextminimum + "</p>";
                            body += "<p><a href=\"" + parameters["URL"] + "\"><b>MAKE A NEW BID</b></a></p>"; //Would like to go to the item
                            body += "</body>";
                            body += "</html>";


                            //Array.Resize(ref attachments, attachments.Length + 1);
                            //attachments[attachments.GetUpperBound(0)] = filename;
                            subject = parameters["Auction"] + " - Charity Auction - You have been out bid";
                            replyto = "";

                            gFunctions.sendemailV4(host, emailfrom, emailfromname, password, subject, body, db_otheremailaddress, emailBCC, replyto, attachments, emailoptions);
                        }


                        if (bidtext == "Yes" && db_othermobilenumber != "")
                        {
                            string textmessage = parameters["Auction"] + " - You have been out bid on \"" + db_title + "\". Make a new bid at: " + parameters["URL"];
                            //gFunctions.SendRemoteMessage(db_mobilenumber, textmessage, parameters["Auction"] + " out bid"); 
                            General.Functions.Functions.sendtext(db_othermobilenumber, textmessage);
                        }
                    }
                    if (bidlog == "Yes")
                    {
                        //item_ctr, user_ctr, bid, autobid, subject, body, db_emailaddress, emailBCC, replyto, attachments.ToString(), emailoptions.ToString()
                    }
                }
                #region oldcode
                /*
                if (db_otheruser_ctr != "")
                {
                    if (db_newbid > db_lastbid) {
                        status = "Success";
                        message = "Your bid is leading" + reservemessage + ".";
                        highestbid = db_newbid.ToString("#.00") + autobidnote + reservenote;
                        highestbidder = fullname + " (YOU!)";
                        nextbid = db_newbid + increment;
                        nextminimum = nextbid.ToString("#.00");
                        if (db_otheruser_ctr != user_ctr)
                        {
                            if (testMode)
                            {
                                message += "<br />Email to: " + db_otheremailaddress;
                                message += "<br />You have been outbid";
                                message += "<br />Your bid: $" + db_lastbid.ToString("#.00");
                                message += "<br />New bid: $" + db_newbid.ToString("#.00") + reservemessage;
                                message += "<br />Made by: " + db_otherfullname;
                                message += "<br />Next minimum bid: $" + nextminimum;

                            }
                            else
                            {
                                if (bidemail == "Yes")
                                {
                                    body = "<html>";
                                    body += "<head>";
                                    body += "<title>" + parameters["Auction"] + " - You have been out bid</title>";
                                    body += "</head>";
                                    body += "<body>";
                                    body += "<p>You have been outbid for the following</p>";
                                    body += "<p><b>Item:</b>" + db_title + "</p>";
                                    body += "<p><b>Your bid:</b> $" + db_lastbid.ToString("#.00") + "</p>";
                                    body += "<p><b>New bid:</b> $" + db_newbid.ToString("#.00") + reservemessage + ".</p>";
                                    body += "<p><b>Made by:</b> " + db_otherfullname + "</p>";
                                    body += "<p><b>Next minimum bid:</b> $" + nextminimum + "</p>";
                                    body += "<p><a href=\"" + parameters["URL"] + "\"><b>MAKE A NEW BID</b></a></p>"; //Would like to go to the item
                                    body += "</body>";
                                    body += "</html>";


                                    //Array.Resize(ref attachments, attachments.Length + 1);
                                    //attachments[attachments.GetUpperBound(0)] = filename;
                                    subject = parameters["Auction"] + " - Charity Auction - You have been out bid";
                                    replyto = "";

                                    gFunctions.sendemailV4(host, emailfrom, emailfromname, password, subject, body, db_otheremailaddress, emailBCC, replyto, attachments, emailoptions);
                                }
                            }
                            if (testMode)
                            {

                            }
                            else
                            {
                                if (bidtext == "Yes" && db_othermobilenumber != "")
                                {
                                    string textmessage = parameters["Auction"] + " - You have been out bid on \"" + db_title + "\". Make a new bid at: " + parameters["URL"];
                                    //gFunctions.SendRemoteMessage(db_mobilenumber, textmessage, parameters["Auction"] + " out bid"); 
                                    General.Functions.Functions.sendtext(db_othermobilenumber, textmessage);
                                }
                            }
                            if (bidlog == "Yes")
                            {
                                //item_ctr, user_ctr, bid, autobid, subject, body, db_emailaddress, emailBCC, replyto, attachments.ToString(), emailoptions.ToString()
                            }
                        }
                    }
                    else
                    {
                        status = "Failed";
                        message = db_response;
                        highestbid = db_newbid.ToString("#.00") + autobidnote + reservenote;
                        highestbidder = db_otherfullname;
                        nextbid = db_newbid + increment;
                        nextminimum = nextbid.ToString("#.00");
                        //Tell previous bidder that his bid has been incremented
                        if (db_adviseotherbidder != "")
                        {
                            if (testMode)
                            {
                                message += "<br />Email to: " + db_otheremailaddress;
                                message += "<br />Your autobid has been actioned";
                                message += "<br />Your bid: $" + db_newbid.ToString("#.00") + reservemessage;
                                message += "<br />Your autobid: $" + "???";
                                message += "<br />Next minimum bid: $" + nextminimum;
                            }
                            else
                            {
                                if (bidemail == "Yes" && db_otheremailaddress != "")
                                {
                                    body = "<html>";
                                    body += "<head>";
                                    body += "<title>The Great Ball - Charity Auction - Your autobid has been actioned</title>";
                                    body += "</head>";
                                    body += "<body>";
                                    body += "<p>Your autobid has been actioned</p>";
                                    body += "<p><b>Item:</b>" + db_title + "</p>";
                                    body += "<p><b>Your bid:</b> $" + db_newbid.ToString("#.00") + reservemessage + ".</p>";
                                    body += "<p><b>Next minimum bid:</b> $" + nextminimum + "</p>";
                                    // body +="<p><a href=\"" + protocol + "://" + thissite + "/page.asp?item=" + rs("item_ctr") + "\"><b>VIEW ITEM</b></a></p>";
                                    body += "</body>";
                                    body += "</html>";

                                    //Array.Resize(ref attachments, attachments.Length + 1);
                                    //attachments[attachments.GetUpperBound(0)] = filename;

                                    gFunctions.sendemailV4(host, emailfrom, emailfromname, password, "The Great Ball - Charity Auction - Your autobid has been actioned", body, db_otheremailaddress, emailBCC, "", attachments, emailoptions);
                                }
                            }
                            if (testMode)
                            {

                            }
                            else
                            {
                                if (bidtext == "Yes" && db_othermobilenumber != "")
                                {
                                    string textmessage = parameters["Auction"] + " - Your autobid has been actioned on \"" + db_title + "\".";
                                    //gFunctions.SendRemoteMessage(db_mobilenumber, textmessage, parameters["Auction"] + " autobid");
                                    General.Functions.Functions.sendtext(db_othermobilenumber, textmessage);
                                }
                            }
                            if (bidlog == "Yes")
                            {
                                //item_ctr, user_ctr, bid, autobid, subject, body, db_emailaddress, emailBCC, replyto, attachments.ToString(), emailoptions.ToString()
                            }
                        }
                    }
                }
                else
                {
                    status = "Success";
                    message = "Thank you for starting the bidding, your bid of $" + bid.ToString("#.00") + " is leading" + reservemessage + ".";
                    highestbid = db_newbid.ToString("#.00") + autobidnote + reservenote;
                    highestbidder = fullname + " (YOU!)";
                    nextbid = bid + increment;
                    nextminimum = nextbid.ToString("#.00");
                }
                */
                #endregion
                con.Close();
                con.Dispose();
            }

            makeBidResponse resultclass = new makeBidResponse();
            resultclass.status = status;
            resultclass.message = message;
            resultclass.user_ctr = user_ctr;
            resultclass.fullname = fullname;
            resultclass.highestbid = highestbid;
            resultclass.highestbidmessage = highestbidmessage;
            resultclass.highestbidder_user_ctr = highestbidder_user_ctr;
            resultclass.highestbidder_fullname = highestbidder_fullname;
            resultclass.nextminimum = nextminimum;
            resultclass.autobid = thisusersautobid;
            //resultclass.reservenote = reservenote;

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            Context.Response.Write(passresult);
        }
    }

    public class makeBidResponse
{
    public string status;
    public string message;
    public string user_ctr;  //for the passcode option
    public string fullname;  //for the passcode option
    public string highestbid;
    public string highestbidmessage;
    public string highestbidder_user_ctr;
    public string highestbidder_fullname;
    public string nextminimum;
    public string autobid;
    //public string reservenote;
}

}
