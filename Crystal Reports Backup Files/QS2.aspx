<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="QS2.aspx.cs" Inherits="TOHW.QS2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
          <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
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
