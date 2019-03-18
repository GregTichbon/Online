<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SextonNotMapped.aspx.cs" Inherits="Online.Cemetery.SextonNotMapped" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Plots entered by Sexton not mapped&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:HyperLink ID="HyperLink1" runat="server"
            NavigateUrl="statistics.aspx">Return</asp:HyperLink>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource" PageSize="50"
                BackColor="#99CCFF" BorderColor="Black"
                BorderStyle="Solid" CellPadding="5">
                <AlternatingRowStyle BackColor="#CCFFCC" />
                <Columns>
                    <asp:BoundField DataField="Plot ID" HeaderText="Plot ID" SortExpression="PlotID"></asp:BoundField>
                    <asp:BoundField DataField="Extension Name" HeaderText="Extension Name" SortExpression="stdExtensionName"></asp:BoundField>
                    <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block"></asp:BoundField>
                    <asp:BoundField DataField="Division" HeaderText="Division" SortExpression="Division" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Plot" HeaderText="Plot" SortExpression="Plot" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" ReadOnly="True"></asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="White" />
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=Cemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select 'Plot ID' = P.PlotId, 'Extension Name' = GM.stdExtensionName, P.Block, P.Division, P.Plot, P.Remarks from plot P left outer join descriptor D on D.descriptor_type = 'Extension' and D.descriptor = P.extensionName left outer join GregMakeExtensionMatchGIS GM on GM.ExtensionName = D.name where P.gisid is null order by D.Name, P.extensionName, P.Block, P.Division, P.Plot"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
