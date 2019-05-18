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

namespace Auction
{
    public partial class items : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            #region ASP CODE
            /*
              <%
  	dim id()
	dim seq()
	dim title()
	dim description()
	dim donors_cnt(99)
	dim donors_ID(99,20)
	dim donors_Title(99,20)
	dim donors_Images(99,20)

	Set db = Server.CreateObject("ADODB.Connection")
	db.Open connection_string
	Set rs = Server.CreateObject("ADODB.Recordset")
	Set rsid = Server.CreateObject("ADODB.Recordset")

	sqlstring = "SELECT Item.Item_CTR, Item.title, Item.Description, item.seq FROM ITEM where (seq is null or seq <> 999) and auctiontype = " & auctiontype & " ORDER BY Item.seq, Item.title;" 
	rs.Open sqlstring, db
	do until rs.eof
		c1 = c1 + 1
		redim preserve id(c1)
		redim preserve seq(c1)
		redim preserve title(c1)
		redim preserve description(c1)
		
		id(c1) = rs("item_ctr")
		seq(c1) = rs("seq")
		title(c1) = rs("title")
		description(c1) = rs("description")
		
		c2 = 0
		sqlstring = "SELECT Donor.Donor_CTR, ItemDonor.Seq, Donor.DonorName FROM Donor INNER JOIN ItemDonor ON Donor.Donor_CTR = ItemDonor.Donor_CTR " & _
					"WHERE ItemDonor.Item_CTR = " & rs("Item_CTR") & " ORDER BY ItemDonor.Seq, Donor.DonorName"
					
		rsid.Open sqlstring, db
		do until rsid.eof
			c2 = c2 + 1
			'response.write "!" & c2 & "!<br>"
			donors_ID(c1,c2) = rsid("Donor_CTR")
			donors_Title(c1,c2) = rsid("DonorName")
			
			folder = Server.MapPath("images\donor\" & rsid("Donor_CTR"))
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If fso.FolderExists(folder) = True Then
				delim = ""
				myimages = ""
				Set fsoFolder = fso.GetFolder(folder)
				For Each fsoFile In fsoFolder.Files
					myimages = myimages & delim & "<img src=""images/donor/" & rsid("Donor_CTR") & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """>"
					delim = "|"
				Next
			End If
			Set fso=nothing
			Set fsoFolder=nothing						
			donors_Images(c1,c2) = myimages
			rsid.movenext
		loop
		donors_cnt(c1) = c2
		rsid.close

		rs.movenext
	loop
	rs.close
	
	realc1 = c1
	
	do while (c1 mod 3) <> 0
		c1 = c1 + 1
	loop
	
	redim preserve id(c1)
	redim preserve seq(c1)
	redim preserve title(c1)
	redim preserve description(c1)
	
	for f1=1 to c1 step 3
		if f1 <> 1 then
			response.write "<hr />"; //& vbcrlf
		end if
		response.write "<div class=""row"">"; //& vbcrlf
		for f2=0 to 2
			response.write "<div class=""col-sm-4"" >"; //& vbcrlf
			if f1+f2 <= realc1 then
				response.write "<div class=""mycentered"">"; //& vbcrlf
				response.write "<div style=""height: 50px""><h3>" & seq(f1 + f2) & ". " & title(f1 + f2) & "</h3></div>"; //& vbcrlf
if auctiontype = 1 then
	canclick = " canclick"
else
	canclick = ""
end if
%>
				<div class="slideshow <%=canclick%>" id="viewitem<%=id(f1 + f2)%>" data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>
<%			
				folder = Server.MapPath("images\items\" & id(f1 + f2))
				Set fso = Server.CreateObject("Scripting.FileSystemObject")
				If fso.FolderExists(folder) = True Then
					Set fsoFolder = fso.GetFolder(folder)
					For Each fsoFile In fsoFolder.Files
						Response.Write "<img src=""images/items/" & id(f1 + f2) & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """>"
					Next
				End If
				Set fso=nothing
				Set fsoFolder=nothing
	%>
  </div>			
<%
				response.write "</div>"; //& vbcrlf
				response.write "<div style=""text-align: justify; text-justify: inter-word;"">" & description(f1 + f2) & "</div>"; //& vbcrlf
				response.write "<div class=""mycentered"">"; //& vbcrlf
				if auctiontype = 1 then
					response.write "<img class=""showitem"" id=""showitem" & id(f1 + f2) & """ src=""bidnow.png"">"
				end if
				response.write "<h3>Generously donated by</h3>"; //& vbcrlf
%>
				<div class="slideshow" data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>
<%			
					for f3=1 to donors_cnt(f1 + f2)
						a = Split(donors_Images(f1 + f2,f3),"|")
						for each x in a
							response.write x
						next
					next 
%>
				</div>
<%					
				for f3=1 to donors_cnt(f1 + f2)
					response.write "<p>" & donors_Title(f1 + f2,f3) & "</p>"; //& vbcrlf
				next
				response.write "</div>"; //& vbcrlf
			end if
			response.write "</div>"; //& vbcrlf
		next

		response.write "</div>"; //& vbcrlf
	next
	set rsid = nothing	
	set rs = nothing	
	db.close	
	set db = nothing
	%>
*/
            #endregion

            #region 3 column
            /*
            string[] id = new string[100];
            string[] seq = new string[100];
            string[] title = new string[100];
            string[] description = new string[100];
            int[] donors_cnt = new int[100];
            string[,] donors_ID = new string[10, 2];
            string[,] donors_Title = new string[10, 2];
            string[,] donors_Images = new string[10, 2];

            int c1 = 0;
            int auctiontype = 1;
            string canclick = "";
            if (auctiontype == 1)
            {
                canclick = " canclick";
            }
            else
            {
                canclick = "";
            }
            //string imagefolder = HttpContext.Current.Request.PhysicalApplicationPath + "auction\\images\\auction\\items";
            string imagefolder = Server.MapPath("images\\auction\\items");


            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Items", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@auctiontype_ctr", SqlDbType.Int).Value = auctiontype;
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
                        id[c1] = dr["item_ctr"].ToString();
                        seq[c1] = dr["seq"].ToString();
                        title[c1] = dr["title"].ToString();
                        description[c1] = dr["description"].ToString();

                        if(c1 == 3) { 
                        break;
                        }

                        //html += title[c1] + " - " + description[c1] + "<br />";

                        //Get code from WDC for delimited data from SP in a column.  This is for the potential of multiple donors
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
                con.Dispose();
            }

            int realc1 = 0;

            for (int f1 = 1; f1 < c1; f1 += 3)
            {
                if (f1 != 1)
                {
                    html += "<hr />";
                }
                html += "<div class=\"row\">"; //; //& vbcrlf
                for (int f2 = 0; f2 < 2; f2++)
                {
                    html += "<div class=\"col-sm-4\" >"; //; //& vbcrlf
                    if (f1 + f2 <= realc1)
                    {
                        html += "<div class=\"mycentered\">"; //& vbcrlf
                        html += "<div style=\"height: 50px\"><h3>" + seq[f1 + f2] + ". " + title[f1 + f2] + "</h3></div>"; //& vbcrlf
                    }
                    html += "<div class=\"slideshow " + canclick + " id=\"viewitem" + id[f1 + f2] + " data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>";
                    string thisimagefolder = imagefolder + "\\" + id[f1 + f2];
                    html += thisimagefolder;
                    if (Directory.Exists(thisimagefolder))
                    {
                        string[] files = Directory.GetFiles(thisimagefolder, "*.*", SearchOption.TopDirectoryOnly);
                        foreach (string filename in files)
                        {
                            string justfilename = System.IO.Path.GetFileName(filename);
                            //if (filename.EndsWith("gif") || filename.EndsWith("jpg") || filename.EndsWith("png"))
                            //{
                            html += "<img src=\"images/items/" + id[f1 + f2] + "/" + justfilename + "\" height=\"160\" border=\"0\" alt=\"" + filename + "\">";
                            //}
                        }
                    }

                    html += "</div>";
                    html += "</div>"; //& vbcrlf
                    html += "<div style=\"text-align: justify; text-justify: inter-word;\">" + description[f1 + f2] + "</div>"; //& vbcrlf
                    html += "<div class=\"mycentered\">"; //& vbcrlf
                    if (auctiontype == 1)
                    {
                        html += "<img class=\"showitem\" id=\"showitem" + id[f1 + f2] + "\" src=\"bidnow.png\">";
                    }
                    html += "<h3>Generously donated by</h3>"; //& vbcrlf
                    html += "<div class=\"slideshow\" data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>";
                    for (int f3 = 1; f3 < donors_cnt[f1 + f2]; f3++)
                    {
                        {
                            string[] a = donors_Images[f1 + f2, f3].Split('|');
                            foreach (string x in a)
                            {
                                html += "Test: " + x;
                            }
                        }
                    }
                    html += "</div>";
                    for (int f3 = 1; f3 < donors_cnt[f1 + f2]; f3++)
                    {
                        html += "<p>" + donors_Title[f1 + f2, f3] + "</p>"; //& vbcrlf
                    }
                    html += "</div>"; //& vbcrlf
                    html += "</div>"; //& vbcrlf
                }
                html += "</div>"; //& vbcrlf
            }
        }
        */
            #endregion

            Dictionary<string, string> parameters = General.Functions.Functions.get_Auction_Parameters(Request.Url.AbsoluteUri);

            string id = "";
            string seq = "";
            string title = "";
            string description = "";
            string shortdescription = "";

            string hide = "";
            string donor_ctr;
            string donors = "";
            string delim = "";
            string donorimages = "";


            int[] donors_cnt = new int[100];
            string[,] donors_ID = new string[10, 2];
            string[,] donors_Title = new string[10, 2];
            string[,] donors_Images = new string[10, 2];

            string canclick = "";
            if (parameters["AuctionType"] == "Silent")
            {
                canclick = " canclick";
            }
            //string imagefolder = HttpContext.Current.Request.PhysicalApplicationPath + "auction\\images\\auction\\items";
            string imagefolder = Server.MapPath("images\\auction" + parameters["Auction_CTR"] + "\\items");
            string donorimagefolder = Server.MapPath("images\\auction" + parameters["Auction_CTR"] + "\\donors");


            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Items", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.VarChar).Value = parameters["Auction_CTR"];
            cmd.Connection = con;
            int c1 = 0;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        c1++;
                        if (c1 < 30000)
                        {
                            id = dr["item_ctr"].ToString();
                            seq = dr["seq"].ToString();
                            title = dr["title"].ToString();
                            description = dr["description"].ToString();
                            shortdescription = dr["shortdescription"].ToString();
                            hide = dr["hide"].ToString();
                            donors = "";
                            delim = "";

                            cmd = new SqlCommand("Get_Item_Donors", con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@item_ctr", SqlDbType.Int).Value = id;
                            cmd.Connection = con2;
                            try
                            {
                                con2.Open();
                                SqlDataReader dr2 = cmd.ExecuteReader();
                                if (dr2.HasRows)
                                {
                                    while (dr2.Read())
                                    {
                                        donor_ctr = dr2["donor_ctr"].ToString();
                                        donors += delim + "<a href=\"javascript:void(0)\" class=\"donor-link donor_name\" data-id=\"" + id + "\">" + dr2["donorname"].ToString() + "</a>" + System.Environment.NewLine;
                                        delim = "<br />";
                                        donorimages = "";

                                        string thisdonorimagefolder = donorimagefolder + "\\" + id;
                                        if (Directory.Exists(thisdonorimagefolder))
                                        {
                                            string[] files = Directory.GetFiles(thisdonorimagefolder, "*.*", SearchOption.TopDirectoryOnly);
                                            foreach (string filename in files)
                                            {
                                                string justfilename = System.IO.Path.GetFileName(filename);
                                                //if (filename.EndsWith("gif") || filename.EndsWith("jpg") || filename.EndsWith("png"))
                                                //{
                                                donorimages += "<img class=\"donor-link donor_image\" data-id=\"" + id + "\" src=\"images/auction" + parameters["Auction_CTR"] + "/donors/" + id + "/" + justfilename + "\" border=\"0\" />" + System.Environment.NewLine;
                                                //}
                                            }
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
                                con2.Close();
                            }
                            //html += "<div class=\"row\">"; //; //& vbcrlf
                            //html += "<div class=\"mycentered\">"; //& vbcrlf
                            html += "<hr />";
                            html += "<div class=\"items_title\">" + title + "</div>" + System.Environment.NewLine;
                            html += "<div class=\"items_shortdescription\" > " + shortdescription + "</div>" + System.Environment.NewLine;

                            //html += "<div class=\"cycle-slideshow " + canclick + " id=\"viewitem" + id + " data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>";

                            string images = "";

                            string thisimagefolder = imagefolder + "\\" + id;
                            if (Directory.Exists(thisimagefolder))
                            {
                                string[] files = Directory.GetFiles(thisimagefolder, "*.*", SearchOption.TopDirectoryOnly);
                                foreach (string filename in files)
                                {
                                    string justfilename = System.IO.Path.GetFileName(filename);
                                    //if (filename.EndsWith("gif") || filename.EndsWith("jpg") || filename.EndsWith("png"))
                                    //{
                                    //Classes are lost because of cycle-slide  -->  Can set style on cycle-style
                                    images += "<img src=\"images/auction" + parameters["Auction_CTR"] + "/items/" + id + "/" + justfilename + "\" border=\"0\" />" + System.Environment.NewLine;
                                    //}
                                }
                            }
                            if(images != "")
                            {
                                html += "<div class=\"cycle-slideshow item-slideshow" + canclick + "\" id=\"viewitem" + id + "\" data-cycle-timeout=2000 data-cycle-log=false>" + System.Environment.NewLine;
                                html += images;
                                html += "</div>" + System.Environment.NewLine; //slideshow
                            }
                            //html += "</div>"; //mycentered
                            //html += "</div>"; //row

                            html += "<div class=\"items_donated_head\">Generously Donated by</h3>" + System.Environment.NewLine;
                            html += donors;
                            if (donorimages != "")
                            {
                                html += "<div class=\"cycle-slideshow donor-slideshow\" data-cycle-timeout=2000 data-cycle-log=false>" + System.Environment.NewLine;
                                html += donorimages;
                                html += "</div>" + System.Environment.NewLine; //slideshow
                            }

                            html += "<hr />";
                        }
                    }
                    con2.Dispose();
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
         }
    }
}
