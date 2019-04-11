using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;
using System.Net;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Specialized;



namespace Online.Payment
{
    public partial class _default : System.Web.UI.Page
    {

        public string paymentrequestreference;
        public string amount;
        public string detail;
        public string surcharge;
        public string transactionfee;


        protected void Page_Load(object sender, EventArgs e)
        {
            WDCFunctions.WDCFunctions functions = new WDCFunctions.WDCFunctions();
            paymentrequestreference = Request.QueryString["reference"];
            
            if(paymentrequestreference is null) {

                paymentrequestreference = "Test1";

                //paymentrequestreference = "91545cb3-f3b7-4262-a25d-92f106f70fca"; 
            }
            

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Payment_Request", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = paymentrequestreference;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    detail = dr["detail"].ToString();
                    amount = dr["amount"].ToString();
                    surcharge = dr["surcharge"].ToString();
                    transactionfee = dr["transactionfee"].ToString();

                }
            }
            catch (Exception ex)
            {
                functions.Log(Request.RawUrl, ex.Message, "greg.tichbon@whanganui.govt.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }


            

        }
        #region oldcode
        /*
        protected void btn_pay_Click(object sender, EventArgs e)
        {
            PXPost(Request.Form);
        }

        public void PXPost(NameValueCollection form)
        {
            WDCFunctions.WDCFunctions WDCFunctions = new WDCFunctions.WDCFunctions();

            string ReturnedXML = "";
            string URI = @"https://sec.paymentexpress.com/pxpost.aspx";
            // form the PXPost Xml message
            StringWriter sw = new StringWriter();
            XmlTextWriter xtw = new XmlTextWriter(sw);
            xtw.WriteStartElement("Txn");
            xtw.WriteElementString("PostUsername", "WhanganuiDCDev");   //ANZWDC
            xtw.WriteElementString("PostPassword", "test1234");        //1A5B9A93
            xtw.WriteElementString("CardHolderName", form["tb_cardholder"]);
            xtw.WriteElementString("CardNumber", form["tb_cardnumber"]);
            xtw.WriteElementString("Amount", lbl_amount.Text);
            xtw.WriteElementString("DateExpiry", form["ddl_expirymonth"] + form["ddl_expiryyear"]);
            xtw.WriteElementString("Cvc2", "");
            xtw.WriteElementString("InputCurrency", "NZD");
            xtw.WriteElementString("TxnType", "Purchase");
            xtw.WriteElementString("TxnId", "");
            xtw.WriteElementString("MerchantReference", "This is a test transaction");
            xtw.WriteElementString("TxnData1", "This is optional data, there are 3 fields");
            //xtw.WriteElementString("TxnData2", "");
            //xtw.WriteElementString("TxnData3", "");
            xtw.WriteEndElement();
            xtw.Close();
            // Send the Xml message to PXPost
            WebRequest wrq = WebRequest.Create(URI);
            wrq.Method = "POST";
            wrq.ContentType = "application/x-www-form-urlencoded";
            byte[] b = Encoding.ASCII.GetBytes(sw.ToString());
            wrq.ContentLength = b.Length;
            Stream s = wrq.GetRequestStream();
            s.Write(b, 0, b.Length);
            s.Close();
            // Check the response
            WebResponse wrs = wrq.GetResponse();
            string Success = "";
            if (wrs != null)
            {
                StreamReader sr = new StreamReader(wrs.GetResponseStream());
                XmlDocument xd = new XmlDocument();
                xd.LoadXml(sr.ReadToEnd().Trim());
                if (xd.SelectSingleNode("/Txn/Success") != null)
                {
                    lbl_reco.Text = xd.SelectSingleNode("/Txn/ReCo").InnerText;
                    Success = xd.SelectSingleNode("/Txn/Success").InnerText;
                }

                lbl_responsetext.Text = xd.SelectSingleNode("/Txn/ResponseText").InnerText;
                lbl_helptext.Text = xd.SelectSingleNode("/Txn/HelpText").InnerText;
                //Some response elements are in different nodes
                lbl_authorized.Text = xd.SelectSingleNode("/Txn/Transaction/Authorized").InnerText;
                lbl_dpstxnref.Text = xd.SelectSingleNode("/Txn/Transaction/DpsTxnRef").InnerText;
                lbl_authcode.Text = xd.SelectSingleNode("/Txn/Transaction/AuthCode").InnerText;
                // further error handling code could go here

                ReturnedXML = xd.OuterXml;

                lbl_todo.Text = "To do: Send email to: " + emailaddress;

            }
            // error handling code omitted


            string reference = WDCFunctions.getReference();

            String strConnString = ConfigurationManager.ConnectionStrings["PROnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Add_CreditCard_Transaction";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference.ToString();

            cmd.Parameters.Add("@CCCardHolder", SqlDbType.VarChar).Value = form["tb_cardholder"];

            string ccnumber = form["tb_cardnumber"];
            cmd.Parameters.Add("@CCShortNumber", SqlDbType.VarChar).Value = ccnumber.Substring(0, 4) + "..." + ccnumber.Substring(ccnumber.Length - 4, 4);
            cmd.Parameters.Add("@Payment_Request_CTR", SqlDbType.Int).Value = payment_request_ctr;
            cmd.Parameters.Add("@detail", SqlDbType.VarChar).Value = "";

            cmd.Parameters.Add("@amount", SqlDbType.Money).Value = 0;
            cmd.Parameters.Add("@transactionfee", SqlDbType.Money).Value = 0;
            cmd.Parameters.Add("@surcharge", SqlDbType.Money).Value = 0;

            cmd.Parameters.Add("@paymenttype", SqlDbType.VarChar).Value = paymenttype;
            cmd.Parameters.Add("@reference1", SqlDbType.VarChar).Value = reference1;
            cmd.Parameters.Add("@reference2", SqlDbType.VarChar).Value = reference2;
            cmd.Parameters.Add("@emailaddress", SqlDbType.VarChar).Value = emailaddress;

            cmd.Parameters.Add("@ccsuccess", SqlDbType.VarChar).Value = Success;

            cmd.Parameters.Add("@ccmessage", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@ccreference", SqlDbType.VarChar).Value = "";

            cmd.Parameters.Add("@ccxmloutput", SqlDbType.Xml).Value = ReturnedXML;

            Int32 @ctr = 0;

            cmd.Connection = con;
            try
            {
                con.Open();
                @ctr = Convert.ToInt32(cmd.ExecuteScalar().ToString());
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

           // {"Cannot insert the value NULL into column 'paymentreference', table 'OnlineApplications.dbo.CreditCard_Transaction'; column does not allow nulls. INSERT fails.\r\nThe statement has been terminated."}


        }
        */
        #endregion //oldcode
    }
}