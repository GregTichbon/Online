<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="test1.aspx.cs" Inherits="TOHW.test1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var person_options = '<option value="0"></option>';
            param = "../functions/data.asmx/get_dropdown?type=person&param1=x";
            $.getJSON(param, function (data) {
                $.each(data, function (i, item) {
                    person_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
                alert(person_options);
            });
        });

        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>


