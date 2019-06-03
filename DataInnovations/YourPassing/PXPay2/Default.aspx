<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DataInnovations.YourPassing.PXPay2.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%">
        <tr>
            <td>
                Amount
            </td>
            <td>
                <asp:TextBox ID="txtAmountInput" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Currency
            </td>
            <td>
                <asp:TextBox ID="txtCurrencyInput" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Reference
            </td>
            <td>
                <asp:TextBox ID="txtMerchantReference" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Transaction type
            </td>
            <td>
                <asp:DropDownList ID="ddlTxnType" runat="server">
                    <asp:ListItem Selected="True">Purchase</asp:ListItem>
                    <asp:ListItem Value="Auth">Authorisation</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
            </td>
        </tr>
    </table>
    <asp:Panel ID="Panel1" runat="server">
    </asp:Panel>
</asp:Content>
