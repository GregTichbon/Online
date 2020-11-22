using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

using System.Net.Mail;
using System.IO;
using System.Xml;

using System.Web.UI;

using System.Net;
using System.Text;

using Online.Models;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Specialized;
using System.Xml.Linq;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using Newtonsoft.Json.Linq;

namespace Online.WDCFunctions
{
    public class WDCFunctions
    {


        public bool IsReCaptchValid(string g_recaptcha_response)
        {
            var result = false;
            var captchaResponse = g_recaptcha_response;
            var secretKey = "6Lfate4SAAAAAKu-VJ5j5HaCMyfnNaN3myLzhTJz";
            var apiUrl = "https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}";
            var requestUri = string.Format(apiUrl, secretKey, captchaResponse);
            var request = (HttpWebRequest)WebRequest.Create(requestUri);

            using (WebResponse response = request.GetResponse())
            {
                using (StreamReader stream = new StreamReader(response.GetResponseStream()))
                {
                    JObject jResponse = JObject.Parse(stream.ReadToEnd());
                    var isSuccess = jResponse.Value<bool>("success");
                    result = (isSuccess) ? true : false;
                }
            }
            return result;
        }

        public string build_response_html(DataView response_group)
        {
            string html = "";
            int response_group_Count = response_group.Count;
            if (response_group_Count == 1)
            {
                DataRowView row = response_group[0];
                string response_group_CTR = row["response_group_CTR"].ToString();
                string response_item_CTR = row["response_item_CTR"].ToString();
                string header = row["header"].ToString();
                string help = row["help"].ToString();
                string id = "_response_" + response_group_CTR + "_" + response_item_CTR;

                html += "<table class=\"table\">";
                html += "<tr><td style=\"width:90%\">" + header + " <input id=\"hf" + id + "\" name=\"hf" + id + "\" type=\"hidden\" required /></td>";
                for (int f1 = 0; f1 < 11; f1++)
                {
                    html += "<td class=\"score\" id=\"td" + id + "\">" + f1 + "</td>";
                }
                html += "<td><img src=\"../Images/questionsmall.png\" title=\"" + help + "\" /></td>";
                html += "</tr>";
                html += "</table>";
            }
            else
            {
                Boolean heading_done = false;
                foreach (DataRowView row in response_group)
                {
                    if (!heading_done)
                    {
                        string heading = row["heading"].ToString();
                        string help = row["help"].ToString();

                        html += "<table class=\"table\">";
                        html += "<tr><td style=\"width:100%\">" + heading + "</td><td><img src=\"../Images/questionsmall.png\" title=\"" + help + "\" /></td></tr>";
                        html += "</table>";
                        html += "<table class=\"table\">";
                        heading_done = true;
                    }
                    string response_group_CTR = row["response_group_CTR"].ToString();
                    string response_item_CTR = row["response_item_CTR"].ToString();
                    string header = row["header"].ToString();
                    string id = "_response_" + response_group_CTR + "_" + response_item_CTR;

                    html += "<tr><td style=\"width:90%\">" + header + " <input id=\"hf" + id + "\" name=\"hf" + id + "\" type=\"hidden\" required /></td>";
                    for (int f1 = 0; f1 < 11; f1++)
                    {
                        html += "<td class=\"score\" id=\"td" + id + "\">" + f1 + "</td>";
                    }
                    html += "</tr>";
                }
                html += "</table>";
            }
            return html;
        }

        public void entityfields(int Entity_CTR, Dictionary<string, string> documentvalues)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "get_entity";
            cmd.Parameters.Add("@entity_ctr", SqlDbType.Int).Value = Entity_CTR;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    documentvalues["Entity_Reference"] = dr["reference"].ToString();
                    documentvalues["Entity_LastName"] = dr["LastName"].ToString();
                    documentvalues["Entity_FirstName"] = dr["FirstName"].ToString();
                    documentvalues["Entity_othernames"] = dr["othernames"].ToString();
                    documentvalues["Entity_KnownAs"] = dr["KnownAs"].ToString();
                    documentvalues["Entity_EmailAddress"] = dr["EmailAddress"].ToString();
                    documentvalues["Entity_ResidentialAddress"] = dr["ResidentialAddress"].ToString();
                    documentvalues["Entity_PostalAddress"] = dr["PostalAddress"].ToString();
                    documentvalues["Entity_MobilePhone"] = dr["MobilePhone"].ToString();
                    documentvalues["Entity_HomePhone"] = dr["HomePhone"].ToString();
                    documentvalues["Entity_WorkPhone"] = dr["WorkPhone"].ToString();
                    documentvalues["Entity_Gender"] = dr["Gender"].ToString();
                    documentvalues["Entity_dateofbirth"] = dr["dateofbirth"].ToString();
                }
            }
            catch (Exception ex)
            {
                Log("WDCFunctions entityfields", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        public IHtmlString HTMLRaw(string source)
        {
            return new HtmlString(source);
        }

        public string generatecode(string tablename, Dictionary<string, string> fieldsdict)
        {
            return "";
        }

        public string documentfill(string passdocument, Dictionary<string, string> documentvalues)
        {
            string filleddocument = "";
            //string a = documentvalues["test"];
            int c2 = 0;
            string fieldname = "";
            string comparison = "";
            string criteria = "";
            passdocument = passdocument + "  ";
            char[] tilda = { '~' };
            string document = "";

            /*
            SECTIONS
            @@dictionaryname~comparison~value~TRUE:text to use.  Can include ||dictionaryname||~FALSE:text to use.  Can include ||dictionaryname||@@
             */
            string[] sections = passdocument.Split(new[] { "@@" }, StringSplitOptions.RemoveEmptyEntries);
            for (int c1 = 0; c1 < sections.Length; c1++)
            {
                if (sections[c1].Contains("~"))
                {
                    string[] parts = sections[c1].Split(tilda);
                    fieldname = parts[0];
                    comparison = parts[1];    // =  !=   >   <   >=    <= 
                    criteria = parts[2];

                    switch (comparison)
                    {
                        case "=":
                            if (documentvalues[fieldname] == criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        case "!=":
                            if (documentvalues[fieldname] != criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        default:
                            document = document + "Invalid comparison -" + comparison;
                            break;
                    }
                }
                else
                {
                    document = document + sections[c1];
                }
            }

            for (int c1 = 0; c1 < document.Length - 2; c1++)
            {
                char ch = document[c1];
                if (document.Substring(c1, 2) == "||")
                {
                    c2 = 2;
                    while (document.Substring(c1 + c2, 2) != "||")
                    {
                        c2 = c2 + 1;
                    }
                    fieldname = document.Substring(c1 + 2, c2 - 2);
                    try
                    {
                        filleddocument = filleddocument + documentvalues[fieldname];
                    }
                    catch
                    {
                        Log("documentfill", "Invalid field name: " + fieldname, "greg.tichbon@whanganui.govt.nz");
                    }
                    c1 = c1 + c2 + 1;
                }
                else
                {
                    filleddocument = filleddocument + document.Substring(c1, 1);
                }
            }

            return filleddocument;
        }

        public string documentfillwithRF(string passdocument, Dictionary<string, string> documentvalues, NameValueCollection form)
        {
            string filleddocument = "";
            //string a = documentvalues["test"];
            int c2 = 0;
            string fieldname = "";
            string value = "";
            string comparison = "";
            string criteria = "";
            passdocument = passdocument + "  ";
            char[] tilda = { '~' };
            string document = "";

            /*
            SECTIONS
            @@dictionaryname~comparison~value~TRUE:text to use.  Can include ||dictionaryname||~FALSE:text to use.  Can include ||dictionaryname||@@
             */
            string[] sections = passdocument.Split(new[] { "@@C" }, StringSplitOptions.RemoveEmptyEntries);
            for (int c1 = 0; c1 < sections.Length; c1++)
            {
                if (sections[c1].Contains("~"))
                {
                    string[] parts = sections[c1].Split(tilda);
                    fieldname = parts[0];
                    comparison = parts[1];    // =  !=   >   <   >=    <= 
                    criteria = parts[2];

                    switch (comparison)
                    {
                        case "=":
                            if (documentvalues[fieldname] == criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        case "!=":
                            if (documentvalues[fieldname] != criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        default:
                            document = document + "Invalid comparison -" + comparison;
                            break;
                    }
                }
                else
                {
                    document = document + sections[c1];
                }
            }

            for (int c1 = 0; c1 < document.Length - 2; c1++)
            {
                char ch = document[c1];
                if (document.Substring(c1, 2) == "||")
                {
                    c2 = 2;
                    while (document.Substring(c1 + c2, 2) != "||")
                    {
                        c2 = c2 + 1;
                    }
                    fieldname = document.Substring(c1 + 2, c2 - 2);

                    string[] parms = fieldname.Split('|');

                    switch (parms[0].ToLower())
                    {
                        case "rf":
                            value = form[parms[1]];
                            break;
                        case "sd":
                            value = documentvalues[parms[1]];
                            break;
                        default:
                            value = "Unknown Paramater 1 - " + fieldname;
                            break;
                    }
                    try
                    {
                        filleddocument = filleddocument + value;
                    }
                    catch
                    {
                        Log("documentfill", "Invalid field name: " + fieldname, "greg.tichbon@whanganui.govt.nz");
                    }
                    c1 = c1 + c2 + 1;
                }
                else
                {
                    filleddocument = filleddocument + document.Substring(c1, 1);
                }
            }

            return filleddocument;
        }

        public string documentfillwithRFandFiles(string passdocument, Dictionary<string, string> documentvalues, NameValueCollection form, List<FileClass> FileList, string repeatername, DataTable repeatertable, string repeaterindex)
        {
            string filleddocument = "";
            int c2 = 0;
            string fieldname = "";
            string value = "";
            string comparison = "";
            string criteria = "";
            passdocument = passdocument + "  ";
            char[] tilda = { '~' };
            string document = "";

            /*
           SECTIONS
           @@Cdictionaryname~comparison~value~TRUE:text to use.  Can include ||dictionaryname||~FALSE:text to use.  Can include ||dictionaryname||@@C
            */
            string[] sections = passdocument.Split(new[] { "@@S" }, StringSplitOptions.RemoveEmptyEntries);
            for (int c1 = 0; c1 < sections.Length; c1++)
            {
                if (sections[c1].Substring(0, 3) == "@@C" && sections[c1].Contains("~"))
                {
                    string[] parts = sections[c1].Split(tilda);
                    fieldname = parts[0].Substring(3);
                    comparison = parts[1];    // =  !=   >   <   >=    <= 
                    criteria = parts[2];

                    switch (comparison)
                    {
                        case "=":
                            if (documentvalues[fieldname] == criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        case "!=":
                            if (documentvalues[fieldname] != criteria)
                            {
                                document = document + parts[3];
                            }
                            break;
                        default:
                            document = document + "Invalid comparison -" + comparison;
                            break;
                    }
                }
                else
                {
                    document = document + sections[c1];
                }
            }

            for (int c1 = 0; c1 < document.Length - 2; c1++)
            {
                char ch = document[c1];
                if (document.Substring(c1, 2) == "||")
                {
                    c2 = 2;
                    while (document.Substring(c1 + c2, 2) != "||")
                    {
                        c2 = c2 + 1;
                    }
                    fieldname = document.Substring(c1 + 2, c2 - 2);

                    string[] parms = fieldname.Split('|');

                    if (repeatername != "")
                    {
                        parms[1] = "repeat_" + repeatername + "_" + parms[1] + "_" + repeaterindex;
                    }

                    switch (parms[0].ToLower())
                    {
                        case "rf":
                            value = form[parms[1]];
                            break;
                        case "sd":
                            value = documentvalues[parms[1]];
                            break;
                        case "fu":
                            string delim = "";
                            value = "";
                            foreach (FileClass File in FileList)
                            {
                                if (File.fieldname == parms[1])
                                {
                                    value += delim + "<a href=\"" + File.url + "\" Target=\"_Blank\">" + File.name + "</a>";
                                    delim = "<br />";
                                }
                            }
                            break;
                        default:
                            value = "Unknown Paramater 1 - " + fieldname;
                            Log("documentfill", value, "greg.tichbon@whanganui.govt.nz");
                            break;
                    }
                    try
                    {
                        filleddocument = filleddocument + value;
                    }
                    catch
                    {
                        Log("documentfill", "Invalid field name: " + fieldname, "greg.tichbon@whanganui.govt.nz");
                    }
                    c1 = c1 + c2 + 1;
                }
                else if (repeatername == "" && document.Substring(c1, 3) == "@@R")
                {
                    string repeaterdocument = "";

                    c2 = 2;
                    while (document.Substring(c1 + c2, 2) != "@@")
                    {
                        c2 += 1;
                    }
                    repeatername = document.Substring(c1 + 3, c2 - 3);

                    c1 = c1 + c2 + 2;
                    while (document.Substring(c1, 3) != "@@R")
                    {
                        repeaterdocument += document.Substring(c1, 1);
                        c1 += 1;
                    }
                    string filledrepeaterdocument = "";

                    #region working on  
                    string sel = "[Name] = '" + repeatername + "'";
                    DataView dv3 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                    DataTable dvindexess = dv3.ToTable(true, "Index");
                    foreach (DataRow indexrow in dvindexess.Rows)
                    {
                        filledrepeaterdocument = documentfillwithRFandFiles(repeaterdocument, documentvalues, form, FileList, repeatername, repeatertable, indexrow["Index"].ToString());
                        filleddocument += filledrepeaterdocument;
                    }
                    repeatername = "";
                    #endregion

                    c1 = c1 + 2;
                }
                else
                {
                    filleddocument = filleddocument + document.Substring(c1, 1);
                }
            }

            return filleddocument;
        }

        public string test(Dictionary<string, string> documentvalues)
        {
            return "A";
        }

        public static string onlinemode()
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            if (path.ToLower().Substring(0, 8) == "/online/")
            {
                return "online";
            }
            else
            {
                return "onlinetest";
            }
        }

        public static string testaccess()
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            if (path.ToLower().Substring(0, 8) == "/online/")
            {
                return "";
            }
            else
            {
                string ignoreip = HttpContext.Current.Request.QueryString["ignoreip"];
                string ipaddress = "";

                /*
                foreach(string key in HttpContext.Current.Request.ServerVariables)
                {
                    string xx = HttpContext.Current.Request.ServerVariables[key];
                }
                */


                if (ignoreip == null)
                {
                    ipaddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                    if (ipaddress == "" || ipaddress == null)
                    {
                        ipaddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    }
                }
                if (ipaddress != "127.0.0.1" && ipaddress != "" && !(ipaddress.StartsWith("192.168.")) && HttpContext.Current.Request.ServerVariables["SERVER_NAME"] != "localhost")
                {
                    //return "alert('" + ipaddress + "');";
                    return "window.location.href = 'http://wdc.whanganui.govt.nz/testaccess.aspx';";
                }
                else
                {
                    //return "alert('" + ipaddress + "');";
                    return "$('body').css('background-color', 'red');";
                }
            }
        }

        public string PRPhoneFormat(string phonenumber)
        {
            string formatphone = "";

            if (phonenumber != "")
            {
                string extension = "";
                formatphone = phonenumber;
                formatphone = formatphone.Replace(" ", "");
                formatphone = formatphone.Replace("-", "");
                formatphone = formatphone.Replace("(", "");
                formatphone = formatphone.Replace(")", "");
                int extpos = formatphone.ToUpper().IndexOf("EXTN");
                if (extpos > 0)
                {
                    //extension = " Ext " + mid(formatphone, extpos + 4);
                    //formatphone = left(formatphone, extpos - 1);

                    extension = " Ext " + formatphone.Substring(extpos + 4);
                    formatphone = formatphone.Substring(0, extpos - 1);
                }
                extpos = formatphone.ToUpper().IndexOf("EXT");
                if (extpos > 0)
                {
                    //extension = " Ext " + mid(formatphone, extpos + 3);
                    //formatphone = left(formatphone, extpos - 1);

                    extension = " Ext " + formatphone.Substring(extpos + 3);
                    formatphone = formatphone.Substring(0, extpos - 1);
                }
                extpos = formatphone.ToUpper().IndexOf("X");
                if (extpos > 0)
                {
                    //extension = " Ext " + mid(formatphone, extpos + 1);
                    //formatphone = left(formatphone, extpos - 1);

                    extension = " Ext " + formatphone.Substring(extpos + 1);
                    formatphone = formatphone.Substring(0, extpos - 1);
                }
                int number = 0;
                if (Int32.TryParse(formatphone, out number))
                {
                    if (formatphone.Substring(0, 1) != "0")
                    {
                        formatphone = "06" + formatphone;
                    }
                    formatphone = "<a href=\"tel:" + formatphone + "\">" + formatphone + "</a>" + extension;
                }
                else
                {
                    formatphone = "Invalid format: " + formatphone;
                }
            }
            return formatphone;

        }

        public static string googleanalyticstracking(Boolean includescripttags)
        {
            string script = "";
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            if (path.ToLower().Substring(0, 8) == "/online/")
            {
                if (includescripttags)
                {
                    script += "<script>";
                }
                script += File.ReadAllText(@"F:\InetPub\whanganui\online\Scripts\GoogleAnalytics\Tracking.js", Encoding.UTF8);
                if (includescripttags)
                {
                    script += "</script>";
                }
            }
            /*else
            {
                script = path.ToLower().Substring(0, 8);
            }
            */

            return script;
        }

        public void sendemail(string emailsubject, string emailbody, string emailRecipient, string emailbcc)
        {
            //MailMessage mail = new MailMessage("noreply@whanganui.govt.nz", emailRecipient);

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("noreply@whanganui.govt.nz", "Whanganui District Council");

            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            //client.Host = "wdc-cas.local.whanganui.govt.nz";
            client.Host = "192.168.0.196"; //"192.168.0.113"; //"192.168.1.78";

            mail.IsBodyHtml = true;

            if (emailRecipient != "")
            {
                string[] emailaddresses = emailRecipient.Split(';');

                IEnumerable<string> distinctemailaddresses = emailaddresses.Distinct();

                foreach (string emailaddress in distinctemailaddresses)
                {
                    mail.To.Add(emailaddress);
                }
            }

            if (emailbcc + "" != "")
            {
                string[] bccaddresses = emailbcc.Split(';');

                IEnumerable<string> distinctbccaddresses = bccaddresses.Distinct();

                foreach (string bccaddress in distinctbccaddresses)
                {
                    mail.Bcc.Add(bccaddress);
                }
            }
            mail.Subject = emailsubject;
            mail.Body = emailbody;
            client.Send(mail);
        }

        public void sendemailwithAttachments(string emailsubject, string emailbody, string emailRecipient, string emailbcc, string test)
        {
            //MailMessage mail = new MailMessage("noreply@whanganui.govt.nz", emailRecipient);

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("noreply@whanganui.govt.nz", "Whanganui District Council");

            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            //client.Host = "wdc-cas.local.whanganui.govt.nz";
            client.Host = "192.168.0.196"; //"192.168.0.113"; //"192.168.1.78";

            mail.IsBodyHtml = true;

            if (emailRecipient != "")
            {
                string[] emailaddresses = emailRecipient.Split(';');

                IEnumerable<string> distinctemailaddresses = emailaddresses.Distinct();

                foreach (string emailaddress in distinctemailaddresses)
                {
                    mail.To.Add(emailaddress);
                }
            }

            if (emailbcc + "" != "")
            {
                string[] bccaddresses = emailbcc.Split(';');

                IEnumerable<string> distinctbccaddresses = bccaddresses.Distinct();

                foreach (string bccaddress in distinctbccaddresses)
                {
                    mail.Bcc.Add(bccaddress);
                }
            }
            mail.Subject = emailsubject;
            mail.Body = emailbody;

            var stream = new MemoryStream();
            var writer = new StreamWriter(stream);

            writer.WriteLine(test);
            writer.Flush();
            stream.Position = 0;


            mail.Attachments.Add(new Attachment(stream, "WDCAppointment.ics", "text/csv"));

            client.Send(mail);
        }

        public void Log(string location, string logMessage, string EmailAddress)
        {
            String LogFileLocation = ConfigurationManager.AppSettings["Logfile.Location"];

            StreamWriter w = File.AppendText(LogFileLocation);
            w.WriteLine("{0}", DateTime.Now.ToLongTimeString() + "\t" + DateTime.Now.ToLongDateString() + "\t" + location + "\t" + logMessage + "\t" + EmailAddress);
            w.Flush();
            w.Close();
            if (EmailAddress != "")
            {
                sendemail("Online Applications Message", location + "<br>" + logMessage, EmailAddress, "");
            }
        }

        public string getReference(string mode = "guid")
        {
            string reference = "";

            if (mode == "guid")
            {
                reference = Guid.NewGuid().ToString();
            }
            else if (mode == "datetime")
            {
                //reference = DateTime.Now.ToString("ddMMyyHHmmssff");
                reference = DateTime.Now.ToString("fffMMHHmmyyssdd");

            }


            return reference;
        }


        public string[,] getWDCAccess(string strConnString, string system, string access, string entity_ctr)
        {
            //"WDC","Entity Control", Session["online_entity_ctr"]

            string[,] SelectArray = null;

            var myAccessList = new List<AccessList>();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Access", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@system", SqlDbType.VarChar).Value = system;
            cmd.Parameters.Add("@access", SqlDbType.VarChar).Value = access;
            cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = entity_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {

                        myAccessList.Add(new AccessList()
                        {
                            system = dr["system"].ToString(),
                            access = dr["access"].ToString(),
                            response = dr["response"].ToString()
                        });
                    }
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

            SelectArray = new string[myAccessList.Count+1, 3];
            SelectArray[0, 0] = "";
            SelectArray[0, 1] = "";
            SelectArray[0, 2] = "";

            for (int i = 0; i < myAccessList.Count; i++)
            {
                SelectArray[i, 0] = ((AccessList)myAccessList[i]).system;
                SelectArray[i, 1] = ((AccessList)myAccessList[i]).access;
                SelectArray[i, 2] = ((AccessList)myAccessList[i]).response;
            }

            return SelectArray;
        }

        public string makelink(string url, string window = "")
        {
            string link = url.Trim().ToLower();
            if (link != "")
            {

                string desc = url.Trim().ToLower();


                if ((link + "       ").Substring(0, 7) == "http://")
                {
                    desc = desc.Substring(7);
                }
                else if ((link + "        ").Substring(0, 8) == "https://")
                {
                    desc = desc.Substring(8);
                }
                else
                {
                    link = "http://" + link;
                }

                string target = "";
                if (window != "")
                {
                    target = " target='" + window + "'";
                }
                link = "<a href='" + link + "'" + target + ">" + desc + "</a>";

            }
            return link;
        }

        public string saveattachments(string attpath, string reference, System.Web.UI.WebControls.FileUpload fucontrol, string url, string RawUrl)
        {
            //if attpath has had reference appended then don't  probably need to pass reference
            string uploadresult = "";

            if (fucontrol.HasFiles)
            {
                if (!Directory.Exists(attpath))
                {
                    Directory.CreateDirectory(attpath);
                }

                if (reference != "")
                {
                    reference = "_" + reference;
                }

                int c1;
                string newfilename;
                int failed = 0;
                int succeeded = 0;
                string delim = "";

                foreach (HttpPostedFile postedFile in fucontrol.PostedFiles)
                {
                    c1 = 0;
                    try
                    {
                        string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);

                        do
                        {
                            c1 = c1 + 1;
                            newfilename = wpfilename + reference + "_" + c1.ToString("000") + wpextension;
                        } while (File.Exists(attpath + "\\" + newfilename));

                        postedFile.SaveAs(attpath + "\\" + newfilename);

                        uploadresult = uploadresult + delim + System.IO.Path.GetFileName(postedFile.FileName) + "\x00FD" + "Received" + "\x00FD" + newfilename + "\x00FD" + attpath + "\x00FD" + url;
                        delim = "\x00FE";
                        succeeded = succeeded + 1;
                    }
                    catch (Exception ex)
                    {
                        Log(RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                        uploadresult = uploadresult + delim + System.IO.Path.GetFileName(postedFile.FileName) + "\x00FD" + "Failed" + "\x00FD" + "";
                        delim = "\x00FE";
                        failed = failed + 1;
                    }
                }
            }
            else
            {
                uploadresult = "File(s) not provided";
            }
            return uploadresult;
        }

        public void upload(string submissionpath, string submissionurl, HttpFileCollection files, List<FileClass> FileList)
        {
            int c1;
            string newfilename;

            for (int i = 0; i <= files.Count - 1; i++)
            {
                if (files[i].ContentLength > 0)
                {
                    if (!Directory.Exists(submissionpath))
                    {
                        Directory.CreateDirectory(submissionpath);
                    }
                    c1 = 0;
                    string fieldname = "";
                    var file = files[i];
                    if (files.AllKeys[i].Contains("$"))
                    {
                        fieldname = files.AllKeys[i].Split('$').ToString();
                    }
                    else
                    {
                        fieldname = files.AllKeys[i].ToString();
                    }
                    string fieldprefix = "";

                    string wpextension = System.IO.Path.GetExtension(file.FileName);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(file.FileName).Replace('_', '-');
                    string repeatfolder = "";

                    //if (fieldname.Substring(0, 7) == "repeat_")  this doesn't work if length of fieldname is too short
                    if (fieldname.IndexOf("repeat_") == 0)
                    {
                        string[] keyparts = fieldname.Split('_');

                        string keypartindex = keyparts[keyparts.Length - 1];
                        repeatfolder = keyparts[1] + "_" + keypartindex;

                        for (int j = 3; j <= keyparts.Length - 2; j++)
                        {
                            fieldprefix += keyparts[j] + "_";
                        }
                    }
                    else
                    {
                        string[] keyparts = fieldname.Split('_');
                        for (int j = 1; j <= keyparts.Length - 1; j++)
                        {
                            fieldprefix += keyparts[j] + "_";
                        }
                    }

                    do
                    {
                        c1 = c1 + 1;
                        newfilename = fieldprefix + wpfilename + "_" + c1.ToString("000") + wpextension;

                    } while (File.Exists(submissionpath + repeatfolder + "\\" + newfilename));

                    if (!Directory.Exists(submissionpath + repeatfolder))
                    {
                        Directory.CreateDirectory(submissionpath + repeatfolder);
                    }

                    file.SaveAs(submissionpath + repeatfolder + "\\" + newfilename);

                    FileList.Add(new FileClass()
                    {
                        fieldname = fieldname,
                        name = wpfilename + wpextension,
                        url = submissionurl + "/" + repeatfolder + "/" + newfilename
                    });
                }
            }
        }

        public gw_Result PXPost(string cardholder, string cardnumber, string amount, string expirydate, string narrative)
        {

            gw_Result gwResult = new gw_Result();

            string URI = @"https://sec.paymentexpress.com/pxpost.aspx";
            // form the PXPost Xml message
            StringWriter sw = new StringWriter();
            XmlTextWriter xtw = new XmlTextWriter(sw);
            xtw.WriteStartElement("Txn");
            xtw.WriteElementString("PostUsername", "WanganuiDCDev");   //ANZWDC
            xtw.WriteElementString("PostPassword", "test1234");        //1A5B9A93
            xtw.WriteElementString("CardHolderName", cardholder);
            xtw.WriteElementString("CardNumber", cardnumber);
            xtw.WriteElementString("Amount", amount);
            xtw.WriteElementString("DateExpiry", expirydate);
            xtw.WriteElementString("Cvc2", "");
            xtw.WriteElementString("InputCurrency", "NZD");
            xtw.WriteElementString("TxnType", "Purchase");
            xtw.WriteElementString("TxnId", "");
            xtw.WriteElementString("MerchantReference", narrative);
            //xtw.WriteElementString("TxnData1", "This is optional data, there are 3 fields");
            //xtw.WriteElementString("TxnData2", "");
            //xtw.WriteElementString("TxnData3", "");
            xtw.WriteEndElement();
            xtw.Close();
            // Send the Xml message to PXPost
            WebRequest wrq = WebRequest.Create(URI);
            wrq.Method = "POST";
            wrq.ContentType = "application/x-www-form-urlencoded";
            byte[] b = Encoding.ASCII.GetBytes(sw.ToString());
            wrq.ContentLength = b.Length;
            Stream s = wrq.GetRequestStream();
            s.Write(b, 0, b.Length);
            s.Close();
            // Check the response
            WebResponse wrs = wrq.GetResponse();

            gwResult.xmloutput = "";
            gwResult.success = 0;
            gwResult.message = "";
            gwResult.reference = "";

            if (wrs != null)
            {
                StreamReader sr = new StreamReader(wrs.GetResponseStream());
                XmlDocument xd = new XmlDocument();
                xd.LoadXml(sr.ReadToEnd().Trim());

                gwResult.xmloutput = xd.OuterXml;

                if (xd.SelectSingleNode("/Txn/Success") != null)
                {
                    //ReCo = xd.SelectSingleNode("/Txn/ReCo").InnerText; //Ignore
                    gwResult.success = Convert.ToInt16(xd.SelectSingleNode("/Txn/Success").InnerText);  //1 if transaction successful - 0 if declined or unsuccessful. Will be the same value as Authorized
                }

                //responsetext = xd.SelectSingleNode("/Txn/ResponseText").InnerText;
                //helptext = xd.SelectSingleNode("/Txn/HelpText").InnerText;
                //Some response elements are in different nodes
                //authorized = xd.SelectSingleNode("/Txn/Transaction/Authorized").InnerText; //Indicates if the transaction was authorized or not. Either False (0) or True (1)
                gwResult.reference = xd.SelectSingleNode("/Txn/Transaction/DpsTxnRef").InnerText;
                //authcode = xd.SelectSingleNode("/Txn/Transaction/AuthCode").InnerText;  

                gwResult.message = "To do";

                // further error handling code could go here



            }
            // error handling code omitted
            return gwResult;

        }

        public static string populateselect(string[] options, string selectedoption, string firstoption = "None")
        {
            string selected;
            string html = "";
            if (firstoption != "None")
            {
                html = html + ("<option>" + firstoption + "</option>");

            }

            foreach (string option in options)
            {
                if (option == selectedoption)
                {
                    selected = " selected";
                }
                else
                {
                    selected = "";
                }
                html = html + ("<option" + selected + ">" + option + "</option>");
            }
            return html;
        }

        public static string populateselectwithvalue(string[] options, string selectedoption, string firstoption = "None")
        {
            string selected;
            string html = "";
            if (firstoption != "None")
            {
                html = html + ("<option>" + firstoption + "</option>");

            }

            foreach (string option in options)
            {
                if (option == selectedoption)
                {
                    selected = " selected";
                }
                else
                {
                    selected = "";
                }
                html = html + ("<option value=\"" + "xx" + "\"" + selected + ">" + option + "</option>");
            }
            return html;
        }

        public string buildandpopulateselect(string strConnString, string cmdtext, string selectedoption, Dictionary<string, string> options, string firstoption = "None")
        {
            string selected;
            string html = "";
           
            if (firstoption != "None")
            {
                html = html + ("<option>" + firstoption + "</option>");
            }

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd;

            if (options.ContainsKey("storedprocedure"))
            {
                if(options.ContainsKey("storedprocedurename"))
                {
                    cmd = new SqlCommand(cmdtext, con);
                    cmd.CommandType = CommandType.StoredProcedure;

                }
                else { 
                cmd = new SqlCommand("builddropdownlist", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@sqltext", SqlDbType.VarChar).Value = cmdtext;
                }
            }
            else
            {
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = cmdtext;
            }

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    string Label;
                    string Value = "";
                    string ValueText = "";
                    string selectText = "";
                    while (dr.Read())
                    {
                        Label = dr["label"].ToString();
                        if (options.ContainsKey("usevalues"))
                        {
                            Value = dr["value"].ToString();
                            ValueText = " value=\"" + Value + "\"";
                        } 
                        if (options["selecttype"] == "Label")
                        {
                            selectText = Label;
                        } else
                        {
                            selectText = Value;
                        }

                        if (selectText == selectedoption)
                        {
                            selected = " selected";
                        }
                        else
                        {
                            selected = "";
                        }
                        html = html + ("<option" + ValueText + selected + ">" + Label + "</option>");

                    }
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

            return html;
        }

        public string[,] buildselectarray(string strConnString, string cmdtext)
        {
            string[,] SelectArray = null;

            var myList = new List<SelectList>();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = cmdtext;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        
                        myList.Add(new SelectList()
                        {
                            Label = dr["label"].ToString(),
                            Value = dr["value"].ToString()
                        });
                        
                    }
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

            SelectArray = new string [myList.Count, 2];
            for (int i=0; i < myList.Count; i++)
            {
                SelectArray[i, 0] = ((SelectList)myList[i]).Label;
                SelectArray[i, 1] = ((SelectList)myList[i]).Value;
            }

            return SelectArray;
        }

      

        public static string populateselect_ccmonth(string selectedoption, string firstoption = "None")
        {
            string[] options = new string[12];
            for (int i = 0; i <= 11; i++)
            {
                options[i] = (i + 1).ToString("00");
            }


            return populateselect(options, selectedoption, firstoption);
        }

        public static string populateselect_ccyear(string selectedoption, string firstoption = "None")
        {
            int thisyear = DateTime.Now.Year;
            string[] options = new string[10];
            for (int i = 0; i <= 9; i++)
            {
                options[i] = (thisyear + i).ToString();
            }


            return populateselect(options, selectedoption, firstoption);
        }

        public string isNull(string passval, string passreturn)
        {
            return passval ?? passreturn;
        }

        public void buildfilelist(string path, string url, List<FileClass> FileList, string fieldname, Dictionary<string, string> options)
        {
            //string returnlist = "";

            if (Directory.Exists(path))
            {
                string removeprefix = "";
                if (options.ContainsKey("removeprefix"))
                {
                    removeprefix = options["removeprefix"];
                }

                string[] filePaths = Directory.GetFiles(path);
                string fileName;
                if (filePaths.Count() != 0)
                {
                    foreach (string filePath in filePaths)
                    {
                        string wpextension = System.IO.Path.GetExtension(filePath);
                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filePath);
                        fileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;
                        if (removeprefix != "")
                        {
                            fileName = fileName.Substring(removeprefix.Length);
                        }
                        FileList.Add(new FileClass()
                        {
                            fieldname = fieldname,
                            name = fileName,
                            url = url + "/" + wpfilename + wpextension
                        });
                    }
                }
            }
        }

        public string buildfiletable(string path, string url, string name, Dictionary<string, string> options)
        {
            string returntable = "";

            if (Directory.Exists(path))
            {
                string type = "table";
                if (options.ContainsKey("type"))
                {
                    type = options["type"];
                }

                string removeprefix = "";
                if (options.ContainsKey("removeprefix"))
                {
                    removeprefix = options["removeprefix"];
                }

                string[] filePaths = Directory.GetFiles(path);
                string fileName;
                if (filePaths.Count() != 0)
                {
                    if (type == "table")
                    {
                        returntable = "<div class=\"table-responsive\"><table class=\"table table-condensed\"><tr><th>File name</th><th class=\"readonlyinvisible\">Delete</th></tr>";
                        //returntable = @"<div class=""table-responsive""><table class=""table table-condensed""><tr><th>File name</th><th>Delete</th></tr>";
                    }
                    else
                    {
                        returntable = "<ul>";
                    }
                    foreach (string filePath in filePaths)
                    {
                        string wpextension = System.IO.Path.GetExtension(filePath);
                        string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filePath);
                        fileName = wpfilename.Substring(0, wpfilename.Length - 4) + wpextension;
                        if (removeprefix != "")
                        {
                            fileName = fileName.Substring(removeprefix.Length);
                        }


                        if (type == "table")
                        {
                            //returntable = returntable + "<tr><td><a href=\"" + url + "/" + wpfilename + wpextension + "\" target=\"_blank\">" + fileName + "</a></td><td><input name=\"cb_deletefile_" + name + "_" + wpfilename + wpextension + "\" class=\"readonlyinvisible\" id=\"cb_deletefile_" + name + "_" + wpfilename + wpextension + "\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
                            returntable = returntable + "<tr><td><a href=\"" + url + "/" + wpfilename + wpextension + "\" target=\"_blank\">" + fileName + "</a></td><td><input name=\"cb_deletefile" + "\" class=\"readonlyinvisible\" id=\"cb_deletefile_" + name + "_" + wpfilename + wpextension + "\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
                            //returntable = returntable + @"<tr><td><a href=""" + url + "/" + wpfilename + wpextension + @""" target=""_blank"">" + fileName + @"</a></td><td><input name=""cb_deletefile_" + name + "_" + wpfilename + wpextension + @""" id=""cb_deletefile_" + name + "_" + wpfilename + wpextension + @""" type=""checkbox"" value=""" + wpfilename + wpextension + @"""></td</tr>";
                        }
                        else
                        {
                            returntable = returntable + "<li><a href=\"" + url + "/" + wpfilename + wpextension + "\" target=\"_blank\">" + fileName + "</a></li>";

                        }
                    }
                    if (type == "table")
                    {
                        returntable = returntable + "</table></div>";
                    }
                    //returntable = returntable + @"</table></div>";
                    else
                    {
                        returntable = returntable + "</ul>";
                    }

                }
            }

            return returntable;

        }

        public string htmlattr(string name, string value = "")
        {
            if (value == "")
            {
                return "";
            }
            else
            {
                return " " + name + "= \"" + value + "\"";
            }

        }

        public void createXMLStructure(DataTable repeatertable, NameValueCollection form, XElement rootXml)
        {
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            foreach (string key in form)
            {
                //if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                if (!key.StartsWith("__") && !key.StartsWith("ctl") && !key.StartsWith("clientsideonly_") && !key.StartsWith("btn_"))
                {
                    if (key.StartsWith("repeat_"))
                    {
                        string[] keyparts = key.Split('_');
                        string keypartname = keyparts[1];

                        string keypartindex = keyparts[keyparts.Length - 1];
                        string keypartfield = "";
                        string keypartsdelim = "";

                        for (int i = 3; i <= keyparts.Length - 2; i++)
                        {
                            keypartfield += keypartsdelim + keyparts[i];
                            keypartsdelim = "_";
                        }

                        repeatertable.Rows.Add(keypartname, keypartindex, keypartfield, form[key]);
                    }
                    else
                    {
                        rootXml.Add(new XElement(key, form[key]));
                    }
                }
            }

        }

        public void createXMLStructureWithFiles(DataTable repeatertable, NameValueCollection form, List<FileClass> FileList, XElement rootXml)
        {
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            foreach (string key in form)
            {
                //if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                if (!key.StartsWith("__") && !key.StartsWith("ctl") && !key.StartsWith("clientsideonly_") && !key.StartsWith("btn_"))
                {
                    if (key.StartsWith("repeat_"))
                    {
                        string[] keyparts = key.Split('_');
                        string keypartname = keyparts[1];

                        string keypartindex = keyparts[keyparts.Length - 1];
                        string keypartfield = "";
                        string keypartsdelim = "";

                        for (int i = 3; i <= keyparts.Length - 2; i++)
                        {
                            keypartfield += keypartsdelim + keyparts[i];
                            keypartsdelim = "_";
                        }

                        repeatertable.Rows.Add(keypartname, keypartindex, keypartfield, form[key]);
                    }
                    else
                    {
                        rootXml.Add(new XElement(key, form[key]));
                    }
                }
            }
            if (FileList.Count > 0)
            {
                XElement UploadElement = new XElement("uploaded");

                foreach (var file in FileList)  //Haven't considered repeaters yet
                {
                    //XElement fieldElement = GetOrCreateElement(UploadElement, file.fieldname);
                    XElement fieldElement = new XElement(file.fieldname);

                    fieldElement.Add(new XElement("filename", file.name));
                    fieldElement.Add(new XElement("url", file.url));

                    UploadElement.Add(fieldElement);
                }
                rootXml.Add(UploadElement);
            }
        }

        private static XElement GetOrCreateElement(XContainer container, string name)
        {
            var element = container.Element(name);
            if (element == null)
            {
                element = new XElement(name);
                container.Add(element);
            }
            return element;
        }

        public void populateXML(DataTable repeatertable, XElement rootXml)
        {

            DataView dv2 = new DataView(repeatertable);
            DataTable dvSites = dv2.ToTable(true, "Name");
            foreach (DataRow siterow in dvSites.Rows)
            {
                XElement repeaterXml = new XElement(siterow["Name"].ToString() + "Repeater");

                string sel = "[Name] = '" + siterow["Name"] + "'";
                DataView dv3 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                DataTable dvindexess = dv3.ToTable(true, "Index");
                foreach (DataRow indexrow in dvindexess.Rows)
                {
                    XElement subXml = new XElement(siterow["Name"].ToString());

                    subXml.Add(new XElement(siterow["Name"].ToString() + "Index", indexrow["Index"].ToString()));

                    sel = "[Name] = '" + siterow["Name"] + "' AND [Index] = '" + indexrow["Index"] + "'";
                    DataView dv4 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                    DataTable dvfields = dv4.ToTable();
                    foreach (DataRow fieldrow in dvfields.Rows)
                    {
                        subXml.Add(new XElement(fieldrow["Field"].ToString(), fieldrow["Value"].ToString()));
                    }
                    repeaterXml.Add(subXml);
                }
                rootXml.Add(repeaterXml);
            }
        }

        public string NumberToWords(double amount)
        {
            string stramount = amount.ToString();
            string[] numbersplit = stramount.Split('.');
            int number = Convert.ToInt16(numbersplit[0]);
            //need to do: dollar(s) and cent(s); words and parts

            if (number == 0)
                return "zero";

            if (number < 0)
                return "minus " + NumberToWords(Math.Abs(number));

            string words = "";

            if ((number / 1000000) > 0)
            {
                words += NumberToWords(number / 1000000) + " million ";
                number %= 1000000;
            }

            if ((number / 1000) > 0)
            {
                words += NumberToWords(number / 1000) + " thousand ";
                number %= 1000;
            }

            if ((number / 100) > 0)
            {
                words += NumberToWords(number / 100) + " hundred ";
                number %= 100;
            }

            if (number > 0)
            {
                if (words != "")
                    words += "and ";

                var unitsMap = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
                var tensMap = new[] { "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };

                if (number < 20)
                    words += unitsMap[number];
                else
                {
                    words += tensMap[number / 10];
                    if ((number % 10) > 0)
                        words += "-" + unitsMap[number % 10];
                }
            }

            return words;
        }

        public string encryption(string value, string mode, string options)
        {
            string EncryptionKey = "Wx5gDxqq9t5Cd1I05tTa";
            string result = "";
            if (mode == "Encrypt")
            {
                byte[] clearBytes = Encoding.Unicode.GetBytes(value);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }
                        result = Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
            else
            {
                result = value.Replace(" ", "+");
                byte[] cipherBytes = Convert.FromBase64String(result);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        result = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            return result;
        }


        public string BrowserDetails(System.Web.HttpBrowserCapabilities browser)
        {

            string response = "";
            IPHostEntry Host = default(IPHostEntry);
            string Hostname = null;
            Hostname = System.Environment.MachineName;
            Host = Dns.GetHostEntry(Hostname);
            foreach (IPAddress IP in Host.AddressList)
            {
                if (IP.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    response = "IP Address = " + Convert.ToString(IP) + "<br />";
                }
            }


            response += "<b>Browser Capabilities</b><br />"
                + "Type = " + browser.Type + "<br />"
                + "Name = " + browser.Browser + "<br />"
                + "Version = " + browser.Version + "<br />"
                + "Major Version = " + browser.MajorVersion + "<br />"
                + "Minor Version = " + browser.MinorVersion + "<br />"
                + "Platform = " + browser.Platform + "<br />"
                + "Is Beta = " + browser.Beta + "<br />"
                + "Is Crawler = " + browser.Crawler + "<br />"
                + "Is AOL = " + browser.AOL + "<br />"
                + "Is Win16 = " + browser.Win16 + "<br />"
                + "Is Win32 = " + browser.Win32 + "<br />"
                + "Supports Frames = " + browser.Frames + "<br />"
                + "Supports Tables = " + browser.Tables + "<br />"
                + "Supports Cookies = " + browser.Cookies + "<br />"
                + "Supports VBScript = " + browser.VBScript + "<br />"
                + "Supports JavaScript = " +
                    browser.EcmaScriptVersion.ToString() + "<br />"
                + "Supports Java Applets = " + browser.JavaApplets + "<br />"
                + "Supports ActiveX Controls = " + browser.ActiveXControls
                      + "<br />"
                + "Supports JavaScript Version = " +
                    browser["JavaScriptVersion"] + "<br />";

            return response;
        }


    }
    #region classes
    public class SelectList
    {
        public string Label { get; set; }
        public string Value { get; set; }
    }

    public class AccessList
    {
        public string system { get; set; }
        public string access { get; set; }
        public string response { get; set; }
    }

    #endregion
}