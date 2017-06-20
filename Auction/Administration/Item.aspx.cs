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

namespace Auction.Administration
{
    public partial class Item : System.Web.UI.Page
    {
        public string item_ctr;
        //public string All;
        public string title;
        public string description;
        public string auctiontype;
        public string reserve;
        public string retailprice;
        public string donor;
        public string seq;
        public string hide;
        public string images;

        public string[] auctiontype_values = new string[2] { "Silent", "Live" };
        public string[] yesno_values = new string[2] { "Yes", "No" };

        public static string[] donor_ctrs = new string[100];
        public static string[] donornames = new string[100];
        int c1 = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            dim donors_ctr()
        dim donors_name()

        sqlstring = "Select * from donor order by donorname"
        rs.Open sqlstring, db
        do until rs.eof
            c1 = c1 + 1
            redim preserve donors_ctr(c1)
            redim preserve donors_name(c1)
            donors_ctr(c1) = rs("donor_ctr")
            donors_name(c1) = rs("donorname")
            rs.movenext
        loop

        */
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Donors", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = 1;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        c1++;
                        donor_ctrs[c1] = dr["donor_ctr"].ToString();
                        donornames[c1] = dr["donorname"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

            item_ctr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(item_ctr))
            {

                cmd = new SqlCommand("Get_Item", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@item_ctr", SqlDbType.Int).Value = item_ctr;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        title = dr["title"].ToString();
                        description = dr["description"].ToString();
                        auctiontype = dr["auctiontype"].ToString();
                        reserve = dr["reserve"].ToString();
                        retailprice = dr["retailprice"].ToString();
                        //donor = dr["donor"].ToString();
                        seq = dr["seq"].ToString();
                        hide = dr["hide"].ToString();
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

                string path = Server.MapPath("..\\images\\auction\\items\\" + item_ctr);
                if (Directory.Exists(path))
                {
                    images = "<tr><td><table><tr>";
                    foreach (string dirFile in Directory.GetDirectories(path))
                    {
                        foreach (string fileName in Directory.GetFiles(dirFile))
                        {
                            images += "<td><img src=\"../images/auction/items/" + item_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br />Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                        }
                    }
                    images += "</tr></table></td></tr>";
                }
            }
        }

        public static string get_donors(string item_ctr)
        {
            #region asp code
            /*
if id <> "" then
  donorctr = 0
  sqlstring = "SELECT ItemDonor.ItemDonor_CTR, ItemDonor.Donor_CTR, ItemDonor.Seq, ItemDonor.amount, Donor.DonorName " & _
              "FROM Donor INNER JOIN ItemDonor ON Donor.Donor_CTR = ItemDonor.Donor_CTR " & _
              "WHERE ItemDonor.Item_CTR = " & ID & " ORDER BY ItemDonor.Seq"
'response.write sqlstring
  rs.Open sqlstring, db
  do until rs.eof


      selectdonor = "<option value="""">Please Select</option>"
      for f1=1 to UBound(donors_ctr) '- 1
          if rs("donor_ctr") = donors_ctr(f1) then selected = " selected" else selected = ""
          selectdonor = selectdonor & "<option value=""" & donors_ctr(f1) & """" & selected & ">" & donors_name(f1) & "</option>"
      next
      donorctr = donorctr + 1
      response.write "<tr>"
      response.write "<td class=""index""><input id=""_itemdonor_ctr_" & donorctr & """ name=""_itemdonor_ctr_" & donorctr & """ type=""hidden"" value=""" & rs("itemdonor_ctr") & """>"
      response.write "<select id=""_itemdonor_donor_ctr_" & donorctr &""" name=""_itemdonor_donor_ctr_" & donorctr & """ size=""1"" required>" & selectdonor & "</select></td>"
      response.write "<td><input id=""_itemdonor_amount_" & donorctr & """ name=""_itemdonor_amount_" & donorctr & """ type=""text"" value=""" & rs("amount") & """></td>"
      'response.write "<td><a class=""delete"">Delete</a></td>"
      response.write "<td><input type=""checkbox"" id=""_itemdonor_delete_" & donorctr & """ name=""_itemdonor_delete_" & donorctr & """ value=""yes""> Delete</td>"
      response.write "</tr>"
      rs.movenext
  loop
  rs.close
end if


*/
            #endregion
            string donor_ctr;
            string itemdonor_ctr;
            string amount;
            int donorctr = 0;
            string html = "";

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Donors_for_Item", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@item_ctr", SqlDbType.Int).Value = item_ctr;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        donor_ctr = dr["donor_ctr"].ToString();
                        itemdonor_ctr = dr["itemdonor_ctr"].ToString();
                        amount = dr["amount"].ToString();

                        string selectdonor = "<option value=\">Please Select\"</option>";
                        for (int f1 = 0; f1 < donor_ctrs.Length; f1++)
                        {
                            string selected = "";
                            if (donor_ctr == donor_ctrs[f1])
                            {
                                selected = " selected";
                            }
                            selectdonor = selectdonor + "<option value=\"" + donor_ctrs[f1] + "\"" + selected + ">" + donornames[f1] + "</option>";
                        }
                        donorctr++;

                        html += "<tr>";
                        html += "<td class=\"index\"><input id=\"_itemdonor_ctr_" + donorctr + "\" name=\"_itemdonor_ctr_" + donorctr + "\" type=\"hidden\" value=\"" + itemdonor_ctr + "\">";
                        html += "<select id=\"_itemdonor_donor_ctr_" + donorctr + "\" name=\"_itemdonor_donor_ctr_" + donorctr + "\" size=\"1\" required>" + selectdonor + "</select></td>";
                        html += "<td><input id=\"_itemdonor_amount_" + donorctr + "\" name=\"_itemdonor_amount_" + donorctr + "\" type=\"text\" value=\"" + amount + "\"></td>";
                        //html += "<td><a class=""delete"">Delete</a></td>"
                        html += "<td><input type=\"checkbox\" id=\"_itemdonor_delete_" + donorctr + "\" name=\"_itemdonor_delete_" + donorctr + "\" value=\"yes\">Delete</td>";
                        html += "</tr>";
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
            return html;
        }
    }
}