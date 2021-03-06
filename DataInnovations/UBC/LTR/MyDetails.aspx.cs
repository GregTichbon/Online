﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.UBC.LTR
{
    public partial class MyDetails : System.Web.UI.Page
    {
        public string hf_guid;
        public string tb_firstname;
        public string tb_lastname;
        public string tb_email;
        public string tb_mobile;
        public string tb_landline;
        public string tb_school;
        public string tb_schoolyear;
        public string tb_caregivername;
        public string tb_caregiveremail;
        public string tb_caregivermobile;
        public string tb_caregiverlandline;
        public string dd_coming;

        public string[] coming = new string[4] { "Yes", "Not all days", "Unsure", "Not at this stage" };

        protected void Page_Load(object sender, EventArgs e)
        {
            hf_guid = Request.QueryString["id"];

            string strConnString = "Data Source=toh-app;Initial Catalog=datainnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "get_ltr";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;


            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    tb_firstname = dr["firstname"].ToString();
                    tb_lastname = dr["lastname"].ToString();
                    tb_email = dr["email"].ToString();
                    tb_mobile = dr["mobile"].ToString();
                    tb_landline = dr["landline"].ToString();
                    tb_school = dr["school"].ToString();
                    tb_schoolyear = dr["schoolyear"].ToString();
                    tb_caregivername = dr["caregivername"].ToString();
                    tb_caregiveremail = dr["caregiveremail"].ToString();
                    tb_caregivermobile = dr["caregivermobile"].ToString();
                    tb_caregiverlandline = dr["caregiverlandline"].ToString();
                    dd_coming = dr["coming"].ToString();

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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string strConnString = "Data Source=toh-app;Initial Catalog=datainnovations;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            #region fields
            hf_guid = Request.Form["hf_guid"].Trim();
            tb_firstname = Request.Form["tb_firstname"].Trim();
            tb_lastname = Request.Form["tb_lastname"].Trim();
            tb_email = Request.Form["tb_email"].Trim();
            tb_mobile = Request.Form["tb_mobile"].Trim();
            tb_landline = Request.Form["tb_landline"].Trim();
            tb_school = Request.Form["tb_school"].Trim();
            tb_schoolyear = Request.Form["tb_schoolyear"].Trim();
            tb_caregivername = Request.Form["tb_caregivername"].Trim();
            tb_caregiveremail = Request.Form["tb_caregiveremail"].Trim();
            tb_caregivermobile = Request.Form["tb_caregivermobile"].Trim();
            tb_caregiverlandline = Request.Form["tb_caregiverlandline"].Trim();
            dd_coming = Request.Form["dd_coming"];
            #endregion

            #region setup specific data
            cmd.CommandText = "Update_LTR";
            cmd.Parameters.Add("@guid", SqlDbType.VarChar).Value = hf_guid;

            cmd.Parameters.Add("@firstname", SqlDbType.VarChar).Value = tb_firstname;
            cmd.Parameters.Add("@lastname", SqlDbType.VarChar).Value = tb_lastname;
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = tb_email;
            cmd.Parameters.Add("@mobile", SqlDbType.VarChar).Value = tb_mobile;
            cmd.Parameters.Add("@landline", SqlDbType.VarChar).Value = tb_landline;
            cmd.Parameters.Add("@school", SqlDbType.VarChar).Value = tb_school;
            cmd.Parameters.Add("@schoolyear", SqlDbType.VarChar).Value = tb_schoolyear;
            cmd.Parameters.Add("@caregivername", SqlDbType.VarChar).Value = tb_caregivername;
            cmd.Parameters.Add("@caregiveremail", SqlDbType.VarChar).Value = tb_caregiveremail;
            cmd.Parameters.Add("@caregivermobile", SqlDbType.VarChar).Value = tb_caregivermobile;
            cmd.Parameters.Add("@caregiverlandline", SqlDbType.VarChar).Value = tb_caregiverlandline;
            cmd.Parameters.Add("@coming", SqlDbType.VarChar).Value = dd_coming;
            #endregion

            cmd.Connection = con;
            try
            {
                con.Open();
                string result = cmd.ExecuteScalar().ToString();
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
    }
}