<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenesNotMapped.aspx.cs" Inherits="Online.Cemetery.GenesNotMapped" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Burial Records entered by Geneologists not mapped&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <asp:BoundField DataField="ID" HeaderText="ID"></asp:BoundField>
                    <asp:BoundField DataField="Warrant" HeaderText="Warrant" SortExpression="Warrant"></asp:BoundField>
                    <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area"></asp:BoundField>
                    <asp:BoundField DataField="Standardised Area" HeaderText="Standardised Area"></asp:BoundField>
                    <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Division" HeaderText="Division" SortExpression="Division" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Plot" HeaderText="Plot" SortExpression="Plot" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="isChecked" HeaderText="Checked" SortExpression="Checked" ReadOnly="True"></asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="White" />
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select B.ID, B.Warrant, 'Area' = B.theArea, 'Standardised Area' = TA.stdName,  'Block' = B.theBlock, 'Division' = B.theDiv, 'Plot' = B.thePlot, B.Remarks, B.isChecked from burialrecords B left outer join translate TA on TA.[type] = 'A' and TA.theName = B.theArea where B.gisid is null and sextonreference is null order by B.thearea, B.theblock, B.thediv, B.theplot"></asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
