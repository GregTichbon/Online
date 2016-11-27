using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Online.Models;
//using Online.WDCFunctions;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.Configuration;

namespace Online.InvoicePayment
{
    public partial class InvoicePayment : System.Web.UI.Page
    {
        #region Parameters
        public string none = "none"; 

        #endregion

        #region fields
        public string PaymentType;
        public string tb_emailaddress;
        public string hf_ccdetail;
        public string tb_reference1;
        public string tb_reference2;
        public string hf_amount;
        public string hf_transactionfee;
        public string hf_surcharge;
        public string fullamount;
        public string tb_cardnumber;
        public string cardnumber_short;
        public string tb_cardholder;
        public string ddl_expirymonth;
        public string ddl_expiryyear;

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                #region populate
                if (Request.QueryString["populate"] == "True")
                {


                }
                #endregion
            }
        }

        protected void btn_payinvoice_Click(object sender, EventArgs e)
        {
            #region fields
            PaymentType = Request.Form["hf_type"]; 
            tb_emailaddress = Request.Form["tb_emailaddress"].Trim();
            hf_ccdetail = Request.Form["hf_ccdetail"];
            tb_reference1 = Request.Form["tb_reference1"];
            tb_reference2 = Request.Form["tb_reference2"];
            hf_amount = Request.Form["hf_amount"];
            hf_transactionfee = Request.Form["hf_transactionfee"];
            hf_surcharge = Request.Form["hf_surcharge"];
            tb_cardnumber = Request.Form["tb_cardnumber"];
            tb_cardholder = Request.Form["tb_cardholder"];
            ddl_expirymonth = Request.Form["ddl_expirymonth"];
            ddl_expiryyear = Request.Form["ddl_expiryyear"];

            cardnumber_short = tb_cardnumber.Substring(0, 4) + "..." + tb_cardnumber.Substring(tb_cardnumber.Length - 4);
            fullamount = (Convert.ToDecimal(hf_amount) + Convert.ToDecimal(hf_transactionfee) + Convert.ToDecimal(hf_surcharge)).ToString();
            
            #endregion
            
            #region parameters
            string emailBCC = WebConfigurationManager.AppSettings[PaymentType + "Payment.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[PaymentType + "Payment.emailSubject"];

            string screenTemplate = "InvoicePayment\\InvoicePaymentScreen.html";
            string emailbodyTemplate = "InvoicePayment\\InvoicePaymentEmail.html";
            #endregion

            #region CreditCard Process
            //WDCFunctions.WDCFunctions test = new WDCFunctions.WDCFunctions();
            //gw_Result gwresult = test.PXPost(tb_cardholder, tb_cardnumber, Request.Form["hf_amount"], ddl_expirymonth + ddl_expiryyear, "To do Narrative");

            gw_Result gwresult = WDCFunctions.WDCFunctions.PXPost(tb_cardholder, tb_cardnumber, fullamount, ddl_expirymonth + ddl_expiryyear, hf_ccdetail);
            #endregion

            #region setup for database (Standard)
            string paymentreference = WDCFunctions.WDCFunctions.getReference("datetime");

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            #endregion

            #region setup specific data
            cmd.CommandText = "Create_Payment";
            cmd.Parameters.Add("@paymenttype", SqlDbType.VarChar).Value = PaymentType;  //Standard
            cmd.Parameters.Add("@paymentreference", SqlDbType.VarChar).Value = paymentreference;  //Standard
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = "None";  //Standard
            cmd.Parameters.Add("@Entity_CTR", SqlDbType.Int).Value = 0;  //Standard
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = tb_emailaddress;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = hf_ccdetail;
            cmd.Parameters.Add("@reference1", SqlDbType.VarChar).Value = tb_reference1;
            cmd.Parameters.Add("@reference2", SqlDbType.VarChar).Value = tb_reference2;
            cmd.Parameters.Add("@amount", SqlDbType.Money).Value = hf_amount;
            cmd.Parameters.Add("@transactionfee", SqlDbType.Money).Value = hf_transactionfee;
            cmd.Parameters.Add("@surcharge", SqlDbType.Money).Value = hf_surcharge;
            cmd.Parameters.Add("@ccshortnumber", SqlDbType.VarChar).Value = cardnumber_short;
            cmd.Parameters.Add("@cccardholder", SqlDbType.VarChar).Value = tb_cardholder;
            cmd.Parameters.Add("@ccsuccess", SqlDbType.Bit).Value = gwresult.success;
            cmd.Parameters.Add("@ccmessage", SqlDbType.VarChar).Value = gwresult.message;
            cmd.Parameters.Add("@ccreference", SqlDbType.VarChar).Value = gwresult.reference;
            cmd.Parameters.Add("@ccxmloutput", SqlDbType.VarChar).Value = gwresult.xmloutput;

            #endregion

            #region save data (Standard)
            string validation = "";
            string validationinternal = "";
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    validation = dr["validation"].ToString();
                    validationinternal = dr["validationinternal"].ToString();
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

            #endregion

            #region Setup Dictionary Items
            Dictionary<string, string> documentvalues = new Dictionary<string, string>();

            //documentvalues.Add("reference", reference);
            string message = "";
            if (gwresult.success == 1) {
                if (validation == "")
                {
                    message = "Thank you.  Your payment was successful.";
                }
                else
                {
                    message = validation;
                }
            }
            else {
                message = "Your payment was declined. <a href=\"http://wdc.whanganui.govt.nz/invoicepayment/invoicepayment.aspx\">Try again</a>";
            }

            documentvalues.Add("message", "");
            documentvalues.Add("paymentreference", paymentreference);
            documentvalues.Add("emailaddress", tb_emailaddress);
            documentvalues.Add("detail", hf_ccdetail);
            documentvalues.Add("paymenttype", PaymentType);
            documentvalues.Add("reference1", tb_reference1);
            documentvalues.Add("reference2", tb_reference2);
            documentvalues.Add("cccardholder", tb_cardholder);
            documentvalues.Add("ccshortumber", cardnumber_short);
            documentvalues.Add("amount", fullamount);
            //documentvalues.Add("result", "gwresult");

            #endregion

            #region email, redirection, final processing (Standard)
            string path = Server.MapPath(".");

            // THE SUMMARY DISPLAYED ON THE SCREEN
            string screenpath = path + "\\" + screenTemplate;
            string screendocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(screenpath))
                {
                    screendocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
            screendocument = a.documentfill(screendocument, documentvalues);

            //save a copy of formatdocument in submissions
            path = Server.MapPath("..");

            string fullfilename = "";
            int cnt = 0;
            try
            {
                //using (StreamWriter outfile = new StreamWriter(path + "\\submissions\\CommunityContract\\Application\\" + hf_reference.Value + ".html"))


                do
                {
                    cnt = cnt + 1; 
                    fullfilename = path + "\\submissions\\InvoicePayment\\" + paymentreference + "_" + cnt.ToString() + ".html";

                } while (File.Exists(fullfilename));

                using (StreamWriter outfile = new StreamWriter(fullfilename))
                {
                    outfile.Write(screendocument);
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            // THE EMAIL
            path = Server.MapPath(".");
            string emailbodypath = path + "\\" + emailbodyTemplate;
            string emailbodydocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(emailbodypath))
                {
                    emailbodydocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

            //THE EMAIL TEMPLATE
            path = Server.MapPath("..");
            string emailtemplate = path + "\\EmailTemplate\\standard.html";
            string emaildocument = "";

            try
            {
                using (StreamReader sr = new StreamReader(emailtemplate))
                {
                    emaildocument = sr.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                WDCFunctions.WDCFunctions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

            WDCFunctions.WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);

            Session["body"] = screendocument;
            Response.Redirect("../Completed/default.aspx");
            #endregion

        }
    }
}