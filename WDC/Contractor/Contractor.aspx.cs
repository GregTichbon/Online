using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Contractor
{
    public partial class Contractor : System.Web.UI.Page
    {
        #region fields

        public string hf_contractor_ctr;
        public string tb_name;
        public string tb_address;
        public string tb_contactperson;
        public string tb_emailaddress;
        public string tb_username;
        public string tb_emailconfirm;
        public string tb_officephone;
        public string tb_altphone;
        public string tb_password;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["online_contractor_ctr"] != null || Request.QueryString["reference"] != null || Request.QueryString["create"] != null)
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

                    hf_contractor_ctr = "";


                    if (Session["online_contractor_ctr"] != null || Request.QueryString["reference"] != null)
                    {
                        String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
                        SqlConnection con = new SqlConnection(strConnString);

                        SqlCommand cmd = new SqlCommand("Get_Contractor", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = Request.QueryString["reference"]; //priority
                        cmd.Parameters.Add("@contractor_ctr", SqlDbType.VarChar).Value = Session["online_contractor_ctr"];

                        cmd.Connection = con;
                        try
                        {
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.HasRows)
                            {
                                dr.Read();
                                tb_reference.Text = dr["reference"].ToString();
                                hf_contractor_ctr = dr["contractor_ctr"].ToString();
                                tb_username = dr["username"].ToString();
                                tb_name = dr["name"].ToString();
                                tb_emailaddress = dr["emailaddress"].ToString();
                                tb_contactperson = dr["contactperson"].ToString();
                                tb_address = dr["address"].ToString();
                                tb_officephone = dr["officephone"].ToString();
                                tb_altphone = dr["altphone"].ToString();
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
            hf_contractor_ctr = Request.Form["hf_contractor_ctr"].Trim();
            tb_username = Request.Form["tb_username"].Trim();
            tb_name = Request.Form["tb_name"].Trim();
            tb_contactperson = Request.Form["tb_contactperson"].Trim();
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            tb_address = Request.Form["tb_address"].Trim();
            tb_officephone = Request.Form["tb_officephone"].Trim();
            tb_altphone = Request.Form["tb_altphone"].Trim();
            tb_password = Request.Form["tb_password"].Trim();
            #endregion  


            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Update_Contractor";
            cmd.Parameters.Add("@contractor_ctr", SqlDbType.VarChar).Value = hf_contractor_ctr;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = tb_reference.Text;
            cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = tb_username;
            cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = tb_name;
            cmd.Parameters.Add("@ContactPerson", SqlDbType.VarChar).Value = tb_contactperson;
            cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = tb_address;
            cmd.Parameters.Add("@officephone", SqlDbType.VarChar).Value = tb_officephone;
            cmd.Parameters.Add("@altphone", SqlDbType.VarChar).Value = tb_altphone;
            cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = tb_password;

            Int32 contractor_CTR = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                //cmd.ExecuteNonQuery();
                contractor_CTR = Convert.ToInt32(cmd.ExecuteScalar().ToString());
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
            documentvalues.Add("reference", tb_reference.Text);
            //documentvalues.Add("UserName", tb_username);
            //documentvalues["Name"] = tb_name;
            //documentvalues["EmailAddress"] = tb_emailaddress;
            //documentvalues["Address"] = tb_emailaddress;
            #endregion

            #region create Contractor HTML document
            string path = Server.MapPath(".");
            string fullpath = path + "\\contractorscreen.html";
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
            //bodydocument = a.documentfill(bodydocument, documentvalues);
            bodydocument = a.documentfillwithRF(bodydocument, documentvalues, Request.Form);



            #endregion

            Session["online_contractor_ctr"] = @contractor_CTR;
            Session["online_contractoremailaddress"] = tb_emailaddress;
            Session["contractor_Body"] = bodydocument;

            /*
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
                if (hf_contractor_ctr != "")
                {
                    Response.Redirect("Amended.aspx");
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }
            */
            Response.Redirect("Amended.aspx");

        }  //btn_submit_Click END


    }
}