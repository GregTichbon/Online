using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.Auction.Admin
{
    public partial class ItemList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region ASP CODE
            /*
  <%
      Set fso = Server.CreateObject("Scripting.FileSystemObject")
      Set db = Server.CreateObject("ADODB.Connection")
      db.Open connection_string
      Set rs = Server.CreateObject("ADODB.Recordset")
      Set rs2 = Server.CreateObject("ADODB.Recordset")
      sqlstring = "SELECT Item.Item_CTR, Item.seq, Item.Title, AuctionType.AuctionType from Item inner join AuctionType on AuctionType.AuctionType_CTR = item.auctiontype    ORDER BY AuctionType.AuctionType, Item.seq, Item.title;"
      rs.Open sqlstring, db
      do until rs.eof
          if rs("auctiontype") <> lastautiontype then
              response.write "<tr><td colspan=""4""><b>" & rs("auctiontype") & "</b></td></tr>"
              lastautiontype = rs("auctiontype")
          end if
          sqlstring = "SELECT ItemDonor.Item_CTR, Donor.DonorName " & _
              "FROM Donor INNER JOIN ItemDonor ON Donor.Donor_CTR = ItemDonor.Donor_CTR " & _
              "WHERE (((ItemDonor.Item_CTR)=" & rs("item_ctr") & ") AND ((ItemDonor.Seq)<>999) AND ((ItemDonor.Seq)<>999)) " & _
              "ORDER BY ItemDonor.Seq"
  'response.write sqlstring & "<br />" 
          rs2.Open sqlstring, db
          items = ""
          delim = ""
          do until rs2.eof
  'response.write "HERE<br />"
              items = items & delim & rs2("donorname")
              delim = "<br />"
              rs2.movenext
          loop
          rs2.close
          images = "<div class=""slideshow"" data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>"
          folder = Server.MapPath("..\images\items\" & rs("Item_CTR"))
          If fso.FolderExists(folder) = True Then
              Set fsoFolder = fso.GetFolder(folder)
              For Each fsoFile In fsoFolder.Files
                  images = images & "<img src=""../images/items/" & rs("Item_CTR") & "/" & fsoFile.Name & """ height=""80"" border=""0"">" & vbcrlf
              Next
          End If
          images = images & "</div>"
  'response.write items
          Set fsoFolder = nothing
          response.write "<tr><td><a href=item.asp?id=" & rs("item_ctr") & ">" & rs("title") & "</a><td>" & items & "</td><td>" & images & "</td><td>" & rs("seq") & "</td></tr>"
          rs.movenext
      loop
      rs.close
      set rs = nothing
      db.close
      set db = nothing
      Set fso = nothing
      %>
      */
            #endregion

            string item_ctr;
            string seq;
            string title;
            string donorname;

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Items", con);
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
                        //Item.Item_CTR, Item.seq, Item.Title, AuctionType.AuctionType
                        item_ctr = dr["item_ctr"].ToString();
                        seq = dr["seq"].ToString();
                        title = dr["title"].ToString();

                        cmd = new SqlCommand("Get_Item_Donors", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@item_ctr", SqlDbType.Int).Value = item_ctr;
                        cmd.Connection = con2;
                        try
                        {
                            con2.Open();
                            SqlDataReader dr2 = cmd.ExecuteReader();
                            if (dr2.HasRows)
                            {
                                while (dr2.Read())
                                {
                                    donorname = dr2["donorname"].ToString();
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
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Dispose();
                con.Close();
                con.Dispose();
            }

        }
    }
}