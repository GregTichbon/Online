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
using System.Text.RegularExpressions;

namespace Online.Entity
{
    public partial class Entity : System.Web.UI.Page
    {
        #region fields

        public string hf_entity_ctr;
        public string tb_lastname;
        public string tb_firstname;
        public string tb_othernames;
        public string tb_knownas;
        public string tb_residentialaddress;
        public string tb_postaladdress;
        public string tb_emailaddress;
        public string tb_username;
        public string tb_emailconfirm;
        public string tb_mobilephone;
        public string tb_homephone;
        public string tb_workphone;
        public string dd_gender;
        public string dd_gender_value;
        public string tb_dateofbirth;
        public string tb_password;
        #endregion

        public string[] genders = new string[3] { "Female", "Male", "Gender Diverse" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["online_entity_ctr"] != null || Request.QueryString["reference"] != null || Request.QueryString["create"] != null)
                {


                    string wdcscripts = "";
                    if (Request.QueryString["populate"] != null)
                    {
                        wdcscripts += "$.getScript('../scripts/wdc/populate.js');";
                    }
                    if (Request.QueryString["showfields"] != null)
                    {
                        wdcscripts += "$.getScript('../scripts/wdc/showfields.js');";
                    }
                    if (wdcscripts != "")
                    {
                        wdcscripts = "<script type='text/javascript'>" + wdcscripts + "</script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "ConfirmSubmit", wdcscripts);
                    }

                    hf_entity_ctr = "";


                   if (Session["online_entity_ctr"] != null || Request.QueryString["reference"] != null)
                    {
                        String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
                        SqlConnection con = new SqlConnection(strConnString);

                        SqlCommand cmd = new SqlCommand("Get_Entity", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = Request.QueryString["reference"]; //priority
                        cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = Session["online_entity_ctr"];

                        cmd.Connection = con;
                        try
                        {
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.HasRows)
                            {
                                dr.Read();
                                tb_reference.Text = dr["reference"].ToString();
                                hf_entity_ctr = dr["entity_ctr"].ToString();
                                tb_username = dr["username"].ToString();
                                tb_lastname = dr["lastname"].ToString();
                                tb_firstname = dr["firstname"].ToString();
                                tb_othernames = dr["othernames"].ToString();
                                tb_knownas = dr["knownas"].ToString();
                                tb_residentialaddress = dr["residentialaddress"].ToString();
                                tb_postaladdress = dr["postaladdress"].ToString();
                                tb_emailaddress = dr["emailaddress"].ToString();
                                tb_mobilephone = dr["mobilephone"].ToString();
                                tb_homephone = dr["homephone"].ToString();
                                tb_workphone = dr["workphone"].ToString();
                                dd_gender = dr["gender"].ToString();
                                tb_dateofbirth = Convert.ToDateTime(dr["dateofbirth"]).ToString("d MMM yyyy");
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
                    }
                    else
                    {
                        WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();
                        tb_reference.Text = WDCFunctions.getReference();
                    }
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region fields
            hf_entity_ctr = Request.Form["hf_entity_ctr"].Trim();
            tb_username = Request.Form["tb_username"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_othernames = Request.Form["tb_othernames"].Trim();
            tb_knownas = Request.Form["tb_knownas"].Trim();
            tb_residentialaddress = Request.Form["tb_residentialaddress"].Trim();
            tb_postaladdress = Request.Form["tb_postaladdress"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_mobilephone = Request.Form["tb_mobilephone"].Trim();
            tb_homephone = Request.Form["tb_homephone"].Trim();
            tb_workphone = Request.Form["tb_workphone"].Trim();
            dd_gender = Request.Form["dd_gender"];
            tb_dateofbirth = Request.Form["tb_dateofbirth"].Trim();
            tb_password = Request.Form["tb_password"].Trim();
            #endregion  


            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Update_Entity";
            cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = hf_entity_ctr;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@OtherNames", SqlDbType.VarChar).Value = tb_othernames;
            cmd.Parameters.Add("@KnownAs", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@ResidentialAddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            cmd.Parameters.Add("@PostalAddress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@MobilePhone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@HomePhone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@WorkPhone", SqlDbType.VarChar).Value = tb_workphone;
            cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@DateofBirth", SqlDbType.VarChar).Value = tb_dateofbirth;
            cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = tb_password;

            Int32 Entity_CTR = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                //cmd.ExecuteNonQuery();
                Entity_CTR = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                //lblMessage.Text = "Record inserted successfully";
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


            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>(); //standard

            documentvalues.Add("UserName", tb_username);
            documentvalues["LastName"] = tb_lastname;
            documentvalues["FirstName"] = tb_firstname;
            documentvalues["OtherNames"] = tb_othernames;
            documentvalues["KnownAs"] = tb_knownas;
            documentvalues["EmailAddress"] = tb_emailaddress;
            documentvalues["ResidentialAddress"] = tb_residentialaddress;
            documentvalues["PostalAddress"] = tb_postaladdress;
            documentvalues["MobilePhone"] = tb_mobilephone;
            documentvalues["HomePhone"] = tb_homephone;
            documentvalues["WorkPhone"] = tb_workphone;
            documentvalues["Gender"] = dd_gender;
            documentvalues["DateOfBirth"] = tb_dateofbirth;
            #endregion

            #region create Entity HTML document
            string path = Server.MapPath(".");
            string fullpath = path + "\\body.html";
            string bodydocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(fullpath))
                {
                    bodydocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }


            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
            bodydocument = a.documentfill(bodydocument, documentvalues);


            #endregion

            Session["online_entity_ctr"] = @Entity_CTR;
            Session["online_emailaddress"] = tb_emailaddress;
            Session["Entity_Body"] = bodydocument;

            string folder = Request.QueryString["folder"];
            if (folder != null)
            {
                string form = Request.QueryString["form"];
                string redirect = "~/" + folder + "/" + form + ".aspx";

                string rq = "";
                if (Request.QueryString["showfields"] != null)
                {
                    rq += "&showfields=" + Request.QueryString["showfields"];
                }
                if (Request.QueryString["populate"] != null)
                {
                    rq += "&populate=" + Request.QueryString["populate"];
                }

                var regex = new Regex(Regex.Escape("&"));
                rq = regex.Replace(rq, "?", 1);

                Response.Redirect(redirect + rq);
            }
            else
            {
                if (hf_entity_ctr != "")
                {
                    Response.Redirect("Amended.aspx");
                    //Response.Redirect("account.aspx");
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }


        }  //btn_submit_Click END


    }
}