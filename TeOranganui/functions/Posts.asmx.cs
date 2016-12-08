using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

//using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
//using Newtonsoft.Json;
//using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Text;

using System.Web.Script.Services;
using System.Web.Configuration;
using TeOranganui.Models;
using System.IO;

using System.Xml.Linq;
using System.Data.SqlTypes;

namespace TeOranganui.posts
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
        Functions.Functions Functions = new Functions.Functions();

        [WebMethod]
        public string application(NameValue[] formVars)    //you can't pass any querystring params
        {
            #region fields
            string xxxxx = formVars.Form("tb_group");
            #endregion


            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = xxxxx;
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }

        [WebMethod]
        public string update_school(NameValue[] formVars)    //you can't pass any querystring params
         {

            #region fields
            #endregion

            #region setup for database (Standard)
            string strConnString = "Data Source=toh-app;Initial Catalog=TOIHA;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Update_School", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            #endregion

            #region setup specific data
            //cmd.Parameters.Add("@links", SqlDbType.VarChar).Value = links;  //Standard
            #endregion //setup specific data

            #region BuildXML
            //XElement rootXml = new XElement("root");
            //DataTable repeatertable = new DataTable("Repeater");

            //Functions.createXMLStructure(repeatertable, Request.Form, rootXml);
            //Functions.createXMLStructure(repeatertable, formVars, rootXml);

            //Functions.populateXML(repeatertable, rootXml);
            #endregion //BuildXML

            //cmd.Parameters.Add("@xml", SqlDbType.Xml).Value = new SqlXml(rootXml.CreateReader());
            cmd.Parameters.Add("@group_id", SqlDbType.VarChar).Value = formVars.Form("hf_group_id");
            cmd.Parameters.Add("@groupname", SqlDbType.VarChar).Value = formVars.Form("tb_groupname");
            cmd.Parameters.Add("@gendertype", SqlDbType.VarChar).Value = formVars.Form("dd_gendertype");
            cmd.Parameters.Add("@authority", SqlDbType.VarChar).Value = formVars.Form("dd_authority");
            cmd.Parameters.Add("@decile", SqlDbType.VarChar).Value = formVars.Form("dd_decile");
            cmd.Parameters.Add("@moenumber", SqlDbType.VarChar).Value = formVars.Form("tb_moenumber");
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = formVars.Form("dd_type");
            cmd.Parameters.Add("@startyear", SqlDbType.VarChar).Value = formVars.Form("dd_startyear");
            cmd.Parameters.Add("@endyear", SqlDbType.VarChar).Value = formVars.Form("dd_endyear");

            
            #region save data (Standard)
            Int32 ctr = 0;
            //string RAM_ID = "";

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //ctr = Convert.ToInt32(dr["ctr"].ToString());
                    //RAM_ID = dr["RAM_ID"].ToString();
 
                }
            }
            catch (Exception ex)
            {
                Functions.Log("", ex.InnerException.ToString(), "");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            #endregion

            standardResponse resultclass = new standardResponse();
            resultclass.status = "Saved";
            resultclass.message = "Test";
            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(resultclass);
            return (passresult);
        }

  
    }
    #region classes
 

    public class standardResponse
    {
        public string status;
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
        public static string Form(this  NameValue[] formVars, string name)
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
        public static string[] FormMultiple(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}
