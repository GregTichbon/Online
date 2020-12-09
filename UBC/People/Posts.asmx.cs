using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Xml;
using OfficeOpenXml;
using System.IO;
using Generic;
using System.Net;

namespace UBC.People
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
        public string updatefield(string table, string field, string id, string value, string keyfield)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();


            string command = "";
            switch (table)
            {
                case "ergregister":
                    command = "update_table_field";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@table", SqlDbType.VarChar).Value = table;
                    cmd.Parameters.Add("@field", SqlDbType.VarChar).Value = field;
                    cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id.Substring(4);
                    cmd.Parameters.Add("@value", SqlDbType.VarChar).Value = value;
                    cmd.Parameters.Add("@keyfield", SqlDbType.VarChar).Value = keyfield;
                    break;

                default:

                    value = value.Replace("'", "''");
                    command = "update [" + table + "] set [" + field + "] = '" + value + "' where [" + keyfield + "] = '" + id + "'";
                    cmd.CommandType = CommandType.Text;
                    break;


            }
            cmd.CommandText = command;
            cmd.Connection = con;
            con.Open();
            //SqlDataReader dr = cmd.ExecuteReader();
            cmd.ExecuteNonQuery();

            cmd.Dispose();
            con.Close();
            con.Dispose();

            return ("Ok");
        }

        [WebMethod]
        public string create_recurring_events(string event_id, string period, string frequency, string upto)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "create_recurring_events";
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd.Parameters.Add("@period", SqlDbType.VarChar).Value = period;
            cmd.Parameters.Add("@frequency", SqlDbType.VarChar).Value = frequency;
            cmd.Parameters.Add("@upto", SqlDbType.VarChar).Value = upto;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string returned = dr["count"].ToString();
            con.Close();

            con.Dispose();
            return (returned);
        }

        [WebMethod]
        public string send_sms(NameValue[] formVars)    //you can't pass any querystring params
        {
            string SMSLog_ID = formVars.Form("SMSLog_ID");
            string PhoneNumber = formVars.Form("PhoneNumber");
            string Message = formVars.Form("Message");
            string ID = formVars.Form("ID");
            string Description = formVars.Form("Description");

            Generic.Functions gFunctions = new Generic.Functions();
            string result = "";
            foreach (string mobilex in PhoneNumber.Split(';'))
            {
                result += gFunctions.SendRemoteMessage(mobilex, Message, Description, SMSLog_ID) + "<br />";
            }

            /*
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Sent";
            resultclass.message = result;
            //resultclass.id = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
            */
            return (result);
        }

        [WebMethod]
        public string send_text(string PhoneNumber, string Message)
        {
            Generic.Functions gFunctions = new Generic.Functions();
            string response = gFunctions.SendRemoteMessage(PhoneNumber, Message, "UBC Communications");
            return response;
        }

        [WebMethod]
        public standardResponseID test_text(NameValue[] formVars)    //you can't pass any querystring params
        {
            string response = "";
            Generic.Functions gFunctions = new Generic.Functions();
            response = gFunctions.SendRemoteMessage(formVars.Form("mobile"), "Test text", "UBC Communications");

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = response;
            resultclass.message = "";
            resultclass.id = "0";

            return (resultclass);

        }

        [WebMethod]
        public standardResponseID send_email_text(NameValue[] formVars)    //you can't pass any querystring params
        {
            //"name": "type", "value": type }, { "name": "id", "value": id }, { "name": "emailsubject", "value": emailsubject}, { "name": "emailhtml", "value": emailhtml }, { "name": "text", "value": text }, { "name": "recipient", "value": text }];

            string type = formVars.Form("type"); //email or text  or   remail or rtext
            string id = formVars.Form("id");
            string emailsubject = formVars.Form("emailsubject");
            string emailhtml = formVars.Form("emailhtml");
            string text = formVars.Form("text");
            string recipient = formVars.Form("recipient");  //phone number or email address
            string attendance = formVars.Form("attendance");
            string mode = formVars.Form("mode");

            string rid = "";
            string rfirstname = "";
            string rperson_guid = "";
            string rusername = "";
            string rtempphrase = "";

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            con.Open();
            SqlDataReader dr;

            cmd.CommandText = "Get_person";

            if (type.StartsWith("r"))
            {
                string[] recipientparts = recipient.Split('|');
                rid = recipientparts[0];
                //rfirstname = recipientparts[1];
                recipient = recipientparts[2];
                type = type.Substring(1);

                cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = rid;
                dr = cmd.ExecuteReader();
                dr.Read();

                rfirstname = dr["firstname"].ToString();
                rperson_guid = dr["guid"].ToString();
                rusername = dr["username"].ToString();
                rtempphrase = dr["tempphrase"].ToString();
                dr.Close();
            }


            cmd.Parameters.Clear();
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = id;


            //string result = cmd.ExecuteScalar().ToString();
            dr = cmd.ExecuteReader();
            dr.Read();

            string firstname = dr["firstname"].ToString();
            string person_guid = dr["guid"].ToString();
            string username = dr["username"].ToString();
            string tempphrase = dr["tempphrase"].ToString();

            dr.Close();
            con.Close();
            con.Dispose();

            string response = "";
            Generic.Functions gFunctions = new Generic.Functions();

            if (type == "email")
            {
                //string host = "datainn.co.nz";
                //string host = "70.35.207.87";
                //string emailfrom = "UnionBoatClub@datainn.co.nz";
                //string password = "39%3Zxon";

                string host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
                string emailfrom = "info@unionboatclub.co.nz";
                string password = "R0wtheboat";
                int port = 587; // 465; // 25;
                Boolean enableSsl = true;

                string emailfromname = "Union Boat Club";
                string emailBCC = emailfrom;

                //emailhtml = emailhtml.Replace("||link||", "<a href=\"" + link + "\">here</a>");
                emailhtml = emailhtml.Replace("||firstname||", firstname);
                emailhtml = emailhtml.Replace("||guid||", person_guid);
                emailhtml = emailhtml.Replace("||accesscode||", person_guid.Substring(0, 5));
                emailhtml = emailhtml.Replace("||username||", username);
                emailhtml = emailhtml.Replace("||tempphrase||", tempphrase);
                emailhtml = emailhtml.Replace("||attendance||", attendance);
                //emailhtml = emailhtml.Replace("||role||", role);
                emailhtml = emailhtml.Replace("||folder||", "Folder" + id);
                emailhtml = emailhtml.Replace("||redirect||", "http://ubc.org.nz/Folder" + id + "/redirect.aspx?url=");
                //emailhtml = emailhtml.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                emailhtml = emailhtml.Replace("||rfirstname||", rfirstname);
                emailhtml = emailhtml.Replace("||rguid||", rperson_guid);
                emailhtml = emailhtml.Replace("||raccesscode||", (rperson_guid + "     ").Substring(0, 5));
                emailhtml = emailhtml.Replace("||rusername||", rusername);
                emailhtml = emailhtml.Replace("||rtempphrase||", rtempphrase);

                string emailtemplate = Server.MapPath("..") + "\\EmailTemplate\\full.html";
                string emaildocument = "";

                using (StreamReader sr = new StreamReader(emailtemplate))
                {
                    emaildocument = sr.ReadToEnd();
                }

                emaildocument = emaildocument.Replace("||Content||", emailhtml);
                string[] attachments = new string[0];
                Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                //emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";
                //gFunctions.sendemailV3(host, emailfrom, emailfromname, password, emailsubject, emaildocument, recipient, emailBCC, "");
                if (mode == "test")
                {
                    response = "test mode";
                }
                else
                {
                    gFunctions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailsubject, emaildocument, recipient, emailBCC, "", attachments, emailoptions);
                    response = "Ok";
                }
 
            }

            if (type == "text")
            {
                //text = text.Replace("||link||", link);
                text = text.Replace("||firstname||", firstname);
                text = text.Replace("||guid||", person_guid);
                text = text.Replace("||accesscode||", person_guid.Substring(0, 5));
                text = text.Replace("||username||", username);
                text = text.Replace("||tempphrase||", tempphrase);
                text = text.Replace("||attendance||", attendance);
                //text = text.Replace("||role||", role);
                text = text.Replace("||folder||", "Folder" + id);
                text = text.Replace("||redirect||", "http://ubc.org.nz/Folder" + id + "/redirect.aspx?url=");
                //text = text.Replace("||personevent||", "p=" + person_guid + "&e=" + event_guid);

                text = text.Replace("||rfirstname||", rfirstname);
                text = text.Replace("||rguid||", rperson_guid);
                text = text.Replace("||raccesscode||", (rperson_guid + "     ").Substring(0, 5));
                text = text.Replace("||rusername||", rusername);
                text = text.Replace("||rtempphrase||", rtempphrase);

                foreach (string mobile in recipient.Split(';'))
                {
                    if (mode == "test")
                    {
                        response = "test mode";
                    }
                    else { 
                        response = gFunctions.SendRemoteMessage(mobile, text, "UBC Communications") + "<br />";
                    }
                }
            }

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = response;
            resultclass.message = "";
            resultclass.id = id;

            return (resultclass);

        }

        [WebMethod]
        public standardResponseID send_signup_email_text(NameValue[] formVars)    //you can't pass any querystring params
        {
            //{ "name": "type", "value": type }, { "name": "id", "value": id }, { "name": "emailsubject", "value": emailsubject}, { "name": "emailhtml", "value": emailhtml }, { "name": "text", "value": text }, { "name": "recipient", "value": text }];

            string type = formVars.Form("type");
            string id = formVars.Form("id");
            string emailsubject = formVars.Form("emailsubject");
            string emailhtml = formVars.Form("emailhtml");
            string text = formVars.Form("text");
            string recipient = formVars.Form("recipient");


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Get_signup";
            cmd.Parameters.Add("@signup_ctr", SqlDbType.VarChar).Value = id;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string firstname = dr["firstname"].ToString();
            string guid = dr["guid"].ToString();
            con.Close();

            con.Dispose();

            string response = "";
            Generic.Functions gFunctions = new Generic.Functions();

            if (type == "email")
            {
                string emailbodyTemplate = "RegisterEmail.xslt";
                string screenTemplate = "RegisterScreen.xslt";
                //string host = "datainn.co.nz";
                //string host = "70.35.207.87";
                //string password = "39%3Zxon";

                string host = "cp-wc03.per01.ds.network"; //"mail.unionboatclub.co.nz";
                string emailfrom = "info@unionboatclub.co.nz";
                string password = "R0wtheboat";
                int port = 587; // 465; // 25;
                Boolean enableSsl = true;

                string emailfromname = "Union Boat Club";
                string emailBCC = emailfrom;


                emailhtml = emailhtml.Replace("||firstname||", firstname);
                emailhtml = emailhtml.Replace("||guid||", guid);

                string emailtemplate = Server.MapPath("..") + "\\EmailTemplate\\full.html";
                string emaildocument = "";

                using (StreamReader sr = new StreamReader(emailtemplate))
                {
                    emaildocument = sr.ReadToEnd();
                }

                emaildocument = emaildocument.Replace("||Content||", emailhtml);


                //emailhtml = "<html><head></head><body>" + emailhtml + "</body></html>";
                string[] attachments = new string[0];
                Dictionary<string, string> emailoptions = new Dictionary<string, string>();
                gFunctions.sendemailV5(host, port, enableSsl, emailfrom, emailfromname, password, emailsubject, emaildocument, recipient, emailBCC, "", attachments, emailoptions);
                //gFunctions.sendemailV3(host, emailfrom, emailfromname, password, emailsubject, emaildocument, recipient, emailBCC, "");
                response = "Ok";
            }

            if (type == "text")
            {
                text = text.Replace("||firstname||", firstname);
                text = text.Replace("||guid||", guid);
                foreach (string mobile in recipient.Split(';'))
                {
                    response = gFunctions.SendRemoteMessage(mobile, text, "UBC Signup Communicate") + "<br />";
                }
            }

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = response;
            resultclass.message = "";
            resultclass.id = id;

            return (resultclass);

        }

        [WebMethod]
        public standardResponseID update_othertransaction(NameValue[] formVars)    //you can't pass any querystring params
        {
            string othertransaction_id = formVars.Form("othertransaction_id");
            string person_id = formVars.Form("person_id");
            string date = formVars.Form("date");  //Only use for NON-Bank transactions
            string system = formVars.Form("system");
            string code = formVars.Form("code");
            string event_id = formVars.Form("event_id");
            string amount = formVars.Form("amount");
            string note = formVars.Form("note");
            //string banked = formVars.Form("banked");
            string banktransaction_id = formVars.Form("banktransaction_id");

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_OtherTransaction";
            cmd.Parameters.Add("@othertransaction_id", SqlDbType.VarChar).Value = othertransaction_id.Substring(17);
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = date;  //Only use for NON-Bank transactions
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = amount;
            cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = note;
            cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = system;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@code", SqlDbType.VarChar).Value = code;
            //cmd.Parameters.Add("@banked", SqlDbType.VarChar).Value = banked;
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd.Parameters.Add("@banktransaction_id", SqlDbType.VarChar).Value = banktransaction_id;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string id = dr[0].ToString();
            con.Close();

            con.Dispose();

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = id;
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);

            return (resultclass);

        }

        [WebMethod]
        public standardResponseID Update_person_ergTime(NameValue[] formVars)    //you can't pass any querystring params
        {
            // var arForm = [{ "name": "UBC_person_id", "value": UBC_person_id }, { "name": "UBC_name", "value": UBC_name }, { "name": "seconds", "value": seconds }];

            string UBC_person_id = formVars.Form("UBC_person_id");
            string UBC_name = formVars.Form("UBC_name");
            decimal seconds = Convert.ToDecimal(formVars.Form("seconds"));

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_person_ergTime";
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = UBC_person_id;
            SqlParameter parameter = new SqlParameter("@totaltime", SqlDbType.Decimal);
            parameter.Value = seconds;
            parameter.Precision = 6;
            parameter.Scale = 2;
            cmd.Parameters.Add(parameter);

            //cmd.Parameters.Add("@totaltime", SqlDbType.Decimal(2,0)).Value = seconds;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string id = dr[0].ToString();
            con.Close();

            con.Dispose();

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = id;
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            return (resultclass);

        }

        [WebMethod]
        public standardResponseID update_person_transaction(NameValue[] formVars)    //you can't pass any querystring params
        {
            string person_transaction_id = formVars.Form("person_transaction_id");
            string person_id = formVars.Form("person_id");
            string date = formVars.Form("date");
            string system = formVars.Form("system");
            string code = formVars.Form("code");
            string event_id = formVars.Form("event_id");
            string amount = formVars.Form("amount");
            string note = formVars.Form("note");
            string banked = formVars.Form("banked");
            string banktransaction_id = formVars.Form("banktransaction_id");

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            person_transaction_id = person_transaction_id.Substring(19);
            cmd.CommandText = "Update_Person_Transaction";
            cmd.Parameters.Add("@person_transaction_id", SqlDbType.VarChar).Value = person_transaction_id;
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
            cmd.Parameters.Add("@date", SqlDbType.VarChar).Value = date;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = amount;
            cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = note;
            cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = system;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@code", SqlDbType.VarChar).Value = code;
            //cmd.Parameters.Add("@banked", SqlDbType.VarChar).Value = banked;
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd.Parameters.Add("@banktransaction_id", SqlDbType.VarChar).Value = banktransaction_id;

            con.Open();
            //string result = cmd.ExecuteScalar().ToString();
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();

            string id = dr[0].ToString();
            con.Close();

            con.Dispose();

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = "Saved";
            resultclass.message = "";
            resultclass.id = id;
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            return (resultclass);

        }

        [WebMethod]
        public standardResponseID updateattendance(NameValue[] formVars)    //you can't pass any querystring params
        {
            //see also posts.asmx/update_event_person
            //var arForm = [{ "name": "event_id", "value": event_id }, { "name": "person_id", "value": <%=person_id%> }, { "name": "attendance", "value": $('#attendance').val() }, { "name": "personnote", "value": $('#personnote').val() }];

            string event_id = formVars.Form("event_id");
            string person_id = formVars.Form("person_id");
            string person_guid = formVars.Form("person_guid");
            string attendance = formVars.Form("attendance");
            string personnote = formVars.Form("personnote");


            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;


            cmd.CommandText = "update_person_event_attendance";
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = event_id;
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
            cmd.Parameters.Add("@person_guid", SqlDbType.VarChar).Value = person_guid;
            cmd.Parameters.Add("@attendance", SqlDbType.VarChar).Value = attendance;
            cmd.Parameters.Add("@personnote", SqlDbType.VarChar).Value = personnote;
            cmd.Parameters.Add("@personresponded", SqlDbType.VarChar).Value = DateTime.Now.ToString("dd-MMMM-yyyy HH:mm:ss");

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();
            con.Dispose();

            standardResponseID resultclass = new standardResponseID();
            resultclass.status = result;
            resultclass.message = "";
            resultclass.id = "";
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            return (resultclass);

        }

        [WebMethod]
        public string delete_person_transaction(NameValue[] formVars)    //you can't pass any querystring params
        {
            string person_transaction_id = formVars.Form("person_transaction_id");

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Delete_Person_Transaction";
            cmd.Parameters.Add("@person_transaction_id", SqlDbType.VarChar).Value = person_transaction_id.Substring(13);

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Deleted";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }

        [WebMethod]
        public string delete_othertransaction(NameValue[] formVars)    //you can't pass any querystring params
        {
            string othertransaction_id = formVars.Form("othertransaction_id");

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Delete_OtherTransaction";
            cmd.Parameters.Add("@othertransaction_id", SqlDbType.VarChar).Value = othertransaction_id.Substring(17);

            con.Open();
            string result = cmd.ExecuteScalar().ToString();
            con.Close();

            con.Dispose();

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Deleted";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);

        }

        [WebMethod]
        public string update_event_person(NameValue[] formVars)    //you can't pass any querystring params
        {
            //see also posts.asmx/updateattendance


            /*PROCEDURE [dbo].[update_event_person] (
            @event_id int,
            @person_id int,
            @attendance varchar(10),
            @note nvarchar(max) = null,
            @role varchar(20) = null
            )*/
            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            con.Open();
            SqlCommand cmd = new SqlCommand("update_event_person", con);
            cmd.CommandType = CommandType.StoredProcedure;


            cmd.Parameters.Clear();
            cmd.Parameters.Add("@person_id", SqlDbType.VarChar).Value = formVars.Form("person_id");
            cmd.Parameters.Add("@event_id", SqlDbType.VarChar).Value = formVars.Form("event_id");
            cmd.Parameters.Add("@attendance", SqlDbType.VarChar).Value = formVars.Form("attendance");
            //cmd.Parameters.Add("@note", SqlDbType.VarChar).Value = formVars.Form("note");
            //cmd.Parameters.Add("@role", SqlDbType.VarChar).Value = formVars.Form("role");
            cmd.Parameters.Add("@personnote", SqlDbType.VarChar).Value = formVars.Form("personnote");
            //cmd.Parameters.Add("@privatenote", SqlDbType.VarChar).Value = formVars.Form("privatenote");

            cmd.Connection = con;
            try
            {
                cmd.ExecuteScalar();
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

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }

        [WebMethod]
        public string TabletoExcelCSV(string table)    //you can't pass any querystring params
        {
            /*
              Microsoft.Office.Interop.Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();
              if (xlApp == null)
              {
                  string error = ("Excel is not properly installed!!");
              }
              Microsoft.Office.Interop.Excel.Workbook xlWorkBook = xlApp.Workbooks.Add(Type.Missing);
              Microsoft.Office.Interop.Excel.Worksheet xlWorkSheet = (Microsoft.Office.Interop.Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);
              xlWorkSheet.Name = "RowingExport";


              int r1 = 0;
              int c1 = 0;
              XmlDocument doc = new XmlDocument();
              doc.LoadXml(table);

              foreach (XmlNode trnode in doc.DocumentElement.ChildNodes) //TR
              {
                  r1++;
                  c1 = 0;
                  foreach (XmlNode tdnode in trnode.ChildNodes)  //TD
                  {
                      c1++;
                      string text = tdnode.InnerText;
                      if (tdnode.Name == "th")
                      {
                          string x = tdnode.Name;
                          xlWorkSheet.Cells[r1, c1].Font.Bold = true;
                      }
                      xlWorkSheet.Cells[r1, c1] = text;

                      //string attr = tdnode.Attributes["colspan"]?.InnerText;
                  }
              }

              //xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(2);
              //xlWorkSheet.Cells[1, 1] = "Sheet 2 content";

              xlWorkBook.SaveAs("exceltest1.xlsx");
              xlWorkBook.Close();
              xlApp.Quit();
          */
            table = table.Replace("&", "&amp;");
            Functions functions = new Functions();
            string filename = functions.getReference() + ".xlsx";
            string fullfilename = Server.MapPath(".") + "\\downloads\\" + filename;
            using (var p = new ExcelPackage())
            {
                //A workbook must have at least one cell, so lets add one... 
                var ws = p.Workbook.Worksheets.Add("Rowing");


                int r1 = 0;
                int c1 = 0;

                XmlDocument doc = new XmlDocument();
                doc.LoadXml(table);

                foreach (XmlNode trnode in doc.DocumentElement.ChildNodes) //TR
                {
                    r1++;
                    c1 = 0;
                    foreach (XmlNode tdnode in trnode.ChildNodes)  //TD
                    {
                        c1++;
                        string text = tdnode.InnerText;
                        if (tdnode.Name == "th")
                        {
                            //string x = tdnode.Name;
                            //ws.Cells[r1, c1].Font.Bold = true;
                        }
                        ws.Cells[r1, c1].Value = text;

                        //string attr = tdnode.Attributes["colspan"]?.InnerText;
                    }
                }
                p.SaveAs(new FileInfo(fullfilename));

            }

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Complete";
            resultclass.message = filename;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public standardResponse SaveImage(string imageData, string id)    //you can't pass any querystring params
        {
            //string dt = DateTime.Now.ToString("ddMMyyHHss");
            if (1 == 1)
            {
                string path = Server.MapPath(".\\images");

                //string path = @"F:\InetPub\Online\Assets\Cemetery\Images\" + id;
                Directory.CreateDirectory(path + "\\original");
                //string fileName = "\\" + id + "_" + dt + ".jpg";
                string fileName = "\\" + id + ".jpg";
                using (FileStream fs = new FileStream(path + "\\original" + fileName, FileMode.Create))
                {
                    using (BinaryWriter bw = new BinaryWriter(fs))
                    {
                        byte[] data = Convert.FromBase64String(imageData);
                        bw.Write(data);
                        bw.Close();
                    }
                }

                using (System.Drawing.Image original = System.Drawing.Image.FromFile(path + "\\original" + fileName))
                {
                    double scaler = Convert.ToDouble(original.Width / 640.000000);
                    int newHeight = Convert.ToInt16(original.Height / scaler);
                    int newWidth = 640;



                    using (System.Drawing.Bitmap newPic = new System.Drawing.Bitmap(newWidth, newHeight))
                    {
                        using (System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(newPic))
                        {
                            gr.DrawImage(original, 0, 0, (newWidth), (newHeight));
                            newPic.Save(path + fileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                        }
                    }
                }


            }
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            return (resultclass);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public standardResponse SaveSignupImage(string imageData, string id)    //you can't pass any querystring params
        {
            //string dt = DateTime.Now.ToString("ddMMyyHHss");
            if (1 == 1)
            {
                string path = Server.MapPath(".\\images\\signup");

                //string path = @"F:\InetPub\Online\Assets\Cemetery\Images\" + id;
                Directory.CreateDirectory(path + "\\original");
                //string fileName = "\\" + id + "_" + dt + ".jpg";
                string fileName = "\\" + id + ".jpg";
                using (FileStream fs = new FileStream(path + "\\original" + fileName, FileMode.Create))
                {
                    using (BinaryWriter bw = new BinaryWriter(fs))
                    {
                        byte[] data = Convert.FromBase64String(imageData);
                        bw.Write(data);
                        bw.Close();
                    }
                }

                using (System.Drawing.Image original = System.Drawing.Image.FromFile(path + "\\original" + fileName))
                {
                    double scaler = Convert.ToDouble(original.Width / 640.000000);
                    int newHeight = Convert.ToInt16(original.Height / scaler);
                    int newWidth = 640;



                    using (System.Drawing.Bitmap newPic = new System.Drawing.Bitmap(newWidth, newHeight))
                    {
                        using (System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(newPic))
                        {
                            gr.DrawImage(original, 0, 0, (newWidth), (newHeight));
                            newPic.Save(path + fileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                        }
                    }
                }


            }
            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "";
            return (resultclass);
        }

    }
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
}
public class standardResponseID
{
    public string status;
    public string message;
    public string id;
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
