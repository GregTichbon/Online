<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReferenceNumbers.aspx.cs" Inherits="Online.Administration.ReferenceNumbers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Create Reference Numbers
    </h1>
    <%= html %>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_type">Type: </label>
        <div class="col-sm-8">
            <asp:DropDownList ID="dd_type" runat="server">
                <asp:ListItem Value="datetime">Date and Time</asp:ListItem>
                <asp:ListItem Value="guid">GUID</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_type">How Many? </label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_number" runat="server"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
