<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="QS2.aspx.cs" Inherits="TeOranganui.QS2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
                var person_options = '<option value="0"></option>';
                param = "../functions/data.asmx/test?myvalue=Greg";
                $.getJSON(param, function (data) {
                    alert("This should say 'Greg'.  It says : " + data.message);
                });
            });

        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
