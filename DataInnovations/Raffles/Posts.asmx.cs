using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DataInnovations.Raffles
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS
    public class Posts : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getticket(NameValue[] formVars)    //you can't pass any querystring params
        {
            string guid = Guid.NewGuid().ToString();
            Generic.Functions gFunctions = new Generic.Functions();

            string host = "70.35.207.87";
            string emailfrom = "raffles@datainn.co.nz";
            string emailfromname = "Union Boat Club - Raffle";
            string password = "39%3Zxon";
            string emailBCC = "greg@datainn.co.nz";


            string update = formVars.Form("hf_update");
            string ticket = formVars.Form("hf_ticket");
            string bankaccount = formVars.Form("hf_bankaccount");
            string rafflename = formVars.Form("hf_rafflename");
            string detail = formVars.Form("hf_detail");
            string identifier = formVars.Form("hf_identifier");

            string[] ticketparts = ticket.Split('-');
            string raffle = ticketparts[0];
            ticket = ticketparts[1];

            string strConnString = "Data Source=toh-app;Initial Catalog=DataInnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            string sql1 = "select * from raffleticket where raffle_id = '" + raffle + "' and ticketnumber = " + ticket;

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand(sql1, con);

            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            string purchaser;
            string status = "";
            string messageresponse = "";
            dr.Read();

            purchaser = dr["purchaser"].ToString();

            dr.Close();
            if (purchaser != "")
            {
                status = "Taken";
            }
            else
            {
                if (update == "yes")
                {
                    //Do update


                    string name = formVars.Form("tb_name") + "";
                    string emailaddress = formVars.Form("tb_emailaddress") + "";
                    string mobile = formVars.Form("tb_mobile") + "";
                    string payment = formVars.Form("tb_payment") + "";
                    string taken = DateTime.Now.ToString("dd MMM yyyy HH:mm:ss");

                    gFunctions.Log(guid, @"Raffle/posts.asmx", name + ", " + emailaddress + ", " + mobile + ", " + payment + ", " + taken , "");


                    name = name.Replace("'", "''");
                    emailaddress = emailaddress.Replace("'", "''");
                    mobile = mobile.Replace("'", "''");
                    payment = payment.Replace("'", "''");
                    if(payment == "")
                    {
                        payment = "Transfer to bank account";
                    }

                    string sql2 = "update raffleticket set purchaser = '" + name + "', emailaddress = '" + emailaddress + "', mobile = '" + mobile + "', paymentdetail = '" + payment + "', taken = '" + taken + "' where raffle_id = " + raffle + " and ticketnumber = " + ticket;


                    gFunctions.Log(guid, @"Raffle/posts.asmx","Before Update","");
                    SqlCommand cmdu = new SqlCommand(sql2, con);
                    cmdu.ExecuteNonQuery();
                    gFunctions.Log(guid, @"Raffle/posts.asmx", "After Update", "");

                    status = "Updated";

                    /*
                    string rafflename = "";
                    switch (raffle)
                    {
                        case "1":
                            rafflename = "'Pale Yellow' $50.00 meat";
                            break;
                        case "2":
                            rafflename = "'Outdoor Table'";
                            break;
                        case "3":
                            rafflename = "'Red' $50.00 meat";
                            break;
                        case "4":
                            rafflename = "'White' $50.00 meat";
                            break;
                        case "5":
                            rafflename = "'Yellow' $50.00 meat";
                            break;
                        case "7":
                            rafflename = "'Black' $50.00 meat";
                            break;
                        default:
                            Console.WriteLine("Default case");
                            break;
                    }
                    */

                    string emailhtml = "Thanks for taking ticket " + ticket + " in the " + rafflename;
                    emailhtml += "<table>";
                    emailhtml += "<tr><td>Name </td><td>" + name + "</td></tr>";
                    emailhtml += "<tr><td>Email Address </td><td>" + emailaddress + "</td></tr>";
                    emailhtml += "<tr><td>Mobile Number </td><td>" + mobile + "</td></tr>";
                    emailhtml += "<tr><td>Cost </td><td>$20.00</td></tr>";

                    emailhtml += "<tr><td>How will you get the money to us? </td><td>" + payment + "</td></tr>";
                    emailhtml += "</table>";

                    emailhtml += "<p>Bank A/c: " + bankaccount + "<br />Reference: Your name and '" + identifier + "-" + ticket + "'</p>";

                    emailhtml += "Contact Greg: 0272495088 <a href=\"mailto:greg@datainn.co.nz\">greg@datainn.co.nz</a>";
                    emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "Before Email",  "");
                    gFunctions.Log(guid, @"Raffle/posts.asmx", host + "," + emailfrom + "," + emailfromname + "," + password + "," + rafflename + "," + emailhtml + "," + emailaddress + "," + emailBCC + "," + "", "");

                    try
                    {
                        gFunctions.sendemailV3(host, emailfrom, emailfromname, password, rafflename, emailhtml, emailaddress, emailBCC, "");
                    }
                    catch (Exception e)
                    {
                        gFunctions.Log(guid, @"Raffle/posts.asmx", "Error: gFunctions.sendemailV3", "");
                        //messageresponse = gFunctions.SendRemoteMessage(mobile, e.InnerException.ToString(), "ERROR");
                    }

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "After Email", "");


                    string textbody = "Thanks for taking ticket " + ticket + " in the " + rafflename + System.Environment.NewLine;
                    textbody += " Cost: $20.00" + System.Environment.NewLine;
                    textbody += " Bank A/c: " + bankaccount + " reference: Your name and " + identifier + "-" + ticket + System.Environment.NewLine;
                    textbody += " - Greg: 0272495088, greg@datainn.co.nz";

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "Before first text", "");

                    try
                    {
                        messageresponse = gFunctions.SendRemoteMessage(mobile, textbody, "Raffle Purchase");
                    }
                    catch (Exception e)
                    {
                        gFunctions.Log(guid, @"Raffle/posts.asmx", "Error: gFunctions.SendRemoteMessage", "");
                        //messageresponse = gFunctions.SendRemoteMessage(mobile, e.InnerException.ToString(), "ERROR");
                    }

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "After first text", "");

                    textbody += System.Environment.NewLine + name + System.Environment.NewLine + mobile + System.Environment.NewLine + emailaddress + System.Environment.NewLine + payment;

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "Before second text", "");

                    try
                    {
                        messageresponse = gFunctions.SendRemoteMessage("0272495088", textbody, "Raffle Purchase - organiser");
                    }
                    catch (Exception e)
                    {
                        gFunctions.Log(guid, @"Raffle/posts.asmx", "Error: gFunctions.SendRemoteMessage", "");
                        //messageresponse = gFunctions.SendRemoteMessage(mobile, e.InnerException.ToString(), "ERROR");
                    }

                    gFunctions.Log(guid, @"Raffle/posts.asmx", "After second text", "");

                    //status = sql;
                }
                else
                {
                    status = "Available";
                }
            }

            con.Close();
            con.Dispose();

            standardResponse resultclass = new standardResponse();
            resultclass.status = status;
            resultclass.message = "";

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }
        /*
        private string DateTimeSQLite(DateTime datetime)
        {
            string dateTimeFormat = "{0}-{1}-{2} {3}:{4}:{5}.{6}";
            return string.Format(dateTimeFormat, datetime.Year, datetime.Month, datetime.Day, datetime.Hour, datetime.Minute, datetime.Second, datetime.Millisecond);
        }
        */
    }



    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class standardResponse
    {
        public string status;
        public string message;
        public string @ctr = null;
    }

    #endregion
    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}
