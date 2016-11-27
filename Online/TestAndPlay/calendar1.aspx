<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="calendar1.aspx.cs" Inherits="Online.TestAndPlay.calendar1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tb_dateofbirth").datepicker({
                showOn: "button",
                buttonImage: "<%: ResolveUrl("~/images/calendar.png")%>",
                buttonImageOnly: true,
                buttonText: "Select date",
                dateFormat: "d MM yy",
                changeMonth: true,
                changeYear: true,
                constrainInput: true
        });


            //$(".ui-datepicker-trigger").css("margin-right", "60px");
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="form-group">
        <label class="control-label col-sm-2" for="tb_dateofbirth">Date of birth</label>
        <div class="col-sm-10">
            <input id="tb_dateofbirth" name="tb_dateofbirth" type="date" class="form-control" value="<%: strConnString%>" />
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
