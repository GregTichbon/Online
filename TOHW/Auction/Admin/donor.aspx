<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="donor.aspx.cs" Inherits="TOHW.Auction.Admin.donor1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
<script>
  tinymce.init({
    selector: '#Description'
  });
  
  function checkform() {
	var msg = ''
	var delim = ''
	var frm = document.form1;

	if(frm.Title.value == '') {
		msg = msg + delim + ' - Title';
		delim = '\n';
	}

	if(msg != '') {
		alert('You must enter:\n' + msg);
		return(false);
	}
}		
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%: get_donor("1") %>
</asp:Content>
