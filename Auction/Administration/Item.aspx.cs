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
                    images = "<table><tr>";
                    //foreach (string dirFile in Directory.GetDirectories(path))
                    //{
                        foreach (string fileName in Directory.GetFiles(path))
                        {
                            images += "<td><img src=\"../images/auction/items/" + item_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br /> Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                        }
                    //}
                    images += "</tr></table>";
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
                        html += "<td>";
                        html += "<input id=\"_itemdonor_ctr_" + donorctr + "\" name=\"_itemdonor_ctr_" + donorctr + "\" type=\"hidden\" value=\"" + itemdonor_ctr + "\">";
                        html += "<input class=\"index\" id=\"_itemdonor_index_" + donorctr + "\" name=\"_itemdonor_index_" + donorctr + "\" type=\"hidden\" value=\"" + donorctr + "\">";
                        html += "<select id=\"_itemdonor_donor_ctr_" + donorctr + "\" name=\"_itemdonor_donor_ctr_" + donorctr + "\" size=\"1\" required>" + selectdonor + "</select>";
                        html += "</td>";
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string item_ctr = Request.Form["item_ctr"];
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_item";
            cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
            cmd.Parameters.Add("@title", SqlDbType.VarChar).Value = Request.Form["title"];
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = Request.Form["description"];
            cmd.Parameters.Add("@auctiontype", SqlDbType.VarChar).Value = Request.Form["auctiontype"];
            cmd.Parameters.Add("@reserve", SqlDbType.VarChar).Value = Request.Form["reserve"];
            cmd.Parameters.Add("@retailprice", SqlDbType.VarChar).Value = Request.Form["retailprice"];
            cmd.Parameters.Add("@seq", SqlDbType.VarChar).Value = Request.Form["seq"];
            cmd.Parameters.Add("@hide", SqlDbType.VarChar).Value = Request.Form["hide"];
            cmd.Parameters.Add("@auction", SqlDbType.VarChar).Value = 1;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    item_ctr = dr["item_ctr"].ToString();
                }
            }
            catch (Exception ex)
            {
                General.Functions.Functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            foreach (string fld in Request.Form)
            {
                if (fld.StartsWith("_itemdonor_ctr_"))
                {
                    string line = fld.Substring(15);
                    string id = Request.Form[fld];
                    string donordelete = Request.Form["_itemdonor_delete_" + line];

                    if (donordelete == "yes" && id == "0") //have added line but not put in donor, should be client side validation
                    {

                    } else
                    {
                        con = new SqlConnection(strConnString);
                        cmd = new SqlCommand();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "update_item_donor";
                        cmd.Parameters.Add("@itemdonor_ctr", SqlDbType.VarChar).Value = id;
                        cmd.Parameters.Add("@delete", SqlDbType.VarChar).Value = donordelete;
                        cmd.Parameters.Add("@item_ctr", SqlDbType.VarChar).Value = item_ctr;
                        cmd.Parameters.Add("@donor_ctr", SqlDbType.VarChar).Value = Request.Form["_itemdonor_donor_ctr_" + line];
                        cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = Request.Form["_itemdonor_amount_ctr_" + line];
                        cmd.Parameters.Add("@seq", SqlDbType.VarChar).Value = Request.Form["_itemdonor_index_" + line]; ;
                        cmd.Connection = con;
                        try
                        {
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();

                            if (dr.HasRows)
                            {
                                dr.Read();
                                //itemdonor_ctr = dr["itemdonor_ctr"].ToString();
                            }
                        }
                        catch (Exception ex)
                        {
                            General.Functions.Functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");
                        }
                        finally
                        {
                            con.Close();
                            con.Dispose();
                        }
                    }
                }
            }       
            #region aspcode
                    /*
                rs.Open "[itemdonor]", db, 1, 2
                with rs
                    for f1 = 1 to sc.forms.count
                        key = sc.forms(f1).name
                        if left(key,15) = "_itemdonor_ctr_" then
                            line = mid(key,16)
                            idid = sc.Form(key)
                            'response.write key & "," & line & "," & idid & "," & id & "<br />"
                            donordelete = sc.form("_itemdonor_delete_" + line)
                            if donordelete = "yes" and idid = 0 then

                            else

                                if idid = 0 then
                                    .AddNew
                                else
                                    'response.write "idid=" & idid & "<br />"
                                    .filter = "itemdonor_ctr = " & idid
                                end if
                                if donordelete = "yes" then
                                    'response.write "Delete<br />"
                                    .delete
                                else
                                    .fields("item_ctr") = id
                                    .fields("donor_ctr") = sc.Form("_itemdonor_donor_ctr_" & line)
                                    .fields("amount") = sc.Form("_itemdonor_amount_" & line)
                                    .fields("seq") = line
                                    .update
                                end if
                            end if
                        end if
                    next
                    .close
                end with
                     */
                    #endregion
            //don't need to go through here if it's a new item - will fix sometime
            string path = Server.MapPath("..\\images\\auction\\items\\" + item_ctr);
            string deletepath = Server.MapPath("..\\images\\auction\\items\\" + item_ctr + "\\deleted");

            foreach (string fld in Request.Form)
            {
                if (fld.StartsWith("_imgdelete_"))
                {
                    string filename = fld.Substring(11);
                    if (!Directory.Exists(deletepath))
                    {
                        Directory.CreateDirectory(deletepath);
                    }
                    int c1 = 0;
                    string newfilename = "";
                    string wpextension = System.IO.Path.GetExtension(filename);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filename);

                    do
                    {
                        c1++;
                        newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;
                    } while (File.Exists(deletepath + "\\" + newfilename));
                    File.Move(path + "\\" + filename, deletepath + "\\" + newfilename);
                }
            }

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string originalpath = Server.MapPath("..\\images\\auction\\items\\" + item_ctr + "\\originals");
            if (!Directory.Exists(originalpath))
            {
                Directory.CreateDirectory(originalpath);
            }

            foreach (HttpPostedFile postedFile in fu_images.PostedFiles)
            {
                if (postedFile.FileName != "")
                {
                    int c1 = 0;
                    string newfilename = "";
                    string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);

                    do
                    {
                        c1++;
                        newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;
                    } while (File.Exists(newfilename));

                    postedFile.SaveAs(path + "\\" + newfilename);
                    postedFile.SaveAs(originalpath + "\\" + newfilename);
                }
            }
            /*
           if all <> "" then
               response.redirect "item.asp?all=true&id=" & id
           else
               response.redirect "itemlist.asp"
           end if		
           */
            Response.Redirect("ItemList.aspx");
        }
    }
}