using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace DataInnovations.Row
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    /// GREG [System.Web.Script.Services.ScriptService]    //GREG  - NOT NEEDED FOR GETS
    public class data : System.Web.Services.WebService
    {

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void discipline()
        {
            List<dropdownClass> dropdown = new List<dropdownClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_discipline_DD", con);
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
                        dropdown.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void boat(string discipline)
        {
            List<dropdownClass> dropdown = new List<dropdownClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_boat_DD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@discipline_ctr", SqlDbType.Int).Value = discipline;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdown.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void division(string discipline, string boat)
        {
            List<dropdownClass> dropdown = new List<dropdownClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Division_DD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Add("@discipline_ctr", SqlDbType.Int).Value = discipline;
            cmd.Parameters.Add("@discipline_ctr", SqlDbType.Int).Value = discipline;
            cmd.Parameters.Add("@boat_ctr", SqlDbType.Int).Value = boat;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdown.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void gender(string discipline, string boat, string division)
        {
            List<dropdownClass> dropdown = new List<dropdownClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_gender_DD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@discipline_ctr", SqlDbType.Int).Value = discipline;
            cmd.Parameters.Add("@boat_ctr", SqlDbType.Int).Value = boat;
            cmd.Parameters.Add("@division_ctr", SqlDbType.Int).Value = division;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdown.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void prognostic(string discipline, string boat, string division, string gender)
        {
            List<prognosticClass> dropdown = new List<prognosticClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_prognostic", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@discipline_ctr", SqlDbType.Int).Value = discipline;
            cmd.Parameters.Add("@boat_ctr", SqlDbType.Int).Value = boat;
            cmd.Parameters.Add("@division_ctr", SqlDbType.Int).Value = division;
            cmd.Parameters.Add("@gender_ctr", SqlDbType.Int).Value = gender;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdown.Add(new prognosticClass
                        {
                            prognostic_ctr = dr["prognostic_ctr"].ToString(),
                            description = dr["description"].ToString(),
                            code = dr["code"].ToString(),
                            seats = dr["seats"].ToString(),
                            coxed = dr["coxed"].ToString(),
                            prognostictime = dr["prognostictime"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void subcategorydetails(string subcategory)
        {
            List<subcategorydetailsClass> subcategorydetails = new List<subcategorydetailsClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_subcategorydetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@subcategory_ctr", SqlDbType.Int).Value = subcategory;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        subcategorydetails.Add(new subcategorydetailsClass
                        {
                            category_ctr = dr["category_ctr"].ToString(),
                            seats = dr["seats"].ToString(),
                            coxed = dr["coxed"].ToString(),
                            prognostictime = dr["prognostictime"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(subcategorydetails));
        }
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void subcategoryotherprognostics(string category, string prognostictime)
        {
            List<dropdownClass> dropdown = new List<dropdownClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_subcategoryotherprognostics", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@category_ctr", SqlDbType.Int).Value = category;
            cmd.Parameters.Add("@prognostictime", SqlDbType.Decimal).Value = prognostictime;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        dropdown.Add(new dropdownClass
                        {
                            label = dr["label"].ToString(),
                            value = dr["value"].ToString()
                        });
                    }
                }
                dr.Close();
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
            Context.Response.Write(JS.Serialize(dropdown));
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void code_autocomplete(string term)
        {
            List<CodeClass> CodeList = new List<CodeClass>();

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("code_autocomplete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@search", SqlDbType.VarChar).Value = term;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        CodeList.Add(new CodeClass
                        {
                            Code_CTR = dr["code_ctr"].ToString(),
                            name = dr["code"].ToString(),
                            label = dr["code"].ToString()
                        });
                    }

                    dr.Close();
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
            Context.Response.Write(JS.Serialize(CodeList));
        }
    }
    #region classes

    public class dropdownClass
    {
        public string label;
        public string value;
    }

    public class prognosticClass
    {
        public string prognostic_ctr;
        public string description;
        public string code;
        public string seats;
        public string coxed;
        public string prognostictime;
    }
    public class subcategorydetailsClass
    {
        public string category_ctr;
        public string seats;
        public string coxed;
        public string prognostictime;
    }
    public class CodeClass
    {
        public string Code_CTR;
        public string name;
        public string label;

    }

    #endregion
}
