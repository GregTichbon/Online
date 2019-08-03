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
using System.Configuration;
using Generic;

namespace Auction
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
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod(EnableSession = true)]
        public standardResponse Update_User(NameValue[] formVars)    //you can't pass any querystring params
        {
            string URL = formVars.Form("URL");
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(URL);

            string fullname = formVars.Form("fullname");
            string emailaddress = formVars.Form("emailaddress");
            string passcode = formVars.Form("passcode");
            string mobilenumber = formVars.Form("mobilenumber");
            string textnotifications = formVars.Form("textnotifications");
            string contactpermission = formVars.Form("contactpermission");
            Boolean keepmeloggedin = Convert.ToBoolean(formVars.Form("keepmeloggedin"));


            string strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Update_User";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@fullname", SqlDbType.VarChar).Value = fullname;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = emailaddress;
            cmd.Parameters.Add("@passcode", SqlDbType.VarChar).Value = passcode;
            cmd.Parameters.Add("@mobilenumber", SqlDbType.VarChar).Value = mobilenumber;
            cmd.Parameters.Add("@textnotifications", SqlDbType.VarChar).Value = textnotifications;
            cmd.Parameters.Add("@contactpermission", SqlDbType.VarChar).Value = contactpermission;
            

            con.Open();
            string user_ctr = cmd.ExecuteScalar().ToString();
            con.Close();
            con.Dispose();

            HttpContext.Current.Session.Add("Auction_user_ctr", user_ctr);
            HttpContext.Current.Session.Add("Auction_Fullname", fullname);

            if (keepmeloggedin)
            {
                DateTime expires = DateTime.Now.AddMonths(2);
                HttpCookie Auction_user_ctr = new HttpCookie("Auction_user_ctr");
                Auction_user_ctr.Value = user_ctr;
                Auction_user_ctr.Expires = expires;
                HttpContext.Current.Response.Cookies.Add(Auction_user_ctr);

                HttpCookie Auction_Fullname = new HttpCookie("Auction_Fullname", fullname);
                Auction_Fullname.Expires = expires;
                HttpContext.Current.Response.Cookies.Add(Auction_Fullname);

            }

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = user_ctr;
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            return (resultclass);

        }

        [WebMethod(EnableSession = true)]
        public userResponse Login(NameValue[] formVars)    //you can't pass any querystring params
        {
            userResponse resultclass = new userResponse();
            string URL = formVars.Form("URL");
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(URL);

            string emailaddress = formVars.Form("emailaddress");
            string passcode = formVars.Form("passcode");
            Boolean keepmeloggedin = Convert.ToBoolean(formVars.Form("keepmeloggedin"));

            string strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.CommandText = "Login";
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = emailaddress;
            cmd.Parameters.Add("@passcode", SqlDbType.VarChar).Value = passcode;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                string user_ctr = dr["user_ctr"].ToString();
                string fullname = dr["fullname"].ToString();

                resultclass.user_ctr = user_ctr;
                resultclass.fullname = fullname;
                resultclass.message = "Valid";

                HttpContext.Current.Session.Add("Auction_user_ctr", user_ctr);
                HttpContext.Current.Session.Add("Auction_Fullname", fullname);

                if(keepmeloggedin)
                {
                    DateTime expires = DateTime.Now.AddHours(1);
                    HttpCookie Auction_user_ctr = new HttpCookie("Auction_user_ctr");
                    Auction_user_ctr.Value = user_ctr;
                    Auction_user_ctr.Expires = expires;
                    HttpContext.Current.Response.Cookies.Add(Auction_user_ctr);

                    HttpCookie Auction_Fullname = new HttpCookie("Auction_Fullname", fullname);
                    Auction_Fullname.Expires = expires;
                    HttpContext.Current.Response.Cookies.Add(Auction_Fullname);

                }

            } else
            {
                resultclass.message = "Invalid";

                HttpContext.Current.Session.Remove("Auction_user_ctr");
                HttpContext.Current.Session.Remove("Auction_Fullname");
            }
            con.Close();
            con.Dispose();

            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            return (resultclass);
        }

        [WebMethod]
        //public string TabletoExcelCSV(string table)    //you can't pass any querystring params
        public standardResponse TabletoExcelCSV(string table)    //you can't pass any querystring params
        {
            #region old code
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
            #endregion
            table = table.Replace("&", "&amp;");
            Functions functions = new Functions();
            string filename = functions.getReference() + ".xlsx";
            string templatefilename = Server.MapPath(".") + "\\templates\\" + "winners.xlsx";
            string fullfilename = Server.MapPath(".") + "\\downloads\\" + filename;
            var fi = new FileInfo(templatefilename);
            using (var p = new ExcelPackage(fi))
            {
                //var ws = p.Workbook.Worksheets.Add("TheGreatBall");
                var ws = p.Workbook.Worksheets["TheGreatBall"];


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
                            //ws.Cells[r1, c1].Style.Font.Bold = true;
                        }
                        string numberformat = ws.Cells[r1, c1].Style.Numberformat.Format;
                        if (numberformat == "@")
                        {
                            ws.Cells[r1, c1].Value = text;
                        }
                        else
                        {
                            double number;
                            if (Double.TryParse(text, out number))
                                ws.Cells[r1, c1].Value = number;
                            else
                                ws.Cells[r1, c1].Value = text;
                        }


                        //string attr = tdnode.Attributes["colspan"]?.InnerText;
                    }
                }
                p.SaveAs(new FileInfo(fullfilename));

            }

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Complete";
            resultclass.message = filename;
            //JavaScriptSerializer JS = new JavaScriptSerializer();
            //string passresult = JS.Serialize(resultclass);
            //return (passresult);
            
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

public class userResponse
{
    public string user_ctr;
    public string fullname;
    public string message;
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

