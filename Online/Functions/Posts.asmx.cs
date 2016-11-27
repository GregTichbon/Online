using System;
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
using System.Text;

using System.Web.Script.Services;
using System.Web.Configuration;
using Online.Models;
using System.IO;

//using System.Net;
//using System.Net.Http;
//using System.Net.Http.Formatting;

namespace Online.posts
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS

    public class Posts : System.Web.Services.WebService
    {
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string TestMethodPost(NameValue[] formVars)    //you can't pass any querystring params
        {
            string mode = "xList";
            if (mode == "List")
            {
                List<TestList> resultlist = new List<TestList>();

                resultlist.Add(new TestList
                {
                    id = formVars.Form("Text1"),
                    value = "Brown"
                });
                resultlist.Add(new TestList
                {
                    id = "2",
                    value = "Black"
                });
                resultlist.Add(new TestList
                {
                    id = "3",
                    value = "Blue"
                });
                resultlist.Add(new TestList
                {
                    id = "4",
                    value = "Red"
                });
                resultlist.Add(new TestList
                {
                    id = "5",
                    value = "White"
                });

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultlist);

                return (passresult);

            }
            else
            {
                TestClass resultclass = new TestClass();

                resultclass.id = formVars.Form("Text1");

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                return (passresult);
            }
        }

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string InvoicePayment(NameValue[] formVars)    //you can't pass any querystring params
        {
            #region fields
            string PaymentType = formVars.Form("hf_type");
            string tb_emailaddress = formVars.Form("tb_emailaddress");
            string hf_ccdetail = formVars.Form("hf_ccdetail");
            string tb_reference1 = formVars.Form("tb_reference1");
            string tb_reference2 = formVars.Form("tb_reference2");
            string hf_amount = formVars.Form("hf_amount");
            string hf_transactionfee = formVars.Form("hf_transactionfee");
            string hf_surcharge = formVars.Form("hf_surcharge");
            string tb_cardnumber = formVars.Form("tb_cardnumber");
            string tb_cardholder = formVars.Form("tb_cardholder");
            string fullamount = formVars.Form("fullamount");
            string ddl_expirymonth = formVars.Form("ddl_expirymonth");
            string ddl_expiryyear = formVars.Form("ddl_expiryyear");

            string cardnumber_short = tb_cardnumber.Substring(0, 4) + "..." + tb_cardnumber.Substring(tb_cardnumber.Length - 4);
            fullamount = (Convert.ToDecimal(hf_amount) + Convert.ToDecimal(hf_transactionfee) + Convert.ToDecimal(hf_surcharge)).ToString();
            #endregion

            #region CreditCard Process
            gw_Result gwresult = WDCFunctions.WDCFunctions.PXPost(tb_cardholder, tb_cardnumber, fullamount, ddl_expirymonth + ddl_expiryyear, hf_ccdetail);
            #endregion

            #region parameters
            string emailBCC = WebConfigurationManager.AppSettings[PaymentType + "Payment.emailBCC"];
            string emailSubject = WebConfigurationManager.AppSettings[PaymentType + "Payment.emailSubject"];

            string screenTemplate = "InvoicePayment\\InvoicePaymentScreen.html";
            string emailbodyTemplate = "InvoicePayment\\InvoicePaymentEmail.html";
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
            if (gwresult.success == 1)
            {
                if (validation == "")
                {
                    message = "Thank you.  Your payment was successful.";
                }
                else
                {
                    message = validation;
                }
            }
            else
            {
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
            string path = Server.MapPath("~");

            // THE SUMMARY DISPLAYED ON THE SCREEN
            string screenpath = path + screenTemplate;
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
                WDCFunctions.WDCFunctions.Log("Posts.asmx/InvoicePayment", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            WDCFunctions.WDCFunctions a = new WDCFunctions.WDCFunctions();
            screendocument = a.documentfill(screendocument, documentvalues);

            //save a copy of formatdocument in submissions

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
                WDCFunctions.WDCFunctions.Log("Posts.asmx/InvoicePayment", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            // THE EMAIL

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
                WDCFunctions.WDCFunctions.Log("Posts.asmx/InvoicePayment", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            emailbodydocument = a.documentfill(emailbodydocument, documentvalues);

            //THE EMAIL TEMPLATE

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
                WDCFunctions.WDCFunctions.Log("Posts.asmx/InvoicePayment", ex.Message, "greg.tichbon@whanganui.govt.nz");
            }

            emaildocument = emaildocument.Replace("||Content||", emailbodydocument);

            WDCFunctions.WDCFunctions.sendemail(emailSubject, emaildocument, tb_emailaddress, emailBCC);

            //Session["body"] = screendocument;
            #endregion











                TestClass resultclass = new TestClass();

                resultclass.id = formVars.Form("tb_emailaddress");

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                return (passresult);

        }

        

    }

    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class TestClass
    {
        public string id;
    }

    public class TestList
    {
        public string id;
        public string value;
    }
    #endregion

    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}


