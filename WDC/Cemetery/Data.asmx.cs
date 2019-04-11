﻿using System;
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
using System.IO;
//using System.Text;

//using System.Web.Script.Services;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

namespace Online.Cemetery
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService] //GREG  - NOT NEEDED FOR GETS
    public class Data : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Cemeteries()
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            string strConnString = "Data Source=172.16.5.152;Initial Catalog=Cemetery;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETCemeteries", con);
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
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["CemeteryName"].ToString(),
                            value = dr["CemeteryID"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Areas(string cemetery)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            string strConnString = "Data Source=172.16.5.152;Initial Catalog=Cemetery;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETAreas", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["AreaName"].ToString(),
                            value = dr["AreaID"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

       

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Divisions(string area)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            string strConnString = "Data Source=172.16.5.152;Initial Catalog=Cemetery;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETDivisions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["DivisionName"].ToString(),
                            value = dr["DivisionID"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Plots(string division)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            //String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            string strConnString = "Data Source=172.16.5.152;Initial Catalog=Cemetery;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETPlots", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@DivisionID", SqlDbType.VarChar).Value = division;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["PlotName"].ToString(),
                            value = dr["PlotID"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void Plot(string plotid)
        {

            List<plotClass> plotlist = new List<plotClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETPlot", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@plotid", SqlDbType.VarChar).Value = plotid;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        plotlist.Add(new plotClass
                        {
                            remarks = "",
                            gis = "",
                            person = ""
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
           
            plotlist.Add(new plotClass
            {
                remarks = "Test remarks",
                gis = "Ploted or not",
                person = "1,2,3"
            });

            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(plotlist);

            Context.Response.Write(passresult);
        }


        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SextonDataMatchingReports(string mode)
        {
            List<plotClass> plotlist = new List<plotClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_SextonDataMatching", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        plotlist.Add(new plotClass
                        {
                            cemetery = dr["Cemetery"].ToString(),
                            area = dr["Area"].ToString(),
                            block = dr["Block"].ToString(),
                            division = dr["Division"].ToString(),
                            count = dr["Count"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(plotlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void ArchivistDataMatchingReports(string mode)
        {
            List<plotClass> plotlist = new List<plotClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryArchiveConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_ArchivistDataMatching", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@mode", SqlDbType.VarChar).Value = mode;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        plotlist.Add(new plotClass
                        {
                            cemetery = dr["Cemetery"].ToString(),
                            area = dr["Area"].ToString(),
                            block = dr["Block"].ToString(),
                            division = dr["Division"].ToString(),
                            count = dr["Count"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(plotlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json
        public void Update_PlotLocation(string plotid, string GISID)
        {

            updateresultClass updateresult = new updateresultClass();

            //String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";

            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Update_PlotLocation", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@plotid", SqlDbType.VarChar).Value = plotid;
            cmd.Parameters.Add("@GISID", SqlDbType.VarChar).Value = GISID;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    updateresult.status = dr["status"].ToString();
                    updateresult.message = dr["message"].ToString();
                    updateresult.id = dr["id"].ToString();
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(updateresult));
        }

        #region Sexton
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SextonAreas(string cemetery)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETSextonAreas", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["Label"].ToString(),
                            value = dr["Value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SextonBlocks(string cemetery, string area)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETSextonBlocks", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["Label"].ToString(),
                            value = dr["value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SextonDivisions(string cemetery, string area, string block)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETSextonDivisions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;
            cmd.Parameters.Add("@BlockID", SqlDbType.VarChar).Value = block;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void SextonPlots(string cemetery, string area, string block, string division)
        {
            List<plotClass> plotlist = new List<plotClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETSextonPlots", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;
            cmd.Parameters.Add("@BlockID", SqlDbType.VarChar).Value = block;
            cmd.Parameters.Add("@DivisionID", SqlDbType.VarChar).Value = division;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        plotlist.Add(new plotClass
                        {
                            plotid = dr["plotid"].ToString(),
                            cemetery = dr["cemetery"].ToString(),
                            area = dr["area"].ToString(),
                            block = dr["block"].ToString(),
                            division = dr["division"].ToString(),
                            plot = dr["plot"].ToString(),
                            remarks = dr["remarks"].ToString(),
                            transactiontype = dr["transactiontype"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(plotlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void updatelocationcontrol(string id, string value)
        {

            updateresultClass updateresult = new updateresultClass();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("UpdateLocationControl", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@value", SqlDbType.VarChar).Value = value;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    updateresult.status = dr["status"].ToString();
                    updateresult.message = dr["message"].ToString();
                    updateresult.id = dr["id"].ToString();
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

            JavaScriptSerializer JS = new JavaScriptSerializer();
            Context.Response.Write(JS.Serialize(updateresult));
        }
        #endregion

        #region Genealogist
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GenealogistAreas(string cemetery)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETGenealogistAreas", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["Label"].ToString(),
                            value = dr["Value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GenealogistBlocks(string cemetery, string area)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETGenealogistBlocks", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["Label"].ToString(),
                            value = dr["value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GenealogistDivisions(string cemetery, string area, string block)
        {
            List<dropdownClass> dropdownlist = new List<dropdownClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETGenealogistDivisions", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;
            cmd.Parameters.Add("@BlockID", SqlDbType.VarChar).Value = block;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdownlist.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(dropdownlist);

            Context.Response.Write(passresult);
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void GenealogistPlots(string cemetery, string area, string block, string division)
        {
            List<plotClass> plotlist = new List<plotClass>();

            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("GETGenealogistPlots", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@CemeteryID", SqlDbType.VarChar).Value = cemetery;
            cmd.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = area;
            cmd.Parameters.Add("@BlockID", SqlDbType.VarChar).Value = block;
            cmd.Parameters.Add("@DivisionID", SqlDbType.VarChar).Value = division;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        plotlist.Add(new plotClass
                        {
                            plotid = dr["plotid"].ToString(),
                            cemetery = dr["cemetery"].ToString(),
                            area = dr["area"].ToString(),
                            block = dr["block"].ToString(),
                            division = dr["division"].ToString(),
                            plot = dr["plot"].ToString(),
                            remarks = dr["remarks"].ToString(),
                            transactiontype = dr["transactiontype"].ToString()
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


            JavaScriptSerializer JS = new JavaScriptSerializer();
            string passresult = JS.Serialize(plotlist);

            Context.Response.Write(passresult);
        }
        #endregion

    }

    #region classes
    public class dropdownClass
    {
        public string label;
        public string value;
    }
    public class plotClass
    {
        public string plotid;
        public string cemetery;
        public string area;
        public string block;
        public string division;
        public string plot;
        public string remarks;
        public string transactiontype;
        public string count;
        public string gis;
        public string person;
    }

    public class updateresultClass
    {
        public string status;
        public string message;
        public string id;  //added record
    }
    #endregion  
}