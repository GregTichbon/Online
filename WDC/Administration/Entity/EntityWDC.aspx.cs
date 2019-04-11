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

namespace Online.Administration.Entity
{
    public partial class EntityWDC : System.Web.UI.Page
    {
        #region fields

        public string hf_entity_ctr;
        public string tb_lastname;
        public string tb_firstname;
        public string tb_othernames;
        public string tb_knownas;
        public string tb_emailaddress;
        public string tb_username;
        public string tb_emailconfirm;
        public string tb_password;
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["online_entity_ctr"] != null)
                {
                    String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;

                    WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

                    //string authorised = "Yes";
                    string[,] authorisations = WDCFunctions.getWDCAccess(strConnString, "WDC","Entity Control", Session["online_entity_ctr"].ToString());


                    Boolean do_me = false;
                    /*
                     if(authorised != "Yes" && Request.QueryString["reference"] == null && Request.QueryString["create"] == null)
                    {
                        do_me = true;
                    }
                    */

                    //Has to be a Session["online_entity_ctr"]
                    //Will need a way to be able to reset passwords for the user to action
                    //if I am an admin person and I'm not providing a reference or "create"; take me to a menu offering these options
                    if (Request.QueryString["reference"] != null || Request.QueryString["create"] != null || do_me)
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
                    } else
                    {
                        Response.Redirect("menu.aspx");
                    }

                    hf_entity_ctr = "";

                    if (Request.QueryString["reference"] != null || (Session["online_entity_ctr"] != null && do_me))
                    {
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
                                tb_emailaddress = dr["emailaddress"].ToString();
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
                    else //Creating
                    {
                        tb_reference.Text = WDCFunctions.getReference();
                    }
                }
                else
                {
                    Response.Redirect("../../entity/login.aspx?folder=administration/entity&form=entitywdc");
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            #region fields
            hf_entity_ctr = Request.Form["hf_entity_ctr"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_username = Request.Form["tb_username"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_othernames = Request.Form["tb_othernames"].Trim();
            tb_knownas = Request.Form["tb_knownas"].Trim();

            tb_password = Request.Form["tb_password"].Trim();
            #endregion  


            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Update_EntityWDC";
            cmd.Parameters.Add("@entity_ctr", SqlDbType.VarChar).Value = hf_entity_ctr;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@LastName", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@OtherNames", SqlDbType.VarChar).Value = tb_othernames;
            cmd.Parameters.Add("@KnownAs", SqlDbType.VarChar).Value = tb_knownas;
            cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = tb_emailaddress;
            /*
            cmd.Parameters.Add("@ResidentialAddress", SqlDbType.VarChar).Value = tb_residentialaddress;
            cmd.Parameters.Add("@PostalAddress", SqlDbType.VarChar).Value = tb_postaladdress;
            cmd.Parameters.Add("@MobilePhone", SqlDbType.VarChar).Value = tb_mobilephone;
            cmd.Parameters.Add("@HomePhone", SqlDbType.VarChar).Value = tb_homephone;
            cmd.Parameters.Add("@WorkPhone", SqlDbType.VarChar).Value = tb_workphone;
            cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = dd_gender;
            cmd.Parameters.Add("@DateofBirth", SqlDbType.VarChar).Value = tb_dateofbirth;
            */
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


            Response.Redirect("menu.aspx");
        }
    }
}