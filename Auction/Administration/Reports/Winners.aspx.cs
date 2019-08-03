using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction.Administration.Reports
{
    public partial class Winners : System.Web.UI.Page
    {
        public string html = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            double amount = 0;
            double autobid = 0;
            double reserve = 0;
            double retailprice = 0;
            double willgoto = 0;
            double totalretail = 0;
            double totalreserve = 0;
            double totalbid = 0;

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Winners", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //Title, RetailPrice, Reserve, Amount, autobid,	WillGoTo, ReserveStatus, response, Fullname, EmailAddress, MobileNumber
                        string title = dr["Title"].ToString();
                        string retailpricetext = dr["retailprice"].ToString();
                        if (retailpricetext != "")
                        {
                            retailprice = Convert.ToDouble(retailpricetext);
                        }
                        else
                        {
                            retailprice = 0;
                        }
                        string reservetext = dr["reserve"].ToString();
                        if (reservetext != "")
                        {
                            reserve = Convert.ToDouble(reservetext);
                        }
                        else
                        {
                            reserve = 0;
                        }
                        string amounttext = dr["amount"].ToString();
                        if (amounttext != "")
                        {
                            amount = Convert.ToDouble(amounttext);
                        }
                        else
                        {
                            amount = 0;
                        }
                        string autobidtext = dr["autobid"].ToString();
                        if (autobidtext != "")
                        {
                            autobid = Convert.ToDouble(autobidtext);
                        }
                        else
                        {
                            autobid = 0;
                        }
                        string willgototext = dr["willgoto"].ToString();
                        if (willgototext != "")
                        {
                            willgoto = Convert.ToDouble(willgototext);
                        }
                        else
                        {
                            willgoto = 0;
                        }
                        string reservestatus = dr["reservestatus"].ToString();
                        string fullname = dr["Fullname"].ToString();
                        string emailaddress = dr["EmailAddress"].ToString();
                        string mobilenumber = dr["MobileNumber"].ToString();

                        totalretail += retailprice;
                        totalreserve += reserve;
                        totalbid += amount;

                        //Title, RetailPrice, Reserve, Amount, autobid,	WillGoTo, ReserveStatus, response, Fullname, EmailAddress, MobileNumber
                        html += "<tr><td>" + title + "</td>" +
                            "<td class=\"numeric\">" + retailprice.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + reserve.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + amount.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + autobid.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + willgoto.ToString("0.00") + "</td>" +
                            "<td>" + reservestatus + "</td>" +
                            "<td>" + fullname + "</td>" +
                            "<td>" + emailaddress + "</td>" +
                            "<td>" + mobilenumber + "</td></tr>";


                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Close();
                con.Close();
                con.Dispose();
            }

            html += "<tr><td>Total</td>" +
                            "<td class=\"numeric\">" + totalretail.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + totalreserve.ToString("0.00") + "</td>" +
                            "<td class=\"numeric\">" + totalbid.ToString("0.00") + "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td></tr>";
        }
    }
}