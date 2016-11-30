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

using TeOranganui.Models;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.Collections.Specialized;
using System.Xml.Linq;

namespace TeOranganui.Functions
{
    public class Functions
    {
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

        public void sendemail(string emailsubject, string emailbody, string emailRecipient, string emailbcc)
        {
            //MailMessage mail = new MailMessage("noreply@whanganui.govt.nz", emailRecipient);

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("xxxxxx", "xxxxxxx");

            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            //client.Host = "wdc-cas.local.whanganui.govt.nz";
            client.Host = "xxxxxxx"; //"192.168.1.78";

            mail.IsBodyHtml = true;

            string[] emailaddresses = emailRecipient.Split(';');

            IEnumerable<string> distinctemailaddresses = emailaddresses.Distinct();

            foreach (string emailaddress in distinctemailaddresses)
            {
                mail.To.Add(emailaddress);
            }

            if (emailbcc != "")
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

        public void Log(string location, string logMessage, string EmailAddress)
        {
            String LogFileLocation = ConfigurationManager.AppSettings["Logfile.Location"];

            StreamWriter w = File.AppendText(LogFileLocation);
            w.WriteLine("{0}", DateTime.Now.ToLongTimeString() + "\t" + DateTime.Now.ToLongDateString() + "\t" + location + "\t" + logMessage + "\t" + EmailAddress);
            w.Flush();
            w.Close();
            if (EmailAddress != "")
            {
                sendemail("Online Applications Error", location + "<br>" + logMessage, EmailAddress, "");
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

            if (!Directory.Exists(submissionpath))
            {
                Directory.CreateDirectory(submissionpath);
            }

            int c1;
            string newfilename;

            for (int i = 0; i <= files.Count - 1; i++)
            {
                if (files[i].ContentLength > 0)
                {
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
            string value = "";
            foreach (string option in options)
            {
                string[] parts = (option + "\x00FD").Split('\x00FD');
                if (parts[1] != "")
                {
                    value = " value=\"" + parts[1] + "\"";
                }
                if (parts[0] == selectedoption)
                {
                    selected = " selected";
                }
                else
                {
                    selected = "";
                }
                html = html + ("<option" + value + selected + ">" + parts[0] + "</option>");
            }
            return html;
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
                            returntable = returntable + "<tr><td><a href=\"" + url + "/" + wpfilename + wpextension + "\" target=\"_blank\">" + fileName + "</a></td><td><input name=\"cb_deletefile_" + name + "_" + wpfilename + wpextension + "\" class=\"readonlyinvisible\" id=\"cb_deletefile_" + name + "_" + wpfilename + wpextension + "\" type=\"checkbox\" value=\"" + wpfilename + wpextension + "\"></td</tr>";
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

        //public void createXMLStructure(DataTable repeatertable, NameValueCollection form, XElement rootXml)
        public void createXMLStructure(DataTable repeatertable, NameValue[] form, XElement rootXml)

        {
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));
           
            //foreach (string key in form)
            //   string value = form[key];

            foreach (var obj in form)
            {
                string key = obj.name; // Used for NameValue[] rather than NameValueCollection
                string value = obj.value; // Used for NameValue[] rather than NameValueCollection

                if (key.Substring(0, 2) != "__" && key.Substring(0, 3) != "ctl" && !key.StartsWith("clientsideonly_"))
                {
                    if (key.Substring(0, 7) == "repeat_")
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

                        repeatertable.Rows.Add(keypartname, keypartindex, keypartfield, value);
                    }
                    else
                    {
                        rootXml.Add(new XElement(key, value));
                    }
                }
            }

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

        public static string[] populatelist(string grouptype_description, string list_name)
        {
            string liststring = "";
            string delim = "";
            //string[] list; // = new string[4] { "Hairdresser", "Camping ground", "Funeral home", "Offensive trade"}; //, "Other preparation / manufacture" 

            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("PopulateList", con);
            cmd.Parameters.Add("@grouptype_description", SqlDbType.NVarChar).Value = grouptype_description;
            cmd.Parameters.Add("@list_name", SqlDbType.NVarChar).Value = list_name;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        liststring += delim + dr["label"].ToString() + "\x00FD" + dr["list_item_id"].ToString();
                        delim = "\x00FE";
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
            return liststring.Split('\x00FE');
        }
    }

}