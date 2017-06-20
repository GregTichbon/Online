<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="item.aspx.cs" Inherits="TOHW.Auction.Admin.item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        tinymce.init({
            selector: '#Description',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });

        $(document).ready(function () {

            var donorctr = $('#table_donor tr').length - 1;

            $('#add').click(function () {
                alert('here');
                var $tr = $('#table_template tr:first');
                var $clone = $tr.clone();
                donorctr = donorctr + 1;
                $clone = $clone.repeater_changer(donorctr);
                $('#table_donor tr:last').after($clone);

            });
            $('.delete').click(function () {
                $(this).closest('tr').remove();
            });



            var fixHelperModified = function (e, tr) {
                //alert('here');
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                });
                return $helper;
            },
                updateIndex = function (e, ui) {
                    //$('td.index', ui.item.parent()).each(function (i) {
                    //alert($(this).attr("id"));
                    //$(this).html(i + 1);
                    //});
                };

            $("#table_donor tbody").sortable({
                helper: fixHelperModified,
                stop: updateIndex
            });

            //$('#submit').click(function () {
            //$( window ).unload(function() {
            //	$('[name^="_donor_"]').val(function(i, v) { //index, current value
            //		return v.replace(/,/g,"\b");
            //	});
            //});
            //window.addEventListener("beforeunload", function(event) {
            //	alert("Write something clever here..");
            //});
        });

        function checkform() {
            var msg = ''
            var delim = ''
            var frm = document.form1;

            if (frm.Title.value == '') {
                msg = msg + delim + ' - Title';
                delim = '\n';
            }
            //alert(frm.AuctionType.Index);
            if (frm.AuctionType.Index == 0) {
                msg = msg + delim + ' - Auction Type';
                delim = '\n';
            }
            if (msg != '') {
                alert('You must enter:\n' + msg);
                return (false);
            }
        }
	  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
	<input name="id" id="id" type="hidden" value="<%=item_ctr%>" />
	<input name="_all" id="_all" type="hidden" value="All" />
	<table border="1" cellspacing="0" cellpadding="5">
	     <tr>
      <td>Title</td>
      <td><input type="text" name="Title" id="Title" value="<%=title%>" /></td>
    </tr>
	   <tr>
      <td>Description</td>
      <td><textarea name="Description" id="Description"><%=description%></textarea>
      </td>
    </tr>


    <tr>
      <td>Type</td>
      <td><select name="AuctionType" id="AuctionType" size="1">
	  <option value="">Please Select</option>
      <%=TOHW.Functions.Functions.populateselect(auctiontype_values, auctiontype, "None")%>
        </select>
        </td>
    </tr>
    <tr>
      <td>Reserve</td>
      <td><input type="text" name="Reserve" id="Reserve" value="<%=reserve%>" />
</td>
    </tr>
    <tr>
      <td>Retail Price</td>
      <td><input type="text" name="RetailPrice" id="RetailPrice" value="<%=retailprice%>" /></td>
    </tr>
    <tr>
      <td>Image(s)</td>
      <td><input type="file" multiple="multiple" name="file" /></td>
    </tr>
    <tr>
      <td>Sequence</td>
      <td><input type="text" name="seq" id="seq" value="<%=seq%>" /></td>
    </tr>
                <tr>
            <td>Hide</td>
            <td>
                <input type="text" name="hide" id="hide" value="<%=hide%>" /></td>
        </tr>
	<tr><td colspan="2">Donors (Drag & Drop to change order)<br />
  <table id="table_donor" border="1" width="100%" cellspacing="0" cellpadding="5">
  <thead><tr><td>Donor</td><td>Amount</td><td><a id="add">Add</a></td></tr></thead>
  <%
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
  
  %>
	</table>
	</td></tr>
	  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" id="submit" name="_Submit" value="Submit" /></td>
  </tr>
  </table>


<%
    /*
	folder = Server.MapPath("..\images\items\" & id)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(folder) = True Then
		response.write "<table><tr>"
        Set fsoFolder = fso.GetFolder(folder)
        For Each fsoFile In fsoFolder.Files
			Response.Write "<td><img src=""../images/items/" & id & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """><br />Delete <input name=""_imgdelete_" & fsoFile.Name & """ type=""checkbox"" id=""_imgdelete_" & fsoFile.Name & """ value=""-1""></td>"
        Next
		response.write "</table>"
    End If
    Set fso=nothing
    Set fsoFolder=nothing
    */

%>


<table id="table_template" style="display:none">
  <tr><td class="index"><input id="_itemdonor_ctr_" name="_itemdonor_ctr_" type="hidden" value="0" />
          <select id="_itemdonor_donor_ctr_" name="_itemdonor_donor_ctr_" size="1">
          <option value="">Please Select</option>

  
<%
/*
for f1=1 to UBound(donors_ctr) - 1
	response.write "<option value=""" & donors_ctr(f1) & """>" & donors_name(f1) & "</option>"
next
*/
%>  
  
  
      </select>  
  </td><td><input type="text" id="_itemdonor_amount_" name="_itemdonor_amount_" value="0" /></td><td>Delete</td></tr>
</table>
<code style="width:400px"><%=description%></code>

<%
    /*
	set rs = nothing	
	db.close	
	set db = nothing
    */
%>
</asp:Content>
