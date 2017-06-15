<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Date1.aspx.cs" Inherits="TeOranganui._TestAndPlay.Date1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.greg').datetimepicker();
        });
    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Test Date</label>
        <div class="col-sm-8">
            <input type='text' class="form-control greg" id='tb_date' value="23/05/2017" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
