<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="Online.Cemetery.Statistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Statistics<br /><br />
 

              <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    Total Number of Burial Records entered by the Geneologists:
                <asp:Label ID="Records6" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from burialrecords"></asp:SqlDataSource>
              <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2">
                <ItemTemplate>
                    Total Number of Burial Records entered by the Geneologists checked:
                <asp:Label ID="Records6" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from burialrecords where sextonreference is null and ischecked = 'yes'"></asp:SqlDataSource>



            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList5" runat="server" DataSourceID="SqlDataSource5">
                <ItemTemplate>
                    Total Number of Burial Records entered by the Geneologists not checked:
                <asp:Label ID="Records6" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from burialrecords where sextonreference is null and ischecked <> 'yes'"></asp:SqlDataSource>
            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList6" runat="server" DataSourceID="SqlDataSource6">
                <ItemTemplate>
                    Total Number of Burial Records entered by the Geneologists mapped:
                <asp:Label ID="Records6" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from burialrecords where sextonreference is null and GISID is not null"></asp:SqlDataSource>
            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList7" runat="server" DataSourceID="SqlDataSource7">
                <ItemTemplate>
                    Total Number of Burial Records entered by the Geneologists not mapped:
                <asp:Label ID="Records7" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList><asp:HyperLink ID="HyperLink6" runat="server"
                NavigateUrl="GenesNotMapped.aspx">Show unmatched plots</asp:HyperLink>
            <asp:SqlDataSource ID="SqlDataSource7" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=PublicCemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from burialrecords where sextonreference is null and GISID is null"></asp:SqlDataSource>

            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <p>-----------------------------------------------------------------------------------------------------------------------------</p>

            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSource3">
                <ItemTemplate>
                    Total Number of Plots entered by the Sexton:
                <asp:Label ID="Records3" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=Cemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from plot"></asp:SqlDataSource>

            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->



            <asp:DataList ID="DataList8" runat="server" DataSourceID="SqlDataSource8">
                <ItemTemplate>
                    Total Number of Plots entered by the Sexton mapped:
                <asp:Label ID="Records8" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=Cemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from plot where GISID is not null"></asp:SqlDataSource>
            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
            <asp:DataList ID="DataList9" runat="server" DataSourceID="SqlDataSource9">
                <ItemTemplate>
                    Total Number of Plots entered by the Sexton not mapped:
                <asp:Label ID="Records9" runat="server"
                    Text='<%# Eval("NumberofRecords") %>' />
                </ItemTemplate>
            </asp:DataList><asp:HyperLink ID="HyperLink3" runat="server"
                NavigateUrl="SextonNotMapped.aspx">Show unmatched plots</asp:HyperLink>
            &nbsp;<asp:SqlDataSource ID="SqlDataSource9" runat="server"
                ConnectionString="Data Source=172.16.5.49;Initial Catalog=Cemeteries;Integrated Security=False;user id=OnlineServices;password=Whanganui101"
                SelectCommand="select count(*) as 'NumberofRecords' from plot where GISID is null"></asp:SqlDataSource>

            <!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
        </div>
    </form>
</body>
</html>
