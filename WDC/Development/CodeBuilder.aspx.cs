using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using Online.Models;
using System.Reflection;
using Online.WDCFunctions;

namespace Online.Administration
{
    public partial class CodeBuilder : System.Web.UI.Page
    {

        public string[] c_fieldtype = new string[2] { "Field", "Other" };
        public string[] c_controltype = new string[4] { "TextBox", "CheckBox", "DropDown", "FileUpload" };
        public string[] c_sql_datatype = new string[9] { "None", "VarChar", "Int", "BigInt", "DateTime", "Bit", "Date", "uniqueidentifier", "money" };
        public string[] c_required = new string[3] { "Yes", "No", "Dependant" };
        public string[] c_type = new string[2] { "Text", "Number" };
        public string[] c_sp_datatype = new string[5] { "VarChar", "Int", "BigInt", "Decimal", "Money" }; //USE SqlDbType instead


        /*
         "Seq",                      SEQUENCE
         "Type" ,                    FIELDTYPE
         "ControlType" ,             CONTROLTYPE
         "FieldName" ,               FIELD_NAME
         "Label" ,                   TITLE
         "Description" , 
         "Required" , 
         "MaxLength" ,               MAXLENGTH
         "DBType" ,                  SQL_DATATYPE
         "xs" , 
         "sm" , 
         "md" , 
         "lg" , 
         "charactersleft" , 
         "Notes",                    NOTES
         "Delete"                    DELETED
         */

        static int id;
        //static Dictionary<string, fields> mainfieldsdict = new Dictionary<string, fields>();
        static Dictionary<string, fields2> mainfieldsdict2 = new Dictionary<string, fields2>();
        //static Dictionary<string, fields> fieldsdict = new Dictionary<string, fields>();
        static Dictionary<string, fields2> fieldsdict2 = new Dictionary<string, fields2>();
        public string lineids = "";

        protected void Page_Load(object sender, EventArgs e)
        {
/*
            if (!IsPostBack)
            {
                WDCFunctions.WDCFunctions wdcfunctions = new WDCFunctions.WDCFunctions();

                id = Convert.ToInt32(Request.QueryString["id"]);
                id = 3;


                string xline;
                string xid;
                string xsize;
                string xmaxlength;
                string xcontrol;
                string options;

                mainfieldsdict2.Clear();
                fieldsdict2.Clear();

                String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_definitions", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@definition_ctr", SqlDbType.Int).Value = 4;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            fields2 mainattributes = new fields2();

                            mainattributes.db_name = dr["db_name"].ToString();
                            mainattributes.title = dr["title"].ToString();
                            mainattributes.type = dr["type"].ToString();
                            mainattributes.multi_flag = dr["multi_flag"].ToString();
                            mainattributes.subtable_flag = dr["subtable_flag"].ToString();
                            mainattributes.field_name = dr["field_name"].ToString();
                            mainattributes.sql_datatype = dr["sql_datatype"].ToString();
                            mainattributes.sp_datatype = dr["sp_datatype"].ToString();
                            mainattributes.sequence = Convert.ToInt32(dr["sequence"]);
                            mainattributes.fieldtype = dr["fieldtype"].ToString();
                            mainattributes.controltype = dr["controltype"].ToString();

                            mainfieldsdict2.Add(dr["db_name"].ToString(), mainattributes);

                            
                            //mainfieldsdict.Add(dr["db_name"].ToString(), new fields(dr["db_name"].ToString()
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

                con = new SqlConnection(strConnString);
                cmd = new SqlCommand("Get_definitions", con);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@definition_ctr", SqlDbType.Int).Value = id.ToString();

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
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
                            attributes.definitionfields_ctr = dr["definitionfields_ctr"].ToString();
                            attributes.controltype = dr["controltype"].ToString();

                            fieldsdict2.Add(dr["db_name"].ToString(), attributes);

                         
                             //fieldsdict.Add(dr["title"].ToString(), new Models.fields(dr["db_name"].ToString()
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
                             //                                                , Convert.ToInt32(dr["definitionfields_ctr"])
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

                List<string> lineidsArray = new List<string>();

                Dictionary<string, string> dictfields = new Dictionary<string, string>();

                Boolean firstrow = true;
                string html = "";
                html += "<table border=\"1\" id=\"maintable\" class=\"StripedTable\">";

                foreach (var datarow in fieldsdict2)
                {
                    if (firstrow)
                    {
                        //html += "<thead>";
                        html += "<tr>";
                        foreach (var maindatarow in mainfieldsdict2)
                        {
                            html += "<td>" + maindatarow.Value.title + "</td>";
                        }
                        html += "</tr>\r\n";
                        //html += "</thead>";
                        firstrow = false;
                    }
                    html += "<tr>";

                    xline = datarow.Value.definitionfields_ctr;

                    lineidsArray.Add(xline);

                  
                                        //fields2 datarowfields = datarow.Value;

                                        //PropertyInfo[] properties = datarowfields.GetType().GetProperties();
                                        //foreach (PropertyInfo pi in properties)
                                        //{
                                        //    dictfields[pi.Name] = pi.GetValue(datarowfields, null).ToString();
                                        //}
                    
                    dictfields["db_name"] = datarow.Value.db_name;
                    dictfields["title"] = datarow.Value.title;
                    dictfields["type"] = datarow.Value.type;
                    dictfields["multi_flag"] = datarow.Value.multi_flag;
                    dictfields["subtable_flag"] = datarow.Value.subtable_flag;
                    dictfields["field_name"] = datarow.Value.field_name;
                    dictfields["sql_datatype"] = datarow.Value.sql_datatype;
                    dictfields["sp_datatype"] = datarow.Value.sp_datatype;
                    dictfields["sequence"] = datarow.Value.sequence.ToString();
                    dictfields["fieldtype"] = datarow.Value.fieldtype;
                    dictfields["controltype"] = datarow.Value.controltype;

                    foreach (var item in mainfieldsdict2)
                    {
                        xsize = "";
                        xmaxlength = "";
                        xcontrol = "";
                        xid = "\"" + item.Key + "_" + xline + "\"";

                        switch (item.Value.controltype)
                        {
                            case "TextBox":
                                //xsize = wdcfunctions.htmlattr("size",  dictfields["size"]);
                                //xmaxlenth = ("maxlength",  dictfields["maxlength"]);
                                xcontrol = "<input name=" + xid + " id=" + xid + " type=\"text\"" + xsize + xmaxlength + " value=\"" + dictfields[item.Key] + "\">";
                                break;
                            case "DropDown":
                                switch (item.Value.db_name)
                                {
                                    case "type":
                                        options = Online.WDCFunctions.WDCFunctions.populateselect(c_type, dictfields[item.Key], "");
                                        break;
                                    case "fieldtype":
                                        options = Online.WDCFunctions.WDCFunctions.populateselect(c_fieldtype, dictfields[item.Key], "");
                                        break;
                                    case "controltype":
                                        options = Online.WDCFunctions.WDCFunctions.populateselect(c_controltype, dictfields[item.Key], "");
                                        break;
                                    case "sql_datatype":
                                        options = Online.WDCFunctions.WDCFunctions.populateselect(c_sql_datatype, dictfields[item.Key], "");
                                        break;
                                    case "sp_datatype":
                                        options = Online.WDCFunctions.WDCFunctions.populateselect(c_sp_datatype, dictfields[item.Key], "");
                                        break;
                                    default:
                                        options = "";
                                        break;
                                }

                                xcontrol = "<select name=" + xid + " id=" + xid + " size=\"1\">" + options + "<select>";
                                break;
                            default:
                                break;
                        }

                        lineids = String.Join(", ", lineidsArray);
                        html += "<td>" + xcontrol + "</td>";


                    }

                    html += "</tr>\r\n";
                }




                html += "</table>";

                lbl_html.Text = html;
            }
*/
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {
            SqlDbType sql_dbtype;

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Update_definitions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            string[] lineidsArray = Array.ConvertAll(Request.Form["hf_lineids"].Split(','), Convert.ToString);
            int definitionfields_ctr;

            foreach (string lineid in lineidsArray)
            {
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@definition_ctr", SqlDbType.Int).Value = id;
                if (lineid.Substring(0, 1) == "x")
                {
                    definitionfields_ctr = 0;
                }
                else
                {
                    definitionfields_ctr = Convert.ToInt16(lineid);
                }

                cmd.Parameters.Add("@definitionfields_ctr", SqlDbType.Int).Value = definitionfields_ctr;

                string xx = "";
                foreach (KeyValuePair<string, Models.fields2> entry in mainfieldsdict2)
                {
                    string dbtype = entry.Value.dbtype;
                    if (dbtype != "")
                    {
                        if (dbtype == "varchar")
                        {
                            dbtype += "(" + entry.Value.maxlength + ")";
                        }
                        sql_dbtype = (SqlDbType)Enum.Parse(typeof(SqlDbType), dbtype, true);
                        xx = "@" + entry.Value.fieldname + "=" + Request.Form[entry.Value.fieldname + "_" + lineid];
                        cmd.Parameters.Add("@" + entry.Value.fieldname, sql_dbtype).Value = Request.Form[entry.Value.fieldname + "_" + lineid];
                    }
                }
                cmd.Connection = con;

                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();

                    }


                }
                catch (Exception ex)
                {
                    //WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
                    xx = ex.Message;
                }
                finally
                {
                    con.Close();
                }
            }
            con.Dispose();

            Response.Redirect("CodeBuilder.aspx");
        }

        //protected string populateselect(string[] options, string selectedoption, string firstoption)
        //{
        //    WDCFunctions.WDCFunctions myWDCFunctions = new WDCFunctions.WDCFunctions();
        //    return myWDCFunctions.populateselect(options, selectedoption,firstoption );

        //}
    }
}