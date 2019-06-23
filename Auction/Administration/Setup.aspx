<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Setup.aspx.cs" Inherits="Auction.Administration.Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script type="text/javascript">
        tinymce.init({
            selector: 'textarea',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });
        $(document).ready(function () {

        }); //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <a href="default.aspx" class="btn btn-info" role="button">Menu</a><br />
    <h2>Auction Setup</h2>
    <table class="table">
        <tr>
            <td>Auction</td>
            <td>
                <input type="text" name="auction" id="auction" value="<%=auction%>" maxlength="255" /></td>
        </tr>
        <tr>
            <td>Message</td>
            <td>
                <textarea name="message" id="message"><%=message%></textarea>
                <code style="width: 400px"><%=message%></code>
        </tr>

        <tr>
            <td>Default Increment</td>
            <td>
                <input type="text" name="increment" id="increment" value="<%=increment%>" maxlength="2" /></td>

        </tr>
        <tr>
            <td>Open from</td>
            <td>
                <input type="text" name="openfrom" id="openfrom" value="<%=openfrom%>" maxlength="2" /></td>

        </tr>
        <tr>
            <td>Close at</td>
            <td>
                <input type="text" name="closeat" id="closeat" value="<%=closeat%>" maxlength="2" /></td>

        </tr>
        <tr>
            <td>Terms and Conditions</td>
            <td>
                <textarea name="termsandconditions" id="termsandconditions"><%=termsandconditions%></textarea>
                <code style="width: 400px"><%=termsandconditions%></code>
        </tr>

        <tr>
            <td>Type</td>
            <td>
                <select name="auctiontype" id="auctiontype" size="1">
                    <option value="">Please Select</option>
                    <%=General.Functions.Functions.populateselect(auctiontype_values, auctiontype, "None")%>
                </select>
            </td>
        </tr>
        <tr>
            <td>Email alerts</td>
            <td>
                <input type="text" name="emailalerts" id="emailalerts" value="<%=emailalerts%>" /></td>

        </tr>
        <tr>
            <td>Text alerts</td>
            <td>
                <input type="text" name="textalerts" id="textalerts" value="<%=textalerts%>" /></td>

        </tr>

        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </tr>
    </table>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
