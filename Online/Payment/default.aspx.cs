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


namespace Online.Payment
{
    public partial class _default : System.Web.UI.Page
    {

        int payment_request_ctr = 0;
        string email = "";
        string paymenttype = "";
        string reference1 = "";
        string reference2 = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_reference.Text = Request.QueryString["reference"];
            if (lbl_responsetext.Text == "Invoice Payment")
            {
                email = Session["email"].ToString();
                lbl_detail.Text = Session["detail"].ToString();
                lbl_amount.Text = Session["amount"].ToString();
                paymenttype = Session["paymenttype"].ToString();
                reference1 = Session["reference1"].ToString();
                reference2 = Session["reference2"].ToString();
            } else { 

                String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_Payment_Request", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = lbl_reference.Text;

                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                }
                catch (Exception ex)
                {

                    //TO DO

                }
                finally
                {
                    con.Close();
                }

                dt = ds.Tables[0];

                payment_request_ctr = Convert.ToInt32(dt.Rows[0]["Payment_Request_CTR"]);
                lbl_detail.Text = dt.Rows[0]["detail"].ToString();
                lbl_amount.Text = Convert.ToDecimal(dt.Rows[0]["amount"]).ToString("#,##0.00");
                email = dt.Rows[0]["EmailAddress"].ToString();
            }
 


        }

        protected void btn_pay_Click(object sender, EventArgs e)
        {
            PXPost();
        }

        public void PXPost()
        {
            string ReturnedXML = "";
            string URI = @"https://sec.paymentexpress.com/pxpost.aspx";
            // form the PXPost Xml message
            StringWriter sw = new StringWriter();
            XmlTextWriter xtw = new XmlTextWriter(sw);
            xtw.WriteStartElement("Txn");
            xtw.WriteElementString("PostUsername", "WhanganuiDCDev");   //ANZWDC
            xtw.WriteElementString("PostPassword", "test1234");        //1A5B9A93
            xtw.WriteElementString("CardHolderName", tb_cardholder.Text);
            xtw.WriteElementString("CardNumber", tb_cardnumber.Text);
            xtw.WriteElementString("Amount", lbl_amount.Text);
            xtw.WriteElementString("DateExpiry", ddl_expirymonth.SelectedValue + ddl_expiryyear.SelectedValue);
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

                lbl_todo.Text = "To do: Send email to: " + email;

            }
            // error handling code omitted


            string reference = WDCFunctions.WDCFunctions.getReference();

            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "Add_CreditCard_Transaction";
            cmd.Parameters.Add("@reference", SqlDbType.VarChar).Value = reference.ToString();

            cmd.Parameters.Add("@CC_CardHolder", SqlDbType.VarChar).Value = tb_cardholder.Text.Trim();

            string ccnumber = tb_cardnumber.Text.Trim();
            cmd.Parameters.Add("@CC_ShortNumber", SqlDbType.VarChar).Value = ccnumber.Substring(0, 4) + "..." + ccnumber.Substring(ccnumber.Length - 4, 4);
            cmd.Parameters.Add("@Payment_Request_CTR", SqlDbType.Int).Value = payment_request_ctr;

            cmd.Parameters.Add("@paymenttype", SqlDbType.VarChar).Value = paymenttype;
            cmd.Parameters.Add("@reference1", SqlDbType.VarChar).Value = reference1;
            cmd.Parameters.Add("@reference2", SqlDbType.VarChar).Value = reference2;
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;

            cmd.Parameters.Add("@PaymentExpressResponse", SqlDbType.Xml).Value = ReturnedXML;
            cmd.Parameters.Add("@Success", SqlDbType.VarChar).Value = Success;

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




        }



    }
}