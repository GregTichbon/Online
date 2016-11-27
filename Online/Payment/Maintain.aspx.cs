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
using System.Web.Configuration;
using System.Diagnostics;

namespace Online.Payment
{
    public partial class Maintain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hf_ctr.Value = Request.QueryString["ctr"];
                hf_tablename.Value = Request.QueryString["tablename"];
                hf_mode.Value = Request.QueryString["mode"];

                if (hf_mode.Value == "1") {
                    PanelMode1.Visible = true;
                    PanelMode2.Visible = false;
                }
                else if (hf_mode.Value == "2")
                {
                    PanelMode1.Visible = false;
                    PanelMode2.Visible = true; 
                }

                if (hf_tablename.Value == "HealthPremiseRegistration")
                {
                    tb_moduledescription.Text = "Health Premise Registration Application";
                }

                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "Get_HealthApplication";
                cmd.Parameters.Add("@tablename", SqlDbType.VarChar).Value = hf_tablename.Value;
                cmd.Parameters.Add("@ctr", SqlDbType.BigInt).Value = hf_ctr.Value;

                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();
                        tb_reference.Text = dr["reference"].ToString();
                        hf_entity.Value = dr["Entity_ctr"].ToString();
                        tb_detail.Text = dr["PremiseName"].ToString();
                    }
                    dr.Close();
                    dr.Dispose();
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;

            string paymentreference = WDCFunctions.WDCFunctions.getReference();

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Add_Payment_Request";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = paymentreference;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = tb_moduledescription.Text + ": " + tb_detail.Text + " " + tb_additionaldetail.Text;
            cmd.Parameters.Add("@amount", SqlDbType.Money).Value = tb_amount.Text;
            cmd.Parameters.Add("@Entity_ctr", SqlDbType.Int).Value = hf_entity.Value;
            cmd.Parameters.Add("@tablename", SqlDbType.VarChar).Value = hf_tablename.Value;
            cmd.Parameters.Add("@invoiceyear", SqlDbType.VarChar).Value = Request.Form["tb_invoiceyear"];
            cmd.Parameters.Add("@invoicenumber", SqlDbType.VarChar).Value = Request.Form["tb_invoicenumber"];
            cmd.Parameters.Add("@ctr", SqlDbType.Int).Value = hf_ctr.Value;

            cmd.Connection = con;
            try
            {
                con.Open();
                int ctr = Convert.ToInt32(cmd.ExecuteScalar().ToString());
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