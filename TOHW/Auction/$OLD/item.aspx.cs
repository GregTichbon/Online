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

namespace TOHW.Auction.Admin
{
    public partial class item : System.Web.UI.Page
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

        public string[] auctiontype_values = new string[2] { "Silent", "Live" };

        string[] donor_ctr = new string[100];
        string[] donorname = new string[100];
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
                        donor_ctr[c1] = dr["donor_ctr"].ToString();
                        donorname[c1] = dr["donorname"].ToString();
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

                string images = "";
                string path = Server.MapPath("..\\images\\item\\" + item_ctr);
                if (Directory.Exists(path))
                {
                    images = "<table><tr>";
                    foreach (string dirFile in Directory.GetDirectories(path))
                    {
                        foreach (string fileName in Directory.GetFiles(dirFile))
                        {
                            images += "<td><img src=\"../images/item/" + item_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br />Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                        }
                    }
                    images += "</tr></table>";

                    /*
                        folder = Server.MapPath("..\images\donor\" & id)
                        Set fso = Server.CreateObject("Scripting.FileSystemObject")
                        If fso.FolderExists(folder) = True Then
                            response.write "<table><tr>"
                            Set fsoFolder = fso.GetFolder(folder)
                            For Each fsoFile In fsoFolder.Files
                                Response.Write "<td><img src=""../images/donor/" & id & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """><br />Delete <input name=""_imgdelete_" & fsoFile.Name & """ type=""checkbox"" id=""_imgdelete_" & fsoFile.Name & """ value=""-1""></td>"
                            Next
                            response.write "</table>"
                        End If
                        Set fso = nothing
                        Set fsoFolder = nothing
                        */
                }
            }
        }
    }
}