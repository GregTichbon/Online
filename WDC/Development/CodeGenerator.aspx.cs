using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using Online.Models;
using System.Reflection;
using Online.WDCFunctions;
using Excel = Microsoft.Office.Interop.Excel;

namespace Online.Administration
{
    public partial class CodeGenerator : System.Web.UI.Page
    {
        static int id;
        static Dictionary<string, fields2> fieldsdict2 = new Dictionary<string, fields2>();
        static string mode = "Excel";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (mode == "Excel")
            {
                Excel.Application xlApp;
                Excel.Workbook xlWorkBook;

                string path = Server.MapPath(".");

                xlApp = new Excel.Application();
                xlWorkBook = xlApp.Workbooks.Open(path + "\\fields.xlsx", 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);


                foreach (Excel.Worksheet worksheet in xlApp.Worksheets)
                {
                    if (worksheet.Name != "Notes" && worksheet.Name != "Working" && worksheet.Name != "Lookups")
                    {
                        dd_name.Items.Add(worksheet.Name);
                    }
                }
            }


        }





        protected void btn_createcode_click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions wdcfunctions = new WDCFunctions.WDCFunctions();

            #region load excel

            string tablename = "";

            if (mode == "Excel")
            {
                string[] headers = new string[15] { "FieldName", "ScreenType", "ControlType", "TextBoxRows", "Title", "SimpleType", "DBType", "MaxLength", "Mandatory", "Choices", "ReadOnly", "Help", "Notes", "Repeater", "RepeaterType" };


                tablename = dd_name.SelectedItem.Text;

                /*
                 type: text, textarea, dropdown, checkbox, file, radio
                 dbtype: varchar, bigint
                 choices: dropdown, checkbox, radio options
                 */

                Excel.Application xlApp;
                Excel.Workbook xlWorkBook;
                Excel.Worksheet xlWorkSheet;
                Excel.Range range;

                string str;
                int rCnt = 0;
                int cCnt = 0;

                string path = Server.MapPath(".");

                xlApp = new Excel.Application();
                xlWorkBook = xlApp.Workbooks.Open(path + "\\fields.xlsx", 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
                xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(tablename);

                range = xlWorkSheet.UsedRange;

                for (cCnt = 1; cCnt <= range.Columns.Count; cCnt++)
                {
                    str = (string)(range.Cells[1, cCnt] as Excel.Range).Value2;
                    if (str != headers[cCnt - 1])
                    {
                        //error - column cCnt is str but should be headers[cCnt - 1]
                    }
                }

                for (rCnt = 2; rCnt <= range.Rows.Count; rCnt++)
                {

                    fields2 attributes = new fields2();

                    attributes.fieldname = (string)(range.Cells[rCnt, 1] as Excel.Range).Value2.ToLower();
                    attributes.screentype = (string)(range.Cells[rCnt, 2] as Excel.Range).Value2;
                    attributes.controltype = (string)(range.Cells[rCnt, 3] as Excel.Range).Value2;
                    //attributes.textboxrows = (string)((range.Cells[rCnt, 4] as Excel.Range).Value2 ?? "2");
                    attributes.textboxrows = range.Cells[rCnt, 4].Text.ToString();


                    attributes.title = (string)(range.Cells[rCnt, 5] as Excel.Range).Value2;
                    attributes.simpletype = (string)(range.Cells[rCnt, 6] as Excel.Range).Value2;
                    attributes.dbtype = (string)(range.Cells[rCnt, 7] as Excel.Range).Value2;
                    //attributes.maxlength = (string)((range.Cells[rCnt, 8] as Excel.Range).Value2 ?? "");

                    attributes.maxlength = range.Cells[rCnt, 8].Text.ToString();

                    attributes.mandatory = (string)(range.Cells[rCnt, 9] as Excel.Range).Value2;
                    attributes.choices = (string)(range.Cells[rCnt, 10] as Excel.Range).Value2;
                    attributes.read_only = (string)(range.Cells[rCnt, 11] as Excel.Range).Value2;
                    attributes.help = (string)(range.Cells[rCnt, 12] as Excel.Range).Value2;

                    attributes.repeater = (string)(range.Cells[rCnt, 14] as Excel.Range).Value2;
                    attributes.repeatertype = (string)(range.Cells[rCnt, 15] as Excel.Range).Value2;
                    attributes.multi_flag = "";
                    attributes.subtable_flag = "";
                    attributes.sequence = rCnt - 1;

                    fieldsdict2.Add((string)(range.Cells[rCnt, 1] as Excel.Range).Value2, attributes);
                }

                xlWorkBook.Close(true, null, null);
                xlApp.Quit();

                releaseObject(xlWorkSheet);
                releaseObject(xlWorkBook);
                releaseObject(xlApp);
            }
            /*

        else
        {
            id = Convert.ToInt32(Request.QueryString["id"]);
            id = 3;

            //fieldsdict2.Clear();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_definitions", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@definition_ctr", SqlDbType.Int).Value = id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        tablename = dr["tablename"].ToString();
                        fields2 attributes = new fields2();

                        attributes.db_name = dr["db_name"].ToString();
                        attributes.title = dr["title"].ToString();
                        attributes.type = dr["type"].ToString();
                        attributes.multi_flag = dr["multi_flag"].ToString();
                        attributes.subtable_flag = dr["subtable_flag"].ToString();
                        attributes.field_name = dr["field_name"].ToString();
                        attributes.sql_datatype = dr["sql_datatype"].ToString();
                        attributes.sp_datatype = dr["sp_datatype"].ToString();
                        attributes.sequence = Convert.ToInt32(dr["sequence"]);
                        attributes.fieldtype = dr["fieldtype"].ToString();
                        attributes.controltype = dr["controltype"].ToString();

                        fieldsdict2.Add(dr["field_name"].ToString(), attributes);

                           
                        //fieldsdict.Add(dr["db_name"].ToString(), new fields(dr["db_name"].ToString()
                        //                                                , dr["title"].ToString()
                        //                                                , dr["type"].ToString()
                        //                                                , dr["multi_flag"].ToString()
                        //                                                , dr["subtable_flag"].ToString()
                        //                                                , dr["field_name"].ToString()
                        //                                                , dr["sql_datatype"].ToString()
                        //                                                , dr["sp_datatype"].ToString()
                        //                                                , Convert.ToInt32(dr["sequence"])
                        //                                                , dr["fieldtype"].ToString()
                        //                                                , dr["controltype"].ToString()
                        //                                               , "")
                        //                                                );
                          

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

        } */

            #endregion

            string nl = System.Environment.NewLine;
            string html = "";

            html += "SET ANSI_NULLS ON<br />GO<br />SET QUOTED_IDENTIFIER ON<br />GO<br />SET ANSI_PADDING ON<br />GO<br />" + nl;
            html += "CREATE TABLE [dbo].[" + tablename + "](<br />" + nl;
            html += "[" + tablename + "_CTR] [bigint] IDENTITY(1,1) NOT NULL,<br />" + nl;
            html += "[Reference] [varchar](50) NULL,<br />" + nl;
            foreach (var datarow in fieldsdict2)
            {
                if (datarow.Value.dbtype != "")
                {
                    string dbtype = datarow.Value.dbtype;
                    if (dbtype != "")
                    {
                        if (dbtype == "varchar")
                        {
                            dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                        }
                        html += "[" + datarow.Value.fieldname + "] " + datarow.Value.dbtype + " NULL,<br />" + nl;
                    }
                }
            }

            html += "[CreatedDate] [datetime] NOT NULL,<br />" + nl;
            html += "[ModifiedDate] [datetime] NOT NULL,<br />" + nl;
            html += "[Entity_CTR] [bigint] NULL,<br />" + nl;

            html += "CONSTRAINT [PK_" + tablename + "] PRIMARY KEY CLUSTERED<br />" + nl;
            html += "(<br />" + nl;
            html += "[" + tablename + "_CTR] ASC<br />" + nl;
            html += ")WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]<br />" + nl;
            html += ") ON [PRIMARY]<br />" + nl;
            html += "GO<br />" + nl;
            html += "SET ANSI_PADDING OFF<br />" + nl;
            html += "GO<br />" + nl;
            html += "ALTER TABLE [dbo].[" + tablename + "] ADD  CONSTRAINT [DF_" + tablename + "_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]<br />" + nl;
            html += "GO<br />" + nl;
            html += "ALTER TABLE [dbo].[" + tablename + "] ADD  CONSTRAINT [DF_" + tablename + "_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]<br />" + nl;
            html += "GO<br />" + nl;

            html += "<hr>" + nl;

            html += "ALTER PROCEDURE [dbo].[Update_" + tablename + "] (<br />" + nl;

            html += "@Module_CTR bigint = 0,<br />" + nl;
            html += "@Reference varchar(50),<br />" + nl;
            html += "@Entity_CTR int,<br />" + nl;


            foreach (var datarow in fieldsdict2)
            {
                string dbtype = datarow.Value.dbtype;
                if (dbtype != "")
                {
                    if (dbtype == "varchar")
                    {
                        dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                    }
                    html += "@" + datarow.Value.fieldname + " " + dbtype + ",<br />" + nl;
                }
            }
            //html = html.Remove(html.Length - 1);

            html += ")<br />" + nl;
            html += "as<br />" + nl;

            html += "--Logging Start---------------------------<br />" + nl;
            html += "	declare @SQLLog_CTR bigint<br />" + nl;
            html += "	insert into SQLLog (SQLID) values ('Update_" + tablename + "')<br />" + nl;
            html += "	SELECT @SQLLog_CTR = SCOPE_IDENTITY()<br />" + nl;


            html += "	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'Module_CTR', 'Number', 'bigint', @Module_CTR)<br />" + nl;
            html += "	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Reference', 'Text', 'varchar(50)', @Reference)<br />" + nl;
            html += "	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'Entity_CTR', 'Number', 'int', @Entity_CTR)<br />" + nl;



            foreach (var datarow in fieldsdict2)
            {
                string dbtype = datarow.Value.dbtype;
                if (dbtype != "")
                {
                    if (dbtype == "varchar")
                    {
                        dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                    }
                    html += "insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, " + datarow.Value.simpletype + "Val) values (@SQLLog_CTR, '" + datarow.Value.fieldname + "', '" + datarow.Value.simpletype + "', '" + dbtype + "', @" + datarow.Value.fieldname + ")<br />" + nl;
                }
            }
            html += "--Logging End---------------------------<br />" + nl;

            html += "declare @ctr bigint<br />" + nl;


            html += "if @Module_ctr = 0<br />" + nl;
            html += "begin<br />" + nl;
            html += "insert into " + tablename + " (<br />" + nl;
            html += "Reference,<br />" + nl;
            html += "Entity_CTR,<br />" + nl;
            foreach (var datarow in fieldsdict2)
            {
                string dbtype = datarow.Value.dbtype;
                if (dbtype != "")
                {
                    if (dbtype == "varchar")
                    {
                        dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                    }
                    html += datarow.Value.fieldname + ",<br />" + nl;
                }
            }
            //html = html.Remove(html.Length - 1);

            html += ") values (<br />" + nl;
            html += "@Reference,<br />" + nl;
            html += "@Entity_CTR,<br />" + nl;


            foreach (var datarow in fieldsdict2)
            {
                string dbtype = datarow.Value.dbtype;
                if (dbtype != "")
                {
                    if (dbtype == "varchar")
                    {
                        dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                    }
                    html += "@" + datarow.Value.fieldname + ",<br />" + nl;
                }
            }
            //html = html.Remove(html.Length - 1);

            html += ")<br />" + nl;
            html += "SELECT @ctr = SCOPE_IDENTITY()<br />" + nl;
            html += "end<br />" + nl;
            html += "else<br />" + nl;
            html += "begin<br />" + nl;
            html += "update " + tablename + " set<br />" + nl;
            html += "Reference = @Reference,<br />" + nl;

            foreach (var datarow in fieldsdict2)
            {
                string dbtype = datarow.Value.dbtype;
                if (dbtype != "")
                {
                    if (dbtype == "varchar")
                    {
                        dbtype += "(" + datarow.Value.maxlength + ")" + nl;
                    }
                    html += datarow.Value.fieldname + " = @" + datarow.Value.fieldname + ",<br />" + nl;
                }
            }
            html += "ModifiedDate = GETDATE()<br />" + nl;
            html += "where " + tablename + "_CTR = @Module_ctr<br />" + nl;
            html += "SELECT @ctr = @Module_ctr<br />" + nl;
            html += "end<br />" + nl;

            html += "--SP End---------------------------<br />" + nl;

            html += "<div class=\"form-group\">" + nl;
            html += "<label class=\"control-label col-sm-4\" for=\"tb_reference\">Application reference number:</label>" + nl;
            html += "<div class=\"col-sm-8\">" + nl;
            html += "<asp:TextBox ID=\"tb_reference\" runat=\"server\" ReadOnly=\"true\"></asp:TextBox>" + nl;
            html += "</div>" + nl;
            html += "</div>" + nl;

            string screen = "<table>" + nl;
            string email = "<table>" + nl;


            foreach (var datarow in fieldsdict2)
            {
                string fieldname = datarow.Value.fieldname;
                string controlname = "";
                string input = "";
                string required = "";
                string maxlength = "";
                string repeaterprefix = "";
                string repeatersuffix = "";
                string screenemail = "";


                string help = "";

                if (datarow.Value.mandatory == "Yes")
                {
                    required = " required";
                }
                if (datarow.Value.maxlength != "" && datarow.Value.maxlength != null)
                {
                    maxlength = " maxlength=\"" + datarow.Value.maxlength + "\"";
                }
                if (datarow.Value.repeater != "" && datarow.Value.repeater != null)
                {
                    repeaterprefix = "repeat_" + datarow.Value.repeater + "_";
                    repeatersuffix = "_";
                }

                switch (datarow.Value.controltype)
                {
                    case "textbox":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<textarea id=\"" + controlname + "\" name=\"" + controlname + "\" class=\"form-control\" rows=\"" + datarow.Value.textboxrows + "\"" + required + maxlength + "></textarea>";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;
                    case "text":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"text\" class=\"form-control\"" + required + maxlength + " />";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;
                    case "email":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"email\" class=\"form-control\"" + required + maxlength + " />";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;
                    case "emailconfirm":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"email\" class=\"form-control\"" + required + " />";
                        break;
                    case "mobilephone":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"email\" class=\"form-control phone\"" + required + "placeholder=\"eg: 027 123456...\"" + " />";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;
                    case "phone":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"email\" class=\"form-control phone\"" + required + "placeholder=\"eg: 06 1234567 or 027 123456...\"" + " />";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;

                    case "dropdown":
                        controlname = repeaterprefix + "dd_" + fieldname + repeatersuffix;
                        input = "<select id=\"" + controlname + "\" name=\"" + controlname + "\" class=\"form-control\"" + required + ">";
                        input += "<option></option>";
                        input += "<%= Online.WDCFunctions.WDCFunctions.populateselect(" + fieldname + ", \"\",\"None\") %>";
                        input += "</select>";
                        screenemail = "||rf|dd_" + fieldname + "||";
                        break;
                    case "address":
                        controlname = repeaterprefix + "tb_" + fieldname + repeatersuffix;
                        input = "<span id=\"span_" + controlname + "format\">Address lookup mode (preferred)</span>";
                        input += " <a href=\"javascript:void(0);\" id=\"" + controlname + "format\" class=\"addressformat\">Change</a>";
                        input += "<textarea id=\"" + controlname + "\" name=\"" + controlname + "\" class=\"form-control autoaddress\" rows=\"4\"></textarea>";
                        screenemail = "||rf|tb_" + fieldname + "||";
                        break;
                    case "file":
                        controlname = repeaterprefix + "fu_" + fieldname + repeatersuffix;
                        input = "<input id=\"" + controlname + "\" name=\"" + controlname + "\" type=\"file\" />";
                        screenemail = "||rf|fu_" + fieldname + "||";
                        break;
                    default:
                        break;
                }

                if (datarow.Value.help != "" && datarow.Value.help != null)
                {
                    help = "<img src=\"../Images/questionsmall.png\" title=\"" + help + "\" />";
                }
                html += "<div class=\"form-group\">";
                html += "<label class=\"control-label col-sm-4\" for=\"" + controlname + "\">" + datarow.Value.title + help + "</label>" + nl;
                html += "<div class=\"col-sm-8\">" + nl;
                html += input;
                html += "</div>" + nl;
                html += "</div>" + nl;

                email += "<tr><td align=\"right\" width=\"50%\">" + datarow.Value.title + "</td><td>" + screenemail + "</td></tr>" + nl;
                screen += "<tr><td>" + datarow.Value.title + "</td><td>" + screenemail + "</td></tr>" + nl;

            }

            screen += "</table>" + nl;
            email += "</table>" + nl;

            lit_html.Text = html + nl + "<br /><br />" + nl + email + nl + "<br /><br />" + nl + screen;
        }

        private void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                //MessageBox.Show("Unable to release the Object " + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }

    }





}