<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="DataInnovations.YourPassing.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Make Payment through payment gateway</h2>
    Credit Card Number: <asp:TextBox ID="tb_ccnumber" runat="server"></asp:TextBox> <br />
    Expiry Date: <asp:TextBox ID="tb_ccexpiry" runat="server"></asp:TextBox> <br />
    Name on Card: <asp:TextBox ID="tb_ccname" runat="server"></asp:TextBox> <br />
    Secutiy Code: <asp:TextBox ID="tb_ccsecuritycode" runat="server"></asp:TextBox> <br />
   


    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
</asp:Content>
