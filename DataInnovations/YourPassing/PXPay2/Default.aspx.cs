using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using System.Reflection;
using PaymentExpress.PxPay;

namespace DataInnovations.YourPassing.PXPay2
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Determine if the page request is for a user returning from the payment page

            string ResultQs = Request.QueryString["result"];

            if (!string.IsNullOrEmpty(ResultQs))
            {
                string PxPayUserId = "WhanganuiDC_Dev"; // ConfigurationManager.AppSettings["PxPayUserId"];
                string PxPayKey = "44C56d26"; // ConfigurationManager.AppSettings["PxPayKey"];

                //        WhanganuiDC_Dev    44C56d26
                //        WanganuiDCDev    1A5B9A93   test1234
 

                // Obtain the transaction result
                PxPay WS = new PxPay(PxPayUserId, PxPayKey);

                ResponseOutput output = WS.ProcessResponse(ResultQs);

                // Write all the name value pairs out to a table

                Table t = new Table();
                TableRow tr;
                TableCell tc;

                PropertyInfo[] properties = output.GetType().GetProperties();

                foreach (PropertyInfo oPropertyInfo in properties)
                {

                    if (oPropertyInfo.CanRead)
                    {

                        tr = new TableRow();
                        tc = new TableCell();

                        tc.Text = oPropertyInfo.Name;
                        tr.Cells.Add(tc);

                        tc = new TableCell();
                        tc.Text = (string)oPropertyInfo.GetValue(output, null);
                        tr.Cells.Add(tc);

                        t.Rows.Add(tr);

                    }
                }

                Panel1.Controls.Add(t);

                // Sending invoices/updating order status within database etc.

                if (!isProcessed(output.TxnId) && output.valid == "1" && output.Success == "1")
                {
                    // TODO: Send emails, generate invoices, update order status etc.
                }
            }
        }

        /// <summary>
        /// Database lookup to check the status of the order or shopping cart
        /// </summary>
        /// <param name="TxnId"></param>
        /// <returns></returns>
        protected bool isProcessed(string TxnId)
        {
            // TODO: Check database if order relating to TxnId has alread been processed
            return false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string PxPayUserId = "WanganuiDCDev"; // ConfigurationManager.AppSettings["PxPayUserId"];
            string PxPayKey = "1A5B9A93"; // ConfigurationManager.AppSettings["PxPayKey"];

            //        WhanganuiDC_Dev    44C56d26
            //        WanganuiDCDev    1A5B9A93   test1234

            PxPay WS = new PxPay(PxPayUserId, PxPayKey);

            RequestInput input = new RequestInput();

            input.AmountInput = txtAmountInput.Text;
            input.CurrencyInput = txtCurrencyInput.Text;
            input.MerchantReference = txtMerchantReference.Text;
            input.TxnType = ddlTxnType.Text;
            input.UrlFail = Request.Url.GetLeftPart(UriPartial.Path);
            input.UrlSuccess = Request.Url.GetLeftPart(UriPartial.Path);

            // TODO: GUID representing unique identifier for the transaction within the shopping cart (normally would be an order ID or similar)
            Guid orderId = Guid.NewGuid();
            input.TxnId = orderId.ToString().Substring(0, 16);

            RequestOutput output = WS.GenerateRequest(input);

            var props = output.GetType().GetProperties();
            foreach (var p in props)
            {
                Response.Write(p.Name + ": " + p.GetValue(output, null) + "<br />");
            }

            if (output.valid == "1")
            {
                // Redirect user to payment page

                Response.Redirect(output.Url);
            }
        }
    }
}