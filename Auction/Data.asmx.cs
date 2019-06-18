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
                if(TorF == "True")
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

        [WebMethod (EnableSession = true)]
        public void makebid(string item_ctr, double bid, string user_ctr, string passcode, string fullname, double increment)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
          
            Boolean userok = true;
            string status = "";
            string message = "";
            string highestbid = "";
            string highestbidder = "";
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
            //Boolean savebid;

            if (userok)
            {
                //savebid = false;

                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand("get_item_bids", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                //Should add bid item now if can  -- maybe not???
                cmd.Parameters.Add("@user_ctr", SqlDbType.VarChar).Value = user_ctr;
                cmd.Parameters.Add("@bid", SqlDbType.VarChar).Value = bid;
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();

                    double db_amount = Convert.ToDouble(dr["amount"]);
                    string db_user_ctr = dr["user_ctr"].ToString();
                    string title = dr["title"].ToString();
                    //double increment = Convert.ToDouble(dr["increment"]);

                    if (bid > db_amount) {
                        status = "Success";
                        message = "Your bid has been successful";
                        highestbid = bid.ToString("#.00");
                        highestbidder = fullname + " (YOU!)";
                        nextbid = bid + increment;
                        nextminimum = nextbid.ToString("#.00");
                        //savebid = true;
                        if (db_user_ctr != user_ctr)
                        {
                            string body = "<html>";
                            body += "<head>";
                            body += "<title>The Great Ball - Charity Auction - You have been out bid</title>";
                            body += "</head>";
                            body += "<body>";
                            body += "<p>You have been outbid for the following</p>";
                            body += "<p><b>Item:</b>" + title + "</p>";
                            body += "<p><b>Your bid:</b> $" + db_amount.ToString("#.00") + "</p>";
                            body += "<p><b>New bid:</b> $" + bid.ToString("#.00") + "</p>";
                            body += "<p><b>Made by:</b> " + fullname + "</p>";
                            body += "<p><b>Next minimum bid:</b> $" + nextminimum + "</p>";
                            // body +="<p><a href=\"" + protocol + "://" + thissite + "/page.asp?item=" + rs("item_ctr") + "\"><b>MAKE A NEW BID</b></a></p>";
                            body += "</body>";
                            body += "</html>";
                            //send email
                        }
                    }
                }
                else
                {
                    status = "Success";
                    message = "Thank you for starting the bidding, your bid has been successful";
                    highestbid = bid.ToString("#.00");
                    highestbidder = fullname + " (YOU!)";
                    nextbid = bid + increment;
                    nextminimum = nextbid.ToString("#.00");

                    //savebid = true;
                }
                con.Close();

                /*
                if (savebid) { 
                    SqlCommand cmdu = new SqlCommand("insert into bid (user_ctr, item_ctr, amount) values (" + user_ctr + ", " + item_ctr + ", " + bid + ")", con);
                    cmdu.CommandType = CommandType.Text;
                    cmdu.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                    cmdu.Connection = con;
                    con.Open();
                    cmdu.ExecuteNonQuery();
                    con.Close();
                }
                */
                con.Dispose();

                /*
                  if (textnotifications != "1")
                  {
                      //string txtmessage = "U hve been outbid on " + dr["title"] + "Bid at: " + thisSite + "/page.asp?item=" + dr["item_ctr"].ToString();
                      string mobile = dr["mobilenumber"].ToString();
                      //SendMessages
                  }
                  */

            }

            makeBidResponse resultclass = new makeBidResponse();
            resultclass.status = status;
            resultclass.message = message;
            resultclass.user_ctr = user_ctr;
            resultclass.fullname = fullname;
            resultclass.highestbid = highestbid;
            resultclass.highestbidder = highestbidder;
            resultclass.nextminimum = nextminimum;

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            Context.Response.Write(passresult);
        }
        #region oldcode
        /*

        SELECT top 1 Bid.Bid_ctr, Bid.Item_CTR, Bid.Amount, Item.Title, user.user_ctr, user.emailaddress, user.mobilenumber, 
        User.Fullname, user.TextNotifications 

       FROM ([User] INNER JOIN Bid ON User.User_ctr = Bid.User_CTR) INNER JOIN Item ON Bid.Item_CTR = Item.Item_CTR 
       WHERE Bid.Item_CTR = " & id & " ORDER BY Bid.Amount DESC


        rs.Open sqlstring, db
        if( rs.eof )
            status = "Success"
            message = "Thank you for starting the bidding, your bid has been successful"
            highestbid = bid
            highestbidder = fullname & " (YOU!)"
            nextminimum = "$" & bid + 10 & ".00"
            nextbid = bid + 10
            savebid = true
        else
           if( Cint(bid) > cint(rs("amount")) )
                status = "Success"
                message = "Your bid has been successful"
                highestbid = bid
                highestbidder = fullname & " (YOU!)"
                nextminimum = "$" & bid + 10 & ".00"
                nextbid = bid + 10
                savebid = true
                if( CStr(rs("user_ctr")) <> CStr(userid) )
                    string body = "<title>The Great Ball - Charity Auction - You have been out bid</title>";
                    body = body & "</head>"
                    body = body & "<body>"
                    body = body & "<p>You have been outbid for the following</p>"
                    body = body & "<p><b>Item:</b>" & rs("title") & "</p>"
                    body = body & "<p><b>Your bid:</b> $" & rs("amount") & ".00</p>"
                    body = body & "<p><b>New bid:</b> $" & bid & ".00</p>"
                    body = body & "<p><b>Made by:</b> " & fullname & "</p>"
                    body = body & "<p><b>Next minimum bid:</b> $" & (Cint(bid)) + 10 & ".00</p>"
                    body = body & "<p><a href=""" & protocol & "://" & thissite & "/page.asp?item=" & rs("item_ctr") & """><b>MAKE A NEW BID</b></a></p>"
                    body = body & "</body>"
                    body = body & "</html>"
                    Set objMail = Server.CreateObject("CDONTS.NewMail")
                    objMail.To = rs("emailaddress")
                    objMail.BCC = "greg@datainn.co.nz"
                    objMail.From = "mail@datainn.co.nz"
                    objMail.Subject = "The Great Ball - Charity Auction - You have been out bid"
                }

   */

        #endregion

    }

        /*
        'on error resume next

                        sqlstring = "insert into Notifications (user_ctr, bid_ctr, item_ctr, txtmessage, emailmessage, amount, sendtexts, TextNotifications, textresponse) " & _
                                    "values (" & userid & ", " & rs("bid_ctr") & ", " & id & ", '" & replace(txtmessage, "'", "''") & "', '" & replace(body, "'", "''") & "', " & bid & ", '" & sendtexts & "', '" & rs("TextNotifications") & "', '" & textresponse & "')"
                        'response.write sqlstring
                        db.execute sqlstring
        'db.execute "insert into [log] ([Text]) values ('" & err.number & "')"
                    else
                        status = "Outbid"
                        message = "Another bid has been made before you, please try again."
                        highestbid = rs("amount")
                        highestbidder = rs("fullname")
                        nextminimum = "$" & rs("amount") + 10 & ".00"
                        nextbid = rs("amount") + 10
                    }
                }
                rs.close
                if( savebid )
                    sqlstring = " insert into bid (user_ctr, item_ctr, amount) values (" & userid & ", " & id & ", " & bid & ")"
                    db.execute sqlstring
                }
        set rs = nothing
        */

        /*
db.close
set db = nothing

Dim member
Set member = jsObject()
member("status") = status
member("message") = message
member("hf_userid") = userid
member("fullname") = fullname
member("hf_highestbid") = highestbid
member("highestbid") = "$" & highestbid & ".00"
member("highestbidder") = highestbidder
member("nextminimum") = nextminimum
member("bid") = nextbid
member.Flush
*/

        public class makeBidResponse
        {
            public string status;
            public string message;
            public string user_ctr;
            public string fullname;
            public string highestbid;
            public string highestbidder;
            public string nextminimum;

        }

}
