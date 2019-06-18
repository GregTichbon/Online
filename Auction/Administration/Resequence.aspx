<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Resequence.aspx.cs" Inherits="Auction.Administration.Resequence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {

            var fixHelperModified = function (e, tr) {
                //alert('here');
                var $originals = tr.children();
                var $helper = tr.clone();
                $helper.children().each(function (index) {
                    $(this).width($originals.eq(index).width())
                });
                return $helper;
            }

            updateIndex = function (e, ui) {
                $('.index', ui.item.parent()).each(function (i) {
                    $(this).val(i + 10);
                    $(this).next().text(i + 10);
                });
            };

            $(".table tbody").sortable({
                helper: fixHelperModified,
                stop: updateIndex
            });
        });  //document.ready


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="default.aspx" class="btn btn-info" role="button">Menu</a><br />
    <table class="table">
        <thead>
            <tr>
                <th>Item</th>
                <th>Seq</th>
                <th>Hide</th>
            </tr>
        </thead>
        <tbody>
            <%=html%>
        </tbody>
    </table>
     <asp:Button ID="btn_submit" myid="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
    <br />
    <br />
    <a href="default.aspx" class="btn btn-info" role="button">Menu</a>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
