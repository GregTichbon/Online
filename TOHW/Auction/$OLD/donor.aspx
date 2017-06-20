<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="donor.aspx.cs" Inherits="TOHW.Auction.Admin.donor" %>

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

            if (frm.Title.value == '') {
                msg = msg + delim + ' - Title';
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
    <input name="id" id="id" type="hidden" value="<%=donor_ctr%>" />
    <input name="_all" id="_all" type="hidden" value="ALL" />
    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <td>Name</td>
            <td>
                <input type="text" name="donorname" id="donorname" value="<%=donorname%>" /></td>
        </tr>
        <tr>
            <td>Description</td>
            <td>
                <textarea name="Description" id="Description"><%=description%></textarea>
            </td>
        </tr>

        <tr>
            <td>URL</td>
            <td>
                <input type="text" name="url" id="url" value="<%=url%>" /></td>
        </tr>
        <tr>
            <td>Image(s)</td>
            <td>
                <input type="file" multiple="multiple" name="file" /></td>
        </tr>
        <tr>
            <td>Sequence</td>
            <td>
                <input type="text" name="seq" id="seq" value="<%=seq%>" /></td>
        </tr>
        <tr>
            <td>Hide</td>
            <td>
                <input type="text" name="hide" id="hide" value="<%=hide%>" /></td>
        </tr>

        <tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" name="_Submit" value="Submit" /></td>
        </tr>

    </table>
</asp:Content>
