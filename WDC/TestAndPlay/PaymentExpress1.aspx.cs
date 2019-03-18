using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.TestAndPlay
{
    public partial class PaymentExpress1 : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string xml = @"<Txn>
                        <PostUsername>WhanganuiDC_Dev</PostUsername>
                        <PostPassword>44C56d26</PostPassword>
                        <TxnType>Purchase</TxnType>
                        <InputCurrency>NZD</InputCurrency>
                        <Amount>1.00</Amount>
                        <MerchantReference>My Reference</MerchantReference>
                        <CardNumber>4111111111111111</CardNumber>
                        <DateExpiry>1212</DateExpiry>
                        <CardHolderName>C. Holder</CardHolderName>
                        <TxnData1>Data 1</TxnData1>
                        <TxnData2>Data 2</TxnData2>
                        <TxnData3>Data 3</TxnData3>
                        </Txn>";

            string URI = @"https://uat.paymentexpress.com/pxpost.aspx"; //Use UAT for WhanganuiDC_Dev and SEC for WhanganuiDCDev


            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(URI);
            byte[] bytes;
            bytes = System.Text.Encoding.ASCII.GetBytes(xml);
            request.ContentType = "text/xml; encoding='utf-8'";
            request.ContentLength = bytes.Length;
            request.Method = "POST";
            Stream requestStream = request.GetRequestStream();
            requestStream.Write(bytes, 0, bytes.Length);
            requestStream.Close();
            HttpWebResponse response;
            response = (HttpWebResponse)request.GetResponse();
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Stream responseStream = response.GetResponseStream();
                html = new StreamReader(responseStream).ReadToEnd();
            }

        }
    }
}