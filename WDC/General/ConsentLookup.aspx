<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsentLookup.aspx.cs" Inherits="Online.General.ConsentLookup" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="heading">Building Consent information finder</h1>
    <p>Use this page to find out details about a building consent application</p>
    <p>
       <i> A consent ID is provided by Whanganui District Council when an application is accepted and will look similar to Bcon18/xxxx <br />
        An application reference is provided once you have completed an online application and will look similar to REFXXXXXXXXX <br />
        In either case replace X with numbers.</i>
    </p>

    
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
        <asp:ListItem Value="ram_id">Consent ID</asp:ListItem>
        <asp:ListItem Value="sphereRef">Application Reference</asp:ListItem>
    </asp:RadioButtonList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList1" EnableTheming="True" ErrorMessage="Please select a search type" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Width="221px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TextBox2" runat="server" Visible="False" Width="221px"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Search" Width="88px" OnClick="Button1_Click" PostBackUrl="~/General/ConsentLookup.aspx" />
    <br />
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" Caption="Consent Details" CellPadding="4" DataSourceID="SqlDataSource1" EmptyDataText="No details found" Height="50px" Visible="False" Width="691px" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <Fields>
            <asp:BoundField DataField="ram_process_ctr" HeaderText="ram_process_ctr" ReadOnly="True" SortExpression="ram_process_ctr" Visible="False" />
            <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True" SortExpression="Description" />
            <asp:BoundField DataField="Decision" HeaderText="Decision" ReadOnly="True" SortExpression="Decision" />
            <asp:BoundField DataField="Date Received" HeaderText="Date Received" ReadOnly="True" SortExpression="Date Received" />
            <asp:BoundField DataField="Date Accepted" HeaderText="Date Accepted" ReadOnly="True" SortExpression="Date Accepted" />
        </Fields>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Caption="Event Details" CellPadding="4" DataSourceID="SqlDataSource2" EmptyDataText="No details found" Visible="False" Width="691px" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="Event" HeaderText="Event" SortExpression="Event" />
            <asp:BoundField DataField="Date Commenced" HeaderText="Date Commenced" ReadOnly="True" SortExpression="Date Commenced" />
            <asp:BoundField DataField="Date Finalised" HeaderText="Date Finalised" ReadOnly="True" SortExpression="Date Finalised" />
            <asp:BoundField DataField="Decision" HeaderText="Decision" SortExpression="Decision" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineServicesProProdConnectionString %>" SelectCommand="GetConsentEventDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" ConvertEmptyStringToNull="False" Name="ram_id" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox2" ConvertEmptyStringToNull="False" Name="sphereRef" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
<br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineServicesProProdConnectionString %>" SelectCommand="GetOnlineConsentDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1"  ConvertEmptyStringToNull="False" Name="ram_id" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox2"  ConvertEmptyStringToNull="False" Name="sphereRef" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
<br />
    <br />

    </asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

</asp:Content>