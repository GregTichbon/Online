using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.IO;
using System.Web.Configuration;

namespace TOHW.Auction
{
    public partial class Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
			response.write "<hr />" & vbcrlf
		end if
		response.write "<div class=""row"">" & vbcrlf
		for f2=0 to 2
			response.write "<div class=""col-sm-4"" >" & vbcrlf
			if f1+f2 <= realc1 then
				response.write "<div class=""mycentered"">" & vbcrlf
				response.write "<div style=""height: 50px""><h3>" & seq(f1 + f2) & ". " & title(f1 + f2) & "</h3></div>" & vbcrlf
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
				response.write "</div>" & vbcrlf
				response.write "<div style=""text-align: justify; text-justify: inter-word;"">" & description(f1 + f2) & "</div>" & vbcrlf
				response.write "<div class=""mycentered"">" & vbcrlf
				if auctiontype = 1 then
					response.write "<img class=""showitem"" id=""showitem" & id(f1 + f2) & """ src=""bidnow.png"">"
				end if
				response.write "<h3>Generously donated by</h3>" & vbcrlf
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
					response.write "<p>" & donors_Title(f1 + f2,f3) & "</p>" & vbcrlf
				next
				response.write "</div>" & vbcrlf
			end if
			response.write "</div>" & vbcrlf
		next

		response.write "</div>" & vbcrlf
	next
	set rsid = nothing	
	set rs = nothing	
	db.close	
	set db = nothing
	%>
*/

            string[] id = new string[100];
            string[] seq = new string[100];
            string[] title = new string[100];
            string[] description = new string[100];
            string[,] donors_cnt = new string[10, 2];
            string[,] donors_ID = new string[10, 2];
            string[,] donors_Title = new string[10, 2];
            string[,] donors_Images = new string[10, 2];

            int c1 = 0;


            String strConnString = ConfigurationManager.ConnectionStrings["TOHWConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("Get_Items", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@auctiontype_ctr", SqlDbType.Int).Value = 1;
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
        }
    }
}