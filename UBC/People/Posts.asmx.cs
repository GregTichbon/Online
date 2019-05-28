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

            cmd.CommandText = "Update_Person_Transaction";
            cmd.Parameters.Add("@person_transaction_id", SqlDbType.VarChar).Value = person_transaction_id.Substring(13);
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
